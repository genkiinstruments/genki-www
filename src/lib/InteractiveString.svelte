<script lang="ts">
  // Control points for the string - optimized for standing waves
  const POINTS = 18; // More points for smoother standing wave visualization
  const REST_LENGTH = 90; // Length of string in pixels
  const STRING_TENSION = 0.025; // Even lower tension for more dramatic oscillations
  const MOUSE_INFLUENCE = 0.5; // Stronger mouse interaction for better responsiveness
  const GRAVITY = 0.002; // Reduced gravity for better standing waves
  const MOUSE_RADIUS = 200; // Mouse influence radius
  const DAMPING = 0.85; // Lower damping for more energetic motion
  const LINE_WIDTH = 2.2; // Thicker line for better visibility
  const STANDING_WAVE_1 = 0.8; // First standing wave frequency - increased for faster animation
  const STANDING_WAVE_2 = 1.2; // Second standing wave frequency - increased for faster animation
  const STANDING_WAVE_3 = 1.5; // Third standing wave frequency - increased for faster animation

  // Constrain string movement
  const MIN_Y = 10; // Minimum Y position
  const MAX_Y = 35; // Maximum Y position

  // Canvas variables
  let canvas = $state<HTMLCanvasElement | null>(null);
  let ctx = $state<CanvasRenderingContext2D | null>(null);
  let width = REST_LENGTH + 20; // Add padding
  let height = 70; // Fixed canvas height

  // Physics state
  let points = $state<
    {
      x: number;
      y: number;
      vx: number;
      vy: number;
      targetX: number;
      targetY: number;
      phaseOffset: number;
      lastY?: number; // For motion smoothing
    }[]
  >([]);
  let mouseX = $state(-1000);
  let mouseY = $state(-1000);
  let mouseDown = $state(false);
  let clickPoint = $state(-1);
  let animationId = $state<number | null>(null);
  let lastTime = $state(0); // For time-based animation
  let waveTimer = $state(0); // For auto-generated waves
  let autoWaveCounter = $state(0); // For alternating wave patterns

  // Initial positions with audio-wave like pattern
  function generateNeutralPosition() {
    const centerY = 22; // Center position
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

    // Simplified point finding - only check distance once
    if (!canvas) return;

    const rect = canvas.getBoundingClientRect();
    const mx = e.clientX - rect.left;
    const my = e.clientY - rect.top;

    let minDist = Infinity;
    let closest = -1;

    for (let i = 1; i < POINTS - 1; i++) {
      const dx = points[i].x - mx;
      const dy = points[i].y - my;
      const dist = dx * dx + dy * dy; // Skip sqrt for performance

      if (dist < minDist) {
        minDist = dist;
        closest = i;
      }
    }

    if (minDist < 900) {
      // 30² = 900, no need for sqrt
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
    
    // Define several oscillation regions with faster frequencies and higher amplitudes
    const regions = [
      { start: 1, end: 6, frequency: STANDING_WAVE_1 + Math.sin(time * 0.15) * 0.2, amplitude: 0.025 },
      { start: 7, end: 12, frequency: STANDING_WAVE_2 + Math.cos(time * 0.12) * 0.15, amplitude: 0.030 },
      { start: 13, end: POINTS-2, frequency: STANDING_WAVE_3 + Math.sin(time * 0.18) * 0.25, amplitude: 0.028 }
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
          const timeComponent = Math.sin(time * region.frequency) * 0.7 + 
                               Math.sin(time * region.frequency * 2) * 0.2 + 
                               Math.sin(time * region.frequency * 3) * 0.1;
          
          // Modified standing wave equation with higher amplitude
          const standingWave = positionComponent * timeComponent * region.amplitude * deltaTime * 1.4;
          
          // Apply the force to create standing oscillation
          points[i].vy += standingWave;
        }
      }
    }
    
    // Standing waves naturally create nodes (points with minimal movement)
    // We'll emphasize this behavior by manually creating node points
    // Nodes occur at specific positions in standing waves based on wavelength
    
    // Create fixed nodes at the junctions between regions and at 1/2 wavelength intervals
    const nodePoints = [1, 6, 7, 12, 13, POINTS-2]; // Region boundaries become nodes
    
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

      // Handle dragging
      if (i === clickPoint && mouseDown) {
        point.x = mouseX;
        point.y = Math.max(MIN_Y, Math.min(MAX_Y, mouseY));
        point.vx = 0;
        point.vy = 0;
        continue;
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
      
      // Higher amplitude for more energetic motion
      const standingAmplitude = 0.08 * Math.sin(relativePos * Math.PI) * deltaTime; // Max amplitude in center
      
      // Faster horizontal movement
      point.vx += Math.sin(time * 0.4 + relativePos * Math.PI * 2) * 0.05 * deltaTime;
      
      // Faster harmonic oscillations with higher amplitudes
      // Higher frequency multipliers for quicker animation
      point.vy += Math.sin(time * 0.8 + relativePos * Math.PI * 5) * standingAmplitude * 1.5;

      // Stronger mouse interaction
      const mouseDistX = mouseX - point.x;
      const mouseDistY = mouseY - point.y;
      const mouseDistSq = mouseDistX * mouseDistX + mouseDistY * mouseDistY;

      if (mouseDistSq < MOUSE_RADIUS * MOUSE_RADIUS) {
        const mouseDist = Math.sqrt(mouseDistSq);
        const factor = (1 - mouseDist / MOUSE_RADIUS) * MOUSE_INFLUENCE;

        // Direct, stronger influence
        point.vx += (mouseDistX / mouseDist) * factor * 0.6 * deltaTime;
        point.vy += (mouseDistY / mouseDist) * factor * 0.8 * deltaTime;
      }

      // Apply damping and update position with slight variation
      // Use different damping values for horizontal and vertical for more interesting movement
      point.vx *= Math.pow(DAMPING + (i % 3) * 0.01, deltaTime); // Slight variation by point index
      point.vy *= Math.pow(DAMPING - 0.02, deltaTime); // Less vertical damping for more movement

      // Apply velocities with slight enhancement to movement
      point.x += point.vx;
      point.y += point.vy;

      // Constrain vertical movement
      point.y = Math.max(MIN_Y, Math.min(MAX_Y, point.y));

      // Standing waves need to maintain their positions relative to nodes
      // Use a position-dependent return force to create proper standing wave behavior
      
      // Is this point near a node?
      let isNearNode = nodePoints.some(nodeIdx => Math.abs(i - nodeIdx) <= 1);
      
      // Points near nodes return more strongly to baseline (creating nodes)
      // Points away from nodes have more freedom (creating antinodes)
      const returnForce = isNearNode ? 0.02 * deltaTime : 0.005 * deltaTime;
      
      // Faster and larger offset for more energetic standing waves
      // The main oscillation comes from the standing wave physics
      const standingWaveOffset = Math.sin(time * 0.4 + i * Math.PI / POINTS) * 2.5;
      
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
    const gradient = ctx.createLinearGradient(0, height/2 - 15, 0, height/2 + 15);
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

  // Lazy initialization for better page load performance
  let isInitialized = false;

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

    // Generate points
    generateNeutralPosition();

    // Start animation
    animationId = requestAnimationFrame(updateString);

    // Add event listeners
    canvas.addEventListener("mousemove", handleMouseMove);
    canvas.addEventListener("mousedown", handleMouseDown);
    window.addEventListener("mouseup", handleMouseUp);
    canvas.addEventListener("mouseleave", handleMouseLeave);

    isInitialized = true;
  }

  $effect(() => {
    // Defer initialization until after initial render
    if (canvas && !isInitialized) {
      // Use requestIdleCallback or setTimeout for better initial page load
      if (typeof window !== "undefined" && "requestIdleCallback" in window) {
        (window as any).requestIdleCallback(() => initializeAnimation());
      } else {
        setTimeout(initializeAnimation, 100); // Small delay for better page load
      }
    }

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

<div class="h-auto w-auto overflow-visible">
  <canvas bind:this={canvas} {width} {height} class="cursor-pointer overflow-visible"></canvas>
</div>
