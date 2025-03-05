<script lang="ts">
  import box from "$lib/assets/box.png";
  import wave from "$lib/assets/wave.webp";
  import korg from "$lib/assets/korg.png";
  import cool from "$lib/assets/wave-cool.png";
  import fabris from "$lib/assets/wave-fabris.png";
  import korg_red from "$lib/assets/wave-korg-red.png";
  import piano from "$lib/assets/wave-piano.png";
  import toti from "$lib/assets/wave-toti.jpg";

  const carousel_images = [
    { src: box, alt: "Side profile" },
    { src: korg, alt: "Front view" },
    { src: wave, alt: "Side profile" },
    { src: cool, alt: "Side profile" },
    { src: fabris, alt: "Front view" },
    { src: korg_red, alt: "Side profile" },
    { src: piano, alt: "Side profile" },
    { src: toti, alt: "Front view" },
  ];

  let isDragging = false;
  let startPosition = 0;
  let scrollLeft = 0;
  let track: HTMLElement;

  function handleMouseDown(event: MouseEvent) {
    isDragging = true;
    startPosition = event.pageX - track.offsetLeft;
    scrollLeft = track.scrollLeft;
    track.style.cursor = "grabbing";
    track.style.animationPlayState = "paused";
  }

  function handleMouseMove(event: MouseEvent) {
    if (!isDragging) return;
    event.preventDefault();
    const x = event.pageX - track.offsetLeft;
    const walk = (x - startPosition) * 2;
    track.scrollLeft = scrollLeft - walk;
  }

  function handleMouseUp() {
    isDragging = false;
    track.style.cursor = "grab";
    track.style.animationPlayState = "running";
  }

  function handleTouchStart(event: TouchEvent) {
    isDragging = true;
    startPosition = event.touches[0].pageX - track.offsetLeft;
    scrollLeft = track.scrollLeft;
    track.style.animationPlayState = "paused";
  }

  function handleTouchMove(event: TouchEvent) {
    if (!isDragging) return;
    const x = event.touches[0].pageX - track.offsetLeft;
    const walk = (x - startPosition) * 2;
    track.scrollLeft = scrollLeft - walk;
  }

  function handleTouchEnd() {
    isDragging = false;
    track.style.animationPlayState = "running";
  }
</script>

<div class="my-8 lg:my-40 overflow-hidden">
  <h2 class="sr-only">Image carousel</h2>
  <div class="carousel-container">
    <div
      bind:this={track}
      class="carousel-track"
      on:mousedown={handleMouseDown}
      on:mousemove={handleMouseMove}
      on:mouseup={handleMouseUp}
      on:mouseleave={handleMouseUp}
      on:touchstart={handleTouchStart}
      on:touchmove={handleTouchMove}
      on:touchend={handleTouchEnd}
    >
      {#each carousel_images as image}
        <div class="carousel-item">
          <img
            src={image.src}
            alt={image.alt}
            class="rounded-lg w-full h-full object-cover"
            draggable="false"
          />
        </div>
      {/each}
      <!-- Duplicate first few items for seamless loop -->
      {#each carousel_images.slice(0, 3) as image}
        <div class="carousel-item">
          <img
            src={image.src}
            alt={image.alt}
            class="rounded-lg w-full h-full object-cover"
            draggable="false"
          />
        </div>
      {/each}
    </div>
  </div>
</div>

<style>
  .carousel-container {
    width: 100%;
    overflow: hidden;
  }

  .carousel-track {
    display: flex;
    gap: 1rem;
    cursor: grab;
    user-select: none;
    animation: scroll-mobile 20s linear infinite;
    will-change: transform;
  }

  .carousel-item {
    flex: 0 0 85%;
    min-width: 85%;
  }

  @media (min-width: 640px) {
    .carousel-track {
      gap: 1.5rem;
      animation: scroll-tablet 20s linear infinite;
    }
    .carousel-item {
      flex: 0 0 50%;
      min-width: 50%;
    }
  }

  @media (min-width: 1024px) {
    .carousel-track {
      gap: 2rem;
      animation: scroll-desktop 20s linear infinite;
    }
    .carousel-item {
      flex: 0 0 33.333%;
      min-width: 33.333%;
    }
  }

  @keyframes scroll-mobile {
    0% {
      transform: translateX(0);
    }
    100% {
      transform: translateX(-185%);
    }
  }

  @keyframes scroll-tablet {
    0% {
      transform: translateX(0);
    }
    100% {
      transform: translateX(-150%);
    }
  }

  @keyframes scroll-desktop {
    0% {
      transform: translateX(0);
    }
    100% {
      transform: translateX(-133.333%);
    }
  }

  .carousel-track:hover {
    animation-play-state: paused;
  }

  @media (prefers-reduced-motion: reduce) {
    .carousel-track {
      animation-duration: 40s;
    }
  }
</style>
