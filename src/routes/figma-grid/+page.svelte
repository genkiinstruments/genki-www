<script lang="ts">
  // ... (keep all your existing script content) ...
  import logo from "$lib/assets/logo.svg";
  import katla from "$lib/assets/Katla_Placeholder.png";
  import wave from "$lib/assets/Wave_Main.png";
  import wavefront from "$lib/assets/Wavefront_Main.png";

  import wavefront_bg from "$lib/assets/wavefront-bg.png";
  import wave_bg from "$lib/assets/wave-bg.png";
  import katla_bg from "$lib/assets/katla-bg.png";

  import katla_logo from "$lib/assets/katla-logo.png";
  import learn_more from "$lib/assets/learn-more.png";

  import arrow from "$lib/assets/arrow.svg";
  import dot from "$lib/assets/dot.svg";

  import { onMount } from "svelte";
  import { fade, fly } from "svelte/transition";
  import { cubicInOut } from "svelte/easing";
  import * as Carousel from "$lib/components/ui/carousel/index.js";
  import Autoplay from "embla-carousel-autoplay";

  // Carousel setup
  let currentIndex = $state(0);
  const carouselPlugin = Autoplay({ delay: 4000, stopOnInteraction: true, stopOnMouseEnter: true });
  import { type CarouselAPI } from "$lib/components/ui/carousel/context.js";
  let api = $state<CarouselAPI>();

  // Track if user is currently interacting with navigation
  let userInteracting = $state(false);

  // Helper to reset autoplay when needed
  function resetAutoplay() {
    if (api?.plugins()?.autoplay) {
      api.plugins().autoplay.reset();
    }
  }

  // Listen for carousel changes
  function setupCarouselListeners() {
    if (api && api.on) {
      // Only update from autoplay, not from manual navigation
      api.on("select", () => {
        if (!userInteracting) {
          currentIndex = api?.selectedScrollSnap();
        }
      });
    }
  }

  // Animation state for arrow keys
  let leftArrowActive = $state(false);
  let rightArrowActive = $state(false);

  // Product slide data
  const slides = [
    {
      title: "KATLA",
      description: "Five-voice polyphonic synth, made from the ashes of Katla.",
      image: katla,
      background: katla_bg,
      logo: katla_logo,
      href: "/katla",
    },
    {
      title: "WAVE",
      description: "Control your sound, shape effects and send commands with the Wave ring.",
      image: wave,
      background: wave_bg,
      logo: null,
      href: "/wave",
    },
    {
      title: "WAVEFRONT",
      description: "The Wavefront instantly elevates any modular setup.",
      image: wavefront,
      background: wavefront_bg,
      logo: null,
      href: "/wavefront",
    },
  ];

  // For hover-based dropdown
  let hardwareHovered = $state(false);
  let softwareHovered = $state(false);

  // Define hardware and software dropdown content
  const hardware = [
    {
      href: "/wave",
      title: "Wave",
      content: "The ring for music",
    },
    {
      href: "/wavefront",
      title: "Wavefront",
      content: "Move your Eurorack",
    },
    {
      href: "/katla",
      title: "Katla",
      content: "Happy-accident machine",
    },
  ];

  const software = [
    {
      title: "Softwave",
      href: "/softwave",
      content: "Customize your Wave",
    },
    {
      title: "Wave for Work",
      href: "/wave-for-work",
      content: "Wave as a peripheral",
    },
    {
      title: "Cosmos",
      href: "/cosmos",
      content: "Cosmos is the",
    },
  ];

  function scrollCarouselPrev() {
    userInteracting = true;
    currentIndex = (currentIndex - 1 + slides.length) % slides.length;
    resetAutoplay();
    setTimeout(() => {
      userInteracting = false;
    }, 500);
  }

  function scrollCarouselNext() {
    userInteracting = true;
    currentIndex = (currentIndex + 1 + slides.length) % slides.length;
    resetAutoplay();
    setTimeout(() => {
      userInteracting = false;
    }, 500);
  }

  // Track if listeners have been set up
  let listenersSetup = $state(false);

  $effect(() => {
    if (api) {
      // Scroll to current index when it changes
      api.scrollTo(currentIndex);

      // Set up listeners once
      if (!listenersSetup) {
        setupCarouselListeners();
        listenersSetup = true;
      }
    }
  });

  // Reactive background image that updates when currentIndex changes
  let backgroundImage = $derived(slides[currentIndex].background);

  // Grid toggle
  let showGrid = $state(false);

  // Responsive handling
  let isMobile = $state(false);

  // Handle swipe gestures
  let touchStartX = 0;
  let touchEndX = 0;

  function handleTouchStart(e: TouchEvent) {
    touchStartX = e.changedTouches[0].screenX;
  }

  function handleTouchEnd(e: TouchEvent) {
    touchEndX = e.changedTouches[0].screenX;
    handleSwipe();
  }

  function handleSwipe() {
    // Detect swipe direction and minimum distance (50px)
    if (touchEndX < touchStartX - 50) {
      // Swipe left - go next
      userInteracting = true;
      scrollCarouselNext();
    }

    if (touchEndX > touchStartX + 50) {
      // Swipe right - go previous
      userInteracting = true;
      scrollCarouselPrev();
    }
  }

  onMount(() => {
    const handleKeyDown = (event) => {
      if (event.key === "'") {
        showGrid = !showGrid;
      }

      // Arrow keys for navigation
      if (event.key === "ArrowRight") {
        userInteracting = true;
        rightArrowActive = true;
        scrollCarouselNext();
        setTimeout(() => {
          rightArrowActive = false;
        }, 150); // Match the animation duration
      }

      if (event.key === "ArrowLeft") {
        userInteracting = true;
        leftArrowActive = true;
        scrollCarouselPrev();
        setTimeout(() => {
          leftArrowActive = false;
        }, 150); // Match the animation duration
      }
    };

    window.addEventListener("keydown", handleKeyDown);

    // Check if we need to adapt layout for mobile
    const handleResize = () => {
      isMobile = window.innerWidth < 768;
    };

    window.addEventListener("resize", handleResize);
    handleResize(); // Initial check

    return () => {
      window.removeEventListener("keydown", handleKeyDown);
      window.removeEventListener("resize", handleResize);
    };
  });
