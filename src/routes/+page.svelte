<script lang="ts">
  import cn from "clsx";

  // Import Svelte lifecycle functions
  import { onMount } from "svelte";

  import wavefront_bg from "$lib/assets/wavefront-bg.webp";
  import wave_bg from "$lib/assets/wave-bg.webp";
  import katla_bg from "$lib/assets/katla-bg.webp";
  import cosmos_bg from "$lib/assets/Cosmos_3D.webp";
  import softwave_bg from "$lib/assets/Softwave_3D.webp";

  import katla_logo from "$lib/assets/katla-logo.webp";
  import InteractiveString from "$lib/InteractiveString.svelte";

  import arrow from "$lib/assets/arrow.svg";
  import dot from "$lib/assets/dot.svg";

  import { fade, blur } from "svelte/transition";
  import { cubicInOut } from "svelte/easing";
  import Autoplay from "embla-carousel-autoplay";

  import * as Carousel from "$lib/components/ui/carousel/index.js";
  import { type CarouselAPI } from "$lib/components/ui/carousel/context.js";
  import Header from "$lib/Header.svelte";
  const carouselPlugin = Autoplay({ delay: 7000, stopOnInteraction: true, stopOnMouseEnter: true });
  let api = $state<CarouselAPI>();
  let currentIndex = $state(0);

  let userInteracting = $state(false);
  let inactivityTimeout = $state<number | null>(null);
  const INACTIVITY_DELAY = 10000; // 10 seconds

  function resetAutoplay() {
    api?.plugins().autoplay?.reset();
  }

  function resetInactivityTimer() {
    // Clear existing timeout
    if (inactivityTimeout !== null) {
      clearTimeout(inactivityTimeout);
    }

    // Set a new timeout
    inactivityTimeout = window.setTimeout(() => {
      userInteracting = false;
      resetAutoplay();
    }, INACTIVITY_DELAY);
  }

  function setupCarouselListeners() {
    if (api && api.on) {
      // Only update from autoplay, not from manual navigation
      api.on("select", () => {
        if (!userInteracting) {
          currentIndex = api?.selectedScrollSnap() || 0;
        }
      });
    }
  }

  let leftArrowActive = $state(false);
  let rightArrowActive = $state(false);

  // Product slide data
  const slides = [
    {
      title: "KATLA",
      description: "Five-voice polyphonic synth, made from the ashes of Katla.",
      background: katla_bg,
      logo: katla_logo,
      href: "/katla",
      flipped: false,
    },
    {
      title: "WAVE",
      description: "Control your sound, shape effects and send commands with the Wave ring.",
      background: wave_bg,
      logo: null,
      href: "/wave",
      flipped: false,
    },
    {
      title: "WAVEFRONT",
      description: "Connect Wave, or any Bluetooth device, to your Eurorack.",
      background: wavefront_bg,
      logo: null,
      href: "/wavefront",
      flipped: false,
    },
    {
      title: "SOFTWAVE",
      description: "Unlock your setup with Wave's software counterpart.",
      background: softwave_bg,
      logo: null,
      href: "/softwave",
      flipped: true,
    },
    {
      title: "COSMOS",
      description: "Experience the cosmos, featuring playful effects and a fun interface.",
      background: cosmos_bg,
      logo: null,
      href: "/cosmos",
      flipped: true,
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

  let listenersSetup = $state(false);

  $effect(() => {
    if (api) {
      api.scrollTo(currentIndex);

      if (!listenersSetup) {
        setupCarouselListeners();
        listenersSetup = true;
      }
    }
  });

  let backgroundImage = $derived(slides[currentIndex].background);

  let showGrid = $state(false);

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

  // Mouse movement shouldn't trigger interactive mode, only reset timer if already in interactive mode
  function trackMouseMovement() {
    if (userInteracting) {
      resetInactivityTimer();
    }
  }

  // Track user activity
  function trackUserActivity() {
    if (!userInteracting) return; // Only reset timer if user is in interactive mode
    resetInactivityTimer();
  }

  // Define the document-level handler - need to ensure this function reference doesn't change
  function handleKeyDown(event: KeyboardEvent) {
    if (event.key === "'") {
      showGrid = !showGrid;
    } else if (event.key === "ArrowRight") {
      userInteracting = true;
      rightArrowActive = true;
      scrollCarouselNext();
      setTimeout(() => {
        rightArrowActive = false;
      }, 150);
    } else if (event.key === "ArrowLeft") {
      userInteracting = true;
      leftArrowActive = true;
      scrollCarouselPrev();
      setTimeout(() => {
        leftArrowActive = false;
      }, 150);
    }
  }

  // Install event listener early to ensure keyboard works
  if (typeof document !== "undefined") {
    document.addEventListener("keydown", handleKeyDown);
  }

  onMount(() => {
    // Prevent scrolling on this page only
    document.body.classList.add("index-page-no-scroll");

    // Start inactivity timer on page load
    resetInactivityTimer();

    // Activity tracking event listeners
    window.addEventListener("mousemove", trackMouseMovement);
    window.addEventListener("mousedown", trackUserActivity);
    window.addEventListener("touchstart", trackUserActivity);
    window.addEventListener("scroll", trackUserActivity);

    return () => {
      // Clean up event listeners
      document.removeEventListener("keydown", handleKeyDown);
      window.removeEventListener("mousemove", trackMouseMovement);
      window.removeEventListener("mousedown", trackUserActivity);
      window.removeEventListener("touchstart", trackUserActivity);
      window.removeEventListener("scroll", trackUserActivity);

      // Clear any pending timeout
      if (inactivityTimeout !== null) {
        clearTimeout(inactivityTimeout);
      }

      // Remove the no-scroll class when component unmounts
      document.body.classList.remove("index-page-no-scroll");
    };
  });
</script>

<div></div>

<div class="carousel-container relative flex h-[100dvh] w-full flex-col overflow-hidden bg-[#151515] text-[#DFDFDF]">
  <!-- Background with elegant fade transitions -->
  {#key currentIndex}
    <div class="absolute inset-0 z-0" transition:fade={{ duration: 1000, easing: cubicInOut }}>
      <img class="h-full w-full object-cover" src={backgroundImage} alt="Background" />
    </div>
  {/key}

  <!-- Grid-aligned container with responsive margins - Add z-10 or higher if needed -->
  <div class="relative z-10 mx-auto flex w-full flex-1 flex-col px-5 md:px-[50px]">
    <Header />

    <!-- Main content area with vertical centering -->
    <div class="flex flex-1 flex-col justify-center" ontouchstart={handleTouchStart} ontouchend={handleTouchEnd}>
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
                <div class={cn("col-span-10 p-4 md:col-span-3 md:p-0 md:even:col-start-7", slide.flipped ? "md:col-start-7" : "md:col-start-2")}>
                  {#if currentIndex === i}
                    <div class="space-y-6 text-center md:space-y-10 md:text-left" in:blur={{ amount: 15, duration: 800, delay: 300, easing: cubicInOut }}>
                      {#if slide.logo}
                        <h1 class="text-5xl font-bold">
                          <img src={slide.logo} alt={slide.title} class="mx-auto md:mx-0" />
                        </h1>
                      {:else}
                        <h1 class="text-4xl font-bold">
                          {slide.title}
                        </h1>
                      {/if}

                      <p class="font-book text-2xl md:text-4xl">
                        {slide.description}
                      </p>

                      <div class="pt-4 md:pt-8">
                        <a href={slide.href} class="inline-block">
                          <div class="relative flex cursor-pointer flex-col items-center">
                            <span class="relative text-xs tracking-widest text-white">LEARN MORE</span>
                            <div style="height: 90px; width: 110px; margin-top: 10px;">
                              {#if currentIndex === i}
                                <div class="interactive-string-wrapper">
                                  <InteractiveString />
                                </div>
                              {/if}
                            </div>
                          </div>
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
              <div class="relative h-[6px] w-[6px] transition-all duration-500" class:scale-125={currentIndex === i}>
                <img src={dot} alt="Dot" class="h-full w-full transition-all duration-500 hover:opacity-100" class:opacity-100={currentIndex === i} class:opacity-40={currentIndex !== i} />
              </div>
            </button>
          {/each}
        </div>
      </div>
    </footer>

    {#if showGrid}
      <div class="pointer-events-none fixed inset-0 z-[9998]">
        <div class="mx-auto h-full px-5 md:px-[50px]">
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
