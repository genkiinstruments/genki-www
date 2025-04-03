<script lang="ts">
  // Control points for the string - optimized parameters
  const POINTS = 10; // Reduced number of control points
  const REST_LENGTH = 90; // Length of string in pixels
  const STRING_TENSION = 0.055; // Increased for more responsive shape recovery
  const MOUSE_INFLUENCE = 0.25; // Significantly increased for stronger mouse interaction
  const GRAVITY = 0.01; // Minimal gravity
  const MOUSE_RADIUS = 200; // Mouse influence radius
  const DAMPING = 0.85; // Damping for smooth motion
  const LINE_WIDTH = 2.8; // Width of the string in pixels

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

  // Initial positions with Joy Division pattern
  function generateNeutralPosition() {
    const centerY = 22; // Center position
    const newPoints = [];

    for (let i = 0; i < POINTS; i++) {
      const progress = i / (POINTS - 1);
      const x = 10 + progress * REST_LENGTH;

      // Simplified wave pattern with fewer calculations
      const primaryWave = Math.sin(progress * Math.PI * 2) * 12;
      const secondaryWave = Math.sin(progress * Math.PI * 6) * 5;

      // Basic initial position
      const y = centerY + primaryWave + secondaryWave * 0.5;
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

      // Simplified idle animation - fewer calculations
      const time = timestamp * 0.001; // Convert to seconds
      const idleMovement = Math.sin(time * 0.3 + point.phaseOffset) * 0.12 * deltaTime;
      point.vy += idleMovement;

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

      // Apply damping and update position
      point.vx *= Math.pow(DAMPING, deltaTime);
      point.vy *= Math.pow(DAMPING, deltaTime);

      point.x += point.vx;
      point.y += point.vy;

      // Constrain vertical movement
      point.y = Math.max(MIN_Y, Math.min(MAX_Y, point.y));

      // Gentle return to neutral position
      const returnForce = 0.03 * deltaTime;
      point.x += (point.targetX - point.x) * returnForce;
      point.y += (point.targetY - point.y) * returnForce;
    }

    // Optimized rendering - one path, no intermediate variables
    ctx.beginPath();
    ctx.moveTo(points[0].x, points[0].y);

    for (let i = 1; i < POINTS; i++) {
      const xc = (points[i].x + points[i - 1].x) * 0.5;
      const yc = (points[i].y + points[i - 1].y) * 0.5;
      ctx.quadraticCurveTo(points[i - 1].x, points[i - 1].y, xc, yc);
    }

    ctx.strokeStyle = "rgba(255, 255, 255, 0.9)";
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