</script>

<svelte:head>
  <!-- ... (keep head content) ... -->
  <link href="https://db.onlinewebfonts.com/c/860c3ec7bbc5da3e97233ccecafe512e?family=Circular+Std+Book" rel="stylesheet" type="text/css" />
  <style>
    @font-face {
      font-family: "Circular Std Book";
      src: url("https://db.onlinewebfonts.com/t/860c3ec7bbc5da3e97233ccecafe512e.eot");
      src:
        url("https://db.onlinewebfonts.com/t/860c3ec7bbc5da3e97233ccecafe512e.eot?#iefix") format("embedded-opentype"),
        url("https://db.onlinewebfonts.com/t/860c3ec7bbc5da3e97233ccecafe512e.woff2") format("woff2"),
        url("https://db.onlinewebfonts.com/t/860c3ec7bbc5da3e97233ccecafe512e.woff") format("woff"),
        url("https://db.onlinewebfonts.com/t/860c3ec7bbc5da3e97233ccecafe512e.ttf") format("truetype"),
        url("https://db.onlinewebfonts.com/t/860c3ec7bbc5da3e97233ccecafe512e.svg#Circular Std Book") format("svg");
      font-weight: normal;
      font-style: normal;
    }

    @font-face {
      font-family: "Circular Std";
      src: url("https://db.onlinewebfonts.com/t/860c3ec7bbc5da3e97233ccecafe512e.eot");
      src:
        url("https://db.onlinewebfonts.com/t/860c3ec7bbc5da3e97233ccecafe512e.eot?#iefix") format("embedded-opentype"),
        url("https://db.onlinewebfonts.com/t/860c3ec7bbc5da3e97233ccecafe512e.woff2") format("woff2"),
        url("https://db.onlinewebfonts.com/t/860c3ec7bbc5da3e97233ccecafe512e.woff") format("woff"),
        url("https://db.onlinewebfonts.com/t/860c3ec7bbc5da3e97233ccecafe512e.ttf") format("truetype"),
        url("https://db.onlinewebfonts.com/t/860c3ec7bbc5da3e97233ccecafe512e.svg#Circular Std Book") format("svg");
      font-weight: normal;
      font-style: normal;
    }

    @font-face {
      font-family: "Circular Std";
      src: url("https://db.onlinewebfonts.com/t/961a181da27e7cbc072ec2fb5bbfe2a9.eot");
      src:
        url("https://db.onlinewebfonts.com/t/961a181da27e7cbc072ec2fb5bbfe2a9.eot?#iefix") format("embedded-opentype"),
        url("https://db.onlinewebfonts.com/t/961a181da27e7cbc072ec2fb5bbfe2a9.woff2") format("woff2"),
        url("https://db.onlinewebfonts.com/t/961a181da27e7cbc072ec2fb5bbfe2a9.woff") format("woff"),
        url("https://db.onlinewebfonts.com/t/961a181da27e7cbc072ec2fb5bbfe2a9.ttf") format("truetype"),
        url("https://db.onlinewebfonts.com/t/961a181da27e7cbc072ec2fb5bbfe2a9.svg#Circular Std Medium") format("svg");
      font-weight: 500;
      font-style: normal;
    }

    @font-face {
      font-family: "Circular Std";
      src: url("https://db.onlinewebfonts.com/t/56855be2ba5bb40d6c2be889b8a96ca3.eot");
      src:
        url("https://db.onlinewebfonts.com/t/56855be2ba5bb40d6c2be889b8a96ca3.eot?#iefix") format("embedded-opentype"),
        url("https://db.onlinewebfonts.com/t/56855be2ba5bb40d6c2be889b8a96ca3.woff2") format("woff2"),
        url("https://db.onlinewebfonts.com/t/56855be2ba5bb40d6c2be889b8a96ca3.woff") format("woff"),
        url("https://db.onlinewebfonts.com/t/56855be2ba5bb40d6c2be889b8a96ca3.ttf") format("truetype"),
        url("https://db.onlinewebfonts.com/t/56855be2ba5bb40d6c2be889b8a96ca3.svg#Circular Std Bold") format("svg");
      font-weight: bold;
      font-style: normal;
    }

    .font-book {
      font-family: "Circular Std Book", sans-serif;
      font-weight: normal;
    }
  </style>
