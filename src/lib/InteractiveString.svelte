<script lang="ts">
  // Control points for the string - optimized parameters
  const POINTS = 16; // More points for smoother, detailed wave
  const REST_LENGTH = 90; // Length of string in pixels
  const STRING_TENSION = 0.04; // Reduced for more fluid movement
  const MOUSE_INFLUENCE = 0.3; // Increased mouse interaction strength
  const GRAVITY = 0.005; // Minimal gravity
  const MOUSE_RADIUS = 200; // Mouse influence radius
  const DAMPING = 0.82; // Reduced damping for livelier motion
  const LINE_WIDTH = 2.0; // Slightly thicker line for better visibility
  const AUTO_WAVE_INTERVAL = 40; // More frequent auto-generated waves
  const AUDIO_WAVE_FREQUENCY = 0.5; // Base frequency for audio-like waves

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

    // Auto-generate waves periodically for more lively idle animation
    waveTimer += deltaTime;
    if (waveTimer > AUTO_WAVE_INTERVAL) {
      waveTimer = 0;
      autoWaveCounter = (autoWaveCounter + 1) % 5; // More wave patterns
      
      // Generate more audio-like wave pulses
      if (autoWaveCounter === 0) {
        // Pulse from left to right (like audio ripple)
        for (let i = 1; i < POINTS - 1; i++) {
          const delay = i * 3; // Sequential delay
          setTimeout(() => {
            if (points[i]) {
              points[i].vy += (Math.random() * 0.8 - 0.2) * 1.2;
            }
          }, delay);
        }
      } else if (autoWaveCounter === 1) {
        // Center outward pulse (like bass drop)
        const center = Math.floor(POINTS / 2);
        points[center].vy += 1.2;
        // Ripple outward effect
        for (let i = 1; i < 4; i++) {
          setTimeout(() => {
            if (points[center - i]) points[center - i].vy += 0.8;
            if (points[center + i]) points[center + i].vy += 0.8;
          }, i * 15);
        }
      } else if (autoWaveCounter === 2) {
        // Random peaks (like equalizer)
        for (let i = 1; i < POINTS - 1; i++) {
          if (Math.random() > 0.6) { // Only some points move
            points[i].vy -= 0.8 + Math.random() * 0.8;
          }
        }
      } else if (autoWaveCounter === 3) {
        // Right to left wave
        for (let i = POINTS - 2; i > 0; i--) {
          const delay = (POINTS - i) * 3;
          setTimeout(() => {
            if (points[i]) {
              points[i].vy += (Math.random() * 0.8 - 0.2) * 1.2;
            }
          }, delay);
        }
      } else {
        // Random strong pulse at random position
        const wavePoint = Math.floor(Math.random() * (POINTS - 2)) + 1;
        points[wavePoint].vy += (Math.random() > 0.5 ? 2.0 : -2.0);
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

      // Audio-like wave animations
      const time = timestamp * 0.001; // Convert to seconds
      
      // Primary wave with variable frequency to simulate audio waves
      const freq = AUDIO_WAVE_FREQUENCY * (1 + Math.sin(time * 0.08) * 0.2); // Frequency modulation
      const primaryWave = Math.sin(time * freq * 0.8 + point.phaseOffset) * 0.25 * deltaTime;
      
      // Harmonic components for richer audio-like motion
      const harmonic1 = Math.sin(time * freq * 1.5 + i * 0.4) * 0.15 * deltaTime;
      const harmonic2 = Math.sin(time * freq * 2.3 + i * 0.7) * 0.12 * deltaTime;
      
      // Low frequency oscillation like bass waves
      const bassWave = Math.sin(time * 0.1 + i * 0.2) * 0.15 * deltaTime;
      
      // Add varying horizontal movement for more dynamic behavior
      point.vx += Math.sin(time * 0.3 + i * 0.5) * 0.08 * deltaTime;
      
      // Combine waves for complex audio-like motion
      point.vy += primaryWave + harmonic1 + harmonic2 + bassWave;

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

      // Gentler return to neutral position to allow more movement
      const returnForce = 0.01 * deltaTime; // Even gentler return force for more dramatic waves
      
      // Apply dynamic breathing effect for audio-like oscillation
      const audioWaveOffset = Math.sin(time * 0.12 + i * 0.4) * 3 + Math.cos(time * 0.2 + i * 0.6) * 2;
      
      // Simulate audio visualization with more pronounced vertical movement
      point.x += (point.targetX - point.x) * returnForce;
      point.y += (point.targetY + audioWaveOffset - point.y) * returnForce;
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
