<script lang="ts">
  import { onMount } from "svelte";

  // Control points for the string - optimized for standing waves
  const POINTS = 12; // More points for smoother standing wave visualization
  const REST_LENGTH = 90; // Length of string in pixels
  const STRING_TENSION = 0.025; // Even lower tension for more dramatic oscillations
  const MOUSE_INFLUENCE = 0.5; // Stronger mouse interaction for better responsiveness
  const GRAVITY = 0.002; // Reduced gravity for better standing waves
  const MOUSE_RADIUS = 200; // Mouse influence radius
  const DAMPING = 0.92; // Higher damping to make waves die out faster after interaction
  const LINE_WIDTH = 1.7; // Thicker line for better visibility
  const STANDING_WAVE_1 = 0.8; // First standing wave frequency - increased for faster animation
  const STANDING_WAVE_2 = 1.2; // Second standing wave frequency - increased for faster animation
  const STANDING_WAVE_3 = 1.5; // Third standing wave frequency - increased for faster animation

  const height = 35; // Much smaller height for better alignment with text

  // Significantly reduced range for very tight vertical animation
  const MIN_Y = height / 2 - 2; // Very narrow range for minimal height
  const MAX_Y = height / 2 + 10; // Very narrow range for minimal height

  // Canvas variables
  let canvas: HTMLCanvasElement | null = null;
  let ctx: CanvasRenderingContext2D | null = null;
  const width = REST_LENGTH + 20; // Add padding

  // Physics state
  let points: { y: number; x: number; vy: number; vx: number; targetX: number; targetY: number }[] = [];
  let mouseX = -1000;
  let mouseY = -1000;
  let mouseDown = false;
  let clickPoint = -1;
  let animationId: number | null = null;
  let lastTime = 0; // For time-based animation

  // Initial positions with audio-wave like pattern
  function generateNeutralPosition() {
    const centerY = height / 2; // Center position exactly in the middle of our 30px height
    const newPoints = [];

    for (let i = 0; i < POINTS; i++) {
      const progress = i / (POINTS - 1);
      const x = 10 + progress * REST_LENGTH;

      // Audio-wave like pattern with multiple frequency components
      // Similar to a sound wave with harmonics
      const fundamental = Math.sin(progress * Math.PI * 2) * 4;
      const harmonic1 = Math.sin(progress * Math.PI * 4) * 2.5;
      const harmonic2 = Math.sin(progress * Math.PI * 8) * 1.5;
      const harmonic3 = Math.sin(progress * Math.PI * 16) * 0.8;

      // Combine harmonics to create a more complex waveform
      const y = centerY + fundamental + harmonic1 + harmonic2 + harmonic3;
      const phaseOffset = Math.random() * Math.PI * 2;

      newPoints.push({
        x,
        y,
        vx: 0,
        vy: 0,
        targetX: x,
        targetY: y,
        phaseOffset,
        lastY: y,
      });
    }

    points = newPoints;
  }

  // Optimized mouse movement handler
  function handleMouseMove(e: MouseEvent) {
    if (!canvas) return;
    const rect = canvas.getBoundingClientRect();
    mouseX = e.clientX - rect.left;
    mouseY = e.clientY - rect.top;
  }

  function handleMouseDown(e: MouseEvent) {
    mouseDown = true;

    if (!canvas) return;

    const rect = canvas.getBoundingClientRect();
    const mx = e.clientX - rect.left;
    const my = e.clientY - rect.top;

    // Instead of grabbing a specific point, we'll create an energy injection
    // This will cause an energetic ripple throughout the string

    // Find the nearest point, but we won't directly control it
    let minDist = Infinity;
    let closest = -1;

    for (let i = 1; i < POINTS - 1; i++) {
      const dx = points[i].x - mx;
      const dy = points[i].y - my;
      const dist = dx * dx + dy * dy;

      if (dist < minDist) {
        minDist = dist;
        closest = i;
      }
    }

    // If close enough to any point
    if (minDist < 2500) {
      // Increased radius for better interaction
      // Add energy to all points, with maximum at the closest point
      for (let i = 1; i < POINTS - 1; i++) {
        // Calculate distance from click to this point
        const dx = points[i].x - mx;
        const dy = points[i].y - my;
        const dist = Math.sqrt(dx * dx + dy * dy);

        // Energy falls off with distance
        const energyFactor = Math.exp(-dist * 0.05);

        // Add a more gentle burst of energy in a wave-like pattern
        // More controlled burst with scaled magnitude
        const direction = my < points[i].y ? -1 : 1; // Direction based on click position
        const burstMagnitude = Math.min(2.0, Math.max(0.7, 1.5 * (1 - my / height))); // More energy at top but less overall
        points[i].vy += direction * energyFactor * burstMagnitude;

        // Add minimal horizontal component for more interesting motion
        // Very slight horizontal movement to focus on vertical wave patterns
        points[i].vx += (Math.random() * 0.8 - 0.4) * energyFactor * 0.4;
      }

      // Store clicked point for potential follow-up interactions
      clickPoint = closest;
    }
  }

  function handleMouseUp() {
    mouseDown = false;
    clickPoint = -1;
  }

  function handleMouseLeave() {
    mouseX = -1000;
    mouseY = -1000;
  }

  // Optimized string physics calculation and rendering
  function updateString(timestamp: number) {
    if (!ctx) return;

    // Calculate delta time for smoother animation
    const deltaTime = lastTime ? Math.min((timestamp - lastTime) / 16.67, 2.0) : 1.0; // Cap at 2x normal speed
    lastTime = timestamp;

    // Clear canvas - only clear what's needed
    ctx.clearRect(0, 0, width, height);

    // Instead of discrete wave pulses, use continuous standing oscillations
    // Each section of the string has its own frequency and phase
    const time = timestamp * 0.001; // Convert to seconds

    // Define several oscillation regions with reduced amplitudes
    const regions = [
      { start: 1, end: 6, frequency: STANDING_WAVE_1 + Math.sin(time * 0.15) * 0.2, amplitude: 0.018 },
      { start: 7, end: 12, frequency: STANDING_WAVE_2 + Math.cos(time * 0.12) * 0.15, amplitude: 0.022 },
      { start: 13, end: POINTS - 2, frequency: STANDING_WAVE_3 + Math.sin(time * 0.18) * 0.25, amplitude: 0.02 },
    ];

    // Apply continuous standing oscillations to each region
    for (const region of regions) {
      for (let i = region.start; i <= region.end; i++) {
        if (i >= 1 && i < POINTS - 1) {
          // Create a faster standing wave pattern with multiple harmonics
          // Standing waves have this pattern: A * sin(kx) * sin(ωt)
          // where k is wave number, x is position, ω is angular frequency, t is time
          const normalizedPosition = (i - region.start) / (region.end - region.start); // 0 to 1
          const waveNumber = Math.PI * 2; // One full wave in each region

          // Add multiple harmonics for richer, faster motion
          const positionComponent = Math.sin(waveNumber * normalizedPosition);
          // Use higher frequencies for faster animation
          const timeComponent = Math.sin(time * region.frequency) * 0.7 + Math.sin(time * region.frequency * 2) * 0.2 + Math.sin(time * region.frequency * 3) * 0.1;

          // Modified standing wave equation with reduced amplitude
          const standingWave = positionComponent * timeComponent * region.amplitude * deltaTime * 1.0;

          // Apply the force to create standing oscillation
          points[i].vy += standingWave;
        }
      }
    }

    // Standing waves naturally create nodes (points with minimal movement)
    // We'll emphasize this behavior by manually creating node points
    // Nodes occur at specific positions in standing waves based on wavelength

    // Create fixed nodes at the junctions between regions and at 1/2 wavelength intervals
    const nodePoints = [1, 6, 7, 12, 13, POINTS - 2]; // Region boundaries become nodes

    // Also add nodes at specific wavelength divisions within each region
    for (let r = 0; r < regions.length; r++) {
      const region = regions[r];
      // Add a node at the middle of each region
      const midPoint = Math.floor((region.start + region.end) / 2);
      if (!nodePoints.includes(midPoint)) {
        nodePoints.push(midPoint);
      }
    }

    // Apply node behavior - nodes have minimal movement
    for (const nodeIdx of nodePoints) {
      if (nodeIdx >= 1 && nodeIdx < POINTS - 1) {
        // Nodes have restricted movement - multiply by a small factor
        points[nodeIdx].vy *= 0.3;
        points[nodeIdx].vx *= 0.3;
      }
    }

    // Update physics - avoid creating new arrays
    for (let i = 1; i < POINTS - 1; i++) {
      const point = points[i];

      // Changed from direct dragging to gentler interactive energy control
      if (i === clickPoint && mouseDown) {
        // Instead of directly setting position, add energy in the direction of mouse movement
        const targetY = Math.max(MIN_Y + 5, Math.min(MAX_Y - 5, mouseY));
        const moveForce = (targetY - point.y) * 0.12; // Gentler force for less dramatic movement

        // Apply force toward mouse position, but don't directly set position
        point.vy += moveForce;

        // More restrictive velocity limits for controlled movement
        point.vy = Math.max(-6, Math.min(6, point.vy));

        // Allow some horizontal movement for more natural feel
        point.vx *= 0.92; // Stronger dampening of horizontal movement

        // Don't skip other physics updates
      }

      // Apply simplified tension forces
      const prevPoint = points[i - 1];
      const nextPoint = points[i + 1];

      // Apply tension between points
      point.vx += (prevPoint.x - point.x) * STRING_TENSION * deltaTime;
      point.vy += (prevPoint.y - point.y) * STRING_TENSION * deltaTime;
      point.vx += (nextPoint.x - point.x) * STRING_TENSION * deltaTime;
      point.vy += (nextPoint.y - point.y) * STRING_TENSION * deltaTime;

      // Apply minimal gravity
      point.vy += GRAVITY * deltaTime;

      // Faster oscillations with more energy
      // Add energy through harmonics at higher frequencies

      // Position-dependent parameters for harmonics
      const relativePos = i / (POINTS - 1); // 0 to 1 along the string

      // Reduced amplitude for more subtle motion
      const standingAmplitude = 0.05 * Math.sin(relativePos * Math.PI) * deltaTime; // Lower amplitude

      // Gentler horizontal movement
      point.vx += Math.sin(time * 0.4 + relativePos * Math.PI * 2) * 0.03 * deltaTime;

      // Faster harmonic oscillations but with lower amplitudes
      // Higher frequency multipliers for quicker animation
      point.vy += Math.sin(time * 0.8 + relativePos * Math.PI * 5) * standingAmplitude * 1.0;

      // Enhanced interaction that affects the wave properties globally
      const mouseDistX = mouseX - point.x;
      const mouseDistY = mouseY - point.y;
      const mouseDistSq = mouseDistX * mouseDistX + mouseDistY * mouseDistY;

      if (mouseDistSq < MOUSE_RADIUS * MOUSE_RADIUS) {
        const mouseDist = Math.sqrt(mouseDistSq);
        const factor = (1 - mouseDist / MOUSE_RADIUS) * MOUSE_INFLUENCE;

        // Calculate relative position in the wave
        const relativePos = i / (POINTS - 1);

        // Instead of direct displacement, use mouse position to:
        // 1. Amplify the wave at that position (amplitude modulation)
        // 2. Modulate the frequency (frequency modulation)

        // Amplify nearby wave sections rather than direct displacement
        // Use controlled amplification to prevent excessive growth
        const amplificationFactor = 1.0 + factor * 1.5;

        // The closer to the mouse, the more the oscillation gets boosted
        // Limit maximum boost to prevent too much growth
        point.vy *= Math.min(amplificationFactor, 1.8);

        // Add energy at harmonic frequencies - makes it come alive
        const mouseFrequencyFactor = 1.5 + (mouseY / height) * 3.0; // Mouse Y controls frequency
        const mouseHarmonic = Math.sin(time * mouseFrequencyFactor + relativePos * Math.PI * 3) * factor * 0.8 * deltaTime;

        // Add this energy to the wave with better scaling based on mouse position
        // More responsive but less likely to exceed bounds
        const verticalScaling = Math.min(2.5, Math.max(0.8, (2.0 * (height - mouseY)) / height));
        point.vy += mouseHarmonic * verticalScaling;

        // Create a wave-like ripple effect from interaction point
        const ripplePhase = mouseDist * 0.1 - time * 5;
        const rippleWave = Math.sin(ripplePhase) * Math.exp(-mouseDist * 0.02) * factor * 0.6 * deltaTime;

        // Apply to both axes but with reduced effect
        point.vx += rippleWave * 0.5;
        point.vy += rippleWave * 0.8;
      }

      // Apply stronger damping to make waves die out faster when not interacting
      // Higher damping especially when far from mouse or after interaction stops
      const isInteracting = mouseDistSq < MOUSE_RADIUS * MOUSE_RADIUS * 4 || mouseDown;
      const baseDamping = isInteracting ? DAMPING - 0.05 : DAMPING + 0.02; // Less damping during interaction

      // Apply damping with variation
      point.vx *= Math.pow(baseDamping + (i % 3) * 0.01, deltaTime); // Slight variation by point index
      point.vy *= Math.pow(baseDamping, deltaTime); // Same damping for vertical

      // Apply velocities with slight enhancement to movement
      point.x += point.vx;
      point.y += point.vy;

      // Constrain vertical movement
      point.y = Math.max(MIN_Y, Math.min(MAX_Y, point.y));

      // Standing waves need to maintain their positions relative to nodes
      // Use a position-dependent return force to create proper standing wave behavior

      // Is this point near a node?
      let isNearNode = nodePoints.some((nodeIdx) => Math.abs(i - nodeIdx) <= 1);

      // Points near nodes return more strongly to baseline (creating nodes)
      // Points away from nodes have more freedom (creating antinodes)
      const returnForce = isNearNode ? 0.02 * deltaTime : 0.005 * deltaTime;

      // More moderate offset for gentler standing waves
      // The main oscillation comes from the standing wave physics
      const standingWaveOffset = Math.sin(time * 0.4 + (i * Math.PI) / POINTS) * 1.5;

      // Maintain horizontal position precisely for proper standing wave
      point.x += (point.targetX - point.x) * returnForce * 2;
      // Allow vertical oscillation with subtle offset
      point.y += (point.targetY + standingWaveOffset - point.y) * returnForce;
    }

    // Optimized rendering - one path, no intermediate variables
    ctx.beginPath();
    ctx.moveTo(points[0].x, points[0].y);

    for (let i = 1; i < POINTS; i++) {
      const xc = (points[i].x + points[i - 1].x) * 0.5;
      const yc = (points[i].y + points[i - 1].y) * 0.5;
      ctx.quadraticCurveTo(points[i - 1].x, points[i - 1].y, xc, yc);
    }

    // Create gradient for audio-wave like appearance
    const gradient = ctx.createLinearGradient(0, height / 2 - 15, 0, height / 2 + 15);
    gradient.addColorStop(0, "rgba(255, 255, 255, 0.9)");
    gradient.addColorStop(0.5, "rgba(255, 255, 255, 1.0)");
    gradient.addColorStop(1, "rgba(255, 255, 255, 0.9)");

    ctx.strokeStyle = gradient;
    ctx.lineWidth = LINE_WIDTH;
    ctx.lineCap = "round";
    ctx.lineJoin = "round";
    ctx.stroke();

    // Continue animation
    animationId = requestAnimationFrame(updateString);
  }

  // Initial loading state
  let isInitialized = false;

  // Simplified placeholder until fully loaded
  function drawPlaceholder() {
    if (!canvas || !ctx) return;

    ctx.clearRect(0, 0, width, height);
    ctx.beginPath();
    ctx.moveTo(10, height / 2); // Center position at 15px (half of 30px height)
    ctx.lineTo(10 + REST_LENGTH, height / 2);
    ctx.lineWidth = LINE_WIDTH;
    ctx.strokeStyle = "rgba(255, 255, 255, 1.0)";
    ctx.stroke();
  }

  function initializeAnimation() {
    if (isInitialized || !canvas) return;

    // Initialize Canvas
    ctx = canvas.getContext("2d", { alpha: true });

    // Optimize canvas for performance
    const dpr = window.devicePixelRatio || 1;
    canvas.width = width * dpr;
    canvas.height = height * dpr;
    canvas.style.width = `${width}px`;
    canvas.style.height = `${height}px`;
    ctx?.scale(dpr, dpr);

    // Draw placeholder immediately
    drawPlaceholder();

    // Generate points in the background
    setTimeout(() => {
      generateNeutralPosition();

      // Start animation
      animationId = requestAnimationFrame(updateString);

      // Add event listeners
      canvas?.addEventListener("mousemove", handleMouseMove);
      canvas?.addEventListener("mousedown", handleMouseDown);
      window.addEventListener("mouseup", handleMouseUp);
      canvas?.addEventListener("mouseleave", handleMouseLeave);

      isInitialized = true;
    }, 50); // Much shorter delay for background init
  }

  onMount(() => {
    // Initialize immediately
    if (canvas && !isInitialized) {
      initializeAnimation();
    }
  });

  // React to canvas changes
  $effect(() => {
    if (canvas && !isInitialized) {
      initializeAnimation();
    }
  });

  onMount(() => {
    // Cleanup on unmount
    return () => {
      if (animationId !== null) {
        cancelAnimationFrame(animationId);
      }
      if (canvas && isInitialized) {
        canvas.removeEventListener("mousemove", handleMouseMove);
        canvas.removeEventListener("mousedown", handleMouseDown);
        window.removeEventListener("mouseup", handleMouseUp);
        canvas.removeEventListener("mouseleave", handleMouseLeave);
      }
    };
  });
</script>

<div class="flex h-[{height}px] w-auto items-center overflow-visible">
  <canvas bind:this={canvas} {width} {height} class="block cursor-pointer overflow-visible"></canvas>
</div>