</svelte:head>

<!-- Cart Icon SVG -->
<svg xmlns="http://www.w3.org/2000/svg" style="display:none">
  <symbol id="cart-icon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
    <circle cx="9" cy="21" r="1"></circle>
    <circle cx="20" cy="21" r="1"></circle>
    <path d="M1 1h4l2.68 13.39a2 2 0 0 0 2 1.61h9.72a2 2 0 0 0 2-1.61L23 6H6"></path>
  </symbol>
</svg>

<div class="relative flex h-screen flex-col overflow-hidden bg-[#151515] font-['Circular_Std'] text-[#F6F6F6]">
  <!-- Background with elegant fade transitions -->
  {#key currentIndex}
    <div class="absolute inset-0 z-0" transition:fade={{ duration: 1000, easing: cubicInOut }}>
      <img class="h-full w-full object-cover" src={backgroundImage} alt="Background" />
    </div>
  {/key}

  <!-- Grid-aligned container with responsive margins - Add z-10 or higher if needed -->
  <div class="relative z-10 mx-auto flex w-full flex-1 flex-col" style={isMobile ? "max-width: calc(100% - 40px);" : "max-width: calc(100% - 100px);"}>
    <!-- Header - Fixed height -->
    <header class="grid h-[72px] flex-shrink-0 grid-cols-10 gap-[10px]">
      <!-- Logo (left-most) -->
      <div class="col-span-2 flex items-center">
        <a href="/"><img class="h-6" src={logo} alt="Logo" /></a>
      </div>

      <!-- Empty space (hidden on mobile) -->
      <div class={isMobile ? "hidden" : "col-span-4"}></div>

      <!-- Navigation and Cart (right-most) -->
      <div class={`flex items-center justify-end ${isMobile ? "col-span-8" : "col-span-4"}`}>
        <!-- Hardware Dropdown with hover -->
        <div class="relative" role="navigation" aria-label="Hardware products menu" onmouseenter={() => (hardwareHovered = true)} onmouseleave={() => (hardwareHovered = false)}>
          <button class="flex items-center hover:text-gray-300">
            Hardware
            <svg class="ml-1 h-3 w-3" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
              <path d="M6 9L12 15L18 9" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" />
            </svg>
          </button>

          <!-- Dropdown content -->
          {#if hardwareHovered}
            <div class="absolute top-8 right-0 z-50 w-[300px] rounded bg-[#252525] p-3 shadow-md">
              <ul class="grid gap-2">
                {#each hardware as item}
                  <li>
                    <a href={item.href} class="block rounded p-2 hover:bg-[#353535]">
                      <div class="font-medium">{item.title}</div>
                      <p class="text-sm text-gray-400">{item.content}</p>
                    </a>
                  </li>
                {/each}
              </ul>
            </div>
          {/if}
        </div>

        <span class={`inline-block ${isMobile ? "w-4" : "w-10"}`}></span>

        <!-- Software Dropdown with hover -->
        <div class="relative" role="navigation" aria-label="Software products menu" onmouseenter={() => (softwareHovered = true)} onmouseleave={() => (softwareHovered = false)}>
          <button class="flex items-center hover:text-gray-300">
            Software
            <svg class="ml-1 h-3 w-3" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
              <path d="M6 9L12 15L18 9" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" />
            </svg>
          </button>

          <!-- Dropdown content -->
          {#if softwareHovered}
            <div class="absolute top-8 right-0 z-50 w-[300px] rounded bg-[#252525] p-3 shadow-md">
              <ul class="grid gap-2">
                {#each software as item}
                  <li>
                    <a href={item.href} class="block rounded p-2 hover:bg-[#353535]">
                      <div class="font-medium">{item.title}</div>
                      <p class="text-sm text-gray-400">{item.content}</p>
                    </a>
                  </li>
                {/each}
              </ul>
            </div>
          {/if}
        </div>

        <span class={`inline-block ${isMobile ? "w-4" : "w-10"}`}></span>

        <!-- Documentation Link -->
        <a href="/documentation" class="hover:text-gray-300">Documentation</a>

        <span class={`inline-block ${isMobile ? "w-[15px]" : "w-[30px]"}`}></span>

        <!-- Cart Icon -->
        <!-- [TODO]: Fix link (April 02, 2025 16:17, ) -->

        <a href="/documentation" aria-label="View shopping cart" class="flex items-center justify-center hover:text-gray-300">
          <svg class="h-[1em] w-[1em] translate-y-[0.1em]">
            <use xlink:href="#cart-icon"></use>
          </svg>
        </a>
      </div>
    </header>

    <!-- Main content area with vertical centering -->
    <div class="flex min-h-[580px] flex-1 flex-col justify-center" ontouchstart={handleTouchStart} ontouchend={handleTouchEnd}>
      <!-- Main Carousel -->
      <Carousel.Root
        plugins={[carouselPlugin]}
        class="w-full"
        setApi={(emblaApi) => {
          api = emblaApi;
          // Reset listeners setup flag when API changes
          if (emblaApi) listenersSetup = false;
        }}>
        <Carousel.Content>
          {#each slides as slide, i (i)}
            <Carousel.Item>
              <!-- Product Slide Content -->
              <div class="grid grid-cols-10 items-center gap-[10px]">
                <!-- Text Column with elegant fade animations -->
                <div class={`${isMobile ? "col-span-10 p-4" : "col-span-3 col-start-2"}`}>
                  {#if currentIndex === i}
                    <div class={isMobile ? "space-y-6 text-center" : "space-y-10"} in:fly={{ x: -15, duration: 600, delay: 400, easing: cubicInOut }}>
                      {#if slide.logo}
                        <h1 class={isMobile ? "text-5xl font-bold" : "text-5xl font-bold"}>
                          <img src={slide.logo} alt={slide.title} class={isMobile ? "mx-auto" : ""} />
                        </h1>
                      {:else}
                        <h1 class={isMobile ? "text-5xl font-bold" : "text-5xl font-bold"}>
                          {slide.title}
                        </h1>
                      {/if}

                      <p class={isMobile ? "font-book text-2xl" : "font-book text-3xl"}>
                        {slide.description}
                      </p>

                      <div class={isMobile ? "pt-4" : "pt-8"}>
                        <a href={slide.href} class="inline-block transition-transform duration-300 ease-in-out hover:translate-x-1">
                          <img src={learn_more} alt="Learn more" class="cursor-pointer" />
                        </a>
                      </div>
                    </div>
                  {/if}
                </div>
              </div>
            </Carousel.Item>
          {/each}
        </Carousel.Content>
      </Carousel.Root>
    </div>

    <!-- Footer with Navigation Controls - Fixed height -->
    <footer class="h-[72px] flex-shrink-0">
      <div class="grid h-full grid-cols-10 gap-[10px]">
        <div class="col-span-2 col-start-1 flex items-center">
          <!-- Left Arrow -->
          <button class="p-2 transition-transform duration-150 hover:opacity-100 active:translate-x-[-2px]" onclick={() => scrollCarouselPrev()} aria-label="Previous slide">
            <img src={arrow} alt="Previous" class="h-[18px] rotate-180 transition-transform duration-150" class:translate-x-[-2px]={leftArrowActive} />
          </button>
        </div>

        <!-- Dots Navigation -->
        <div class="col-span-6 col-start-3 flex items-center justify-center gap-4">
          {#each slides as _, i (i)}
            <button
              class="p-2 transition-all duration-200"
              onclick={() => {
                userInteracting = true;
                currentIndex = i;
                resetAutoplay();
                setTimeout(() => {
                  userInteracting = false;
                }, 500);
              }}
              aria-label={`Navigate to slide ${i + 1}`}>
              <div class="relative h-[10px] w-[10px] transition-all duration-500" class:scale-125={currentIndex === i}>
                <img src={dot} alt="Dot" class="h-full w-full transition-all duration-500" class:opacity-100={currentIndex === i} class:opacity-40={currentIndex !== i} />
              </div>
            </button>
          {/each}
        </div>

        <div class="col-span-2 col-start-9 flex items-center justify-end">
          <!-- Right Arrow -->
          <button class="p-2 transition-transform duration-150 hover:opacity-100 active:translate-x-[2px]" onclick={() => scrollCarouselNext()} aria-label="Next slide">
            <img src={arrow} alt="Next" class="h-[18px] transition-transform duration-150" class:translate-x-[2px]={rightArrowActive} />
          </button>
        </div>
      </div>
    </footer>

    {#if showGrid}
      <div class="pointer-events-none fixed inset-0 z-[9998]">
        <div class="mx-auto h-full" style={isMobile ? "max-width: calc(100% - 40px);" : "max-width: calc(100% - 100px);"}>
          <div class="flex h-full justify-between">
            {#each Array(10) as _, i (i)}
              <div class="mx-[5px] h-full flex-1 bg-[rgba(85,85,85,0.5)] first:ml-0 last:mr-0"></div>
            {/each}
          </div>
        </div>
      </div>
    {/if}
  </div>
  <!-- End of inner content div -->
</div>
<!-- End of main h-screen div -->
