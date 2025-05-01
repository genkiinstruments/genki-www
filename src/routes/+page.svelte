<script lang="ts">
  import cn from "clsx";

  // Import Svelte lifecycle functions
  import { onMount } from "svelte";

  import wavefront_bg from "$lib/assets/wavefront-bg.webp";
  import wave_bg from "$lib/assets/wave-bg.webp";
  import katla_bg from "$lib/assets/katla-bg.webp";
  import cosmos_bg from "$lib/assets/Cosmos_3D.webp";
  import softwave_bg from "$lib/assets/Softwave_3D.webp";

  import wavefront_mobile from "$lib/assets/index-wavefront-mobile.webp";
  import wave_mobile from "$lib/assets/index-wave-mobile.webp";
  import katla_mobile from "$lib/assets/index-katla-mobile.webp";
  import cosmos_mobile from "$lib/assets/index-cosmos-mobile.webp";
  import softwave_mobile from "$lib/assets/index-softwave-mobile.webp";

  import katla_logo from "$lib/assets/katla-logo.webp";
  import InteractiveString from "$lib/InteractiveString.svelte";

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
      mobile: katla_mobile,
      logo: katla_logo,
      href: "/katla",
      flipped: false,
    },
    {
      title: "WAVE",
      description: "Control your sound, shape effects and send commands with the Wave ring.",
      background: wave_bg,
      mobile: wave_mobile,
      logo: null,
      href: "/wave",
      flipped: false,
    },
    {
      title: "WAVEFRONT",
      description: "Connect Wave, or any Bluetooth device, to your Eurorack.",
      background: wavefront_bg,
      mobile: wavefront_mobile,
      logo: null,
      href: "/wavefront",
      flipped: false,
    },
    {
      title: "SOFTWAVE",
      description: "Unlock your setup with Wave's software counterpart.",
      background: softwave_bg,
      mobile: softwave_mobile,
      logo: null,
      href: "/softwave",
      flipped: true,
    },
    {
      title: "COSMOS",
      description: "Experience the cosmos, featuring playful effects and a fun interface.",
      background: cosmos_bg,
      mobile: cosmos_mobile,
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
  let mobileImage = $derived(slides[currentIndex].mobile);

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
    if (event.key === "ArrowRight" || event.key === "ArrowUp") {
      userInteracting = true;
      rightArrowActive = true;
      scrollCarouselNext();
      setTimeout(() => {
        rightArrowActive = false;
      }, 150);
    } else if (event.key === "ArrowLeft" || event.key === "ArrowDown") {
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
  }

  // Handle vertical scrolling to control carousel
  let lastScrollTime = 0;
  const scrollCooldown = 500; // Milliseconds cooldown between scroll actions
  let scrollAccumulator = 0;
  const scrollThreshold = 50; // Accumulated scroll amount needed to trigger navigation

  function handleVerticalScroll(event: WheelEvent) {
    // Only handle vertical scrolling, let horizontal scrolling pass through normally
    if (Math.abs(event.deltaX) > Math.abs(event.deltaY)) {
      // This is primarily horizontal scrolling - don't interfere
      return;
    }

    // Only prevent default for vertical scrolling
    event.preventDefault();

    // Add to scroll accumulator (vertical movement only)
    scrollAccumulator += event.deltaY;

    const now = Date.now();
    const timeSinceLastScroll = now - lastScrollTime;

    // Reset accumulator if it's been a while since last scroll
    if (timeSinceLastScroll > 500) {
      scrollAccumulator = event.deltaY;
    }

    // Check if we've scrolled past threshold and cooldown period has passed
    if (Math.abs(scrollAccumulator) >= scrollThreshold && timeSinceLastScroll >= scrollCooldown) {
      // Use accumulated scroll direction to determine navigation
      if (scrollAccumulator > 0) {
        // Scrolling down - go next
        userInteracting = true;
        scrollCarouselNext();
      } else {
        // Scrolling up - go previous
        userInteracting = true;
        scrollCarouselPrev();
      }

      // Reset accumulator and update last scroll time
      scrollAccumulator = 0;
      lastScrollTime = now;
    }
  }

  onMount(() => {
    // Start inactivity timer on page load
    resetInactivityTimer();

    // Activity tracking event listeners
    document.addEventListener("keydown", handleKeyDown);
    window.addEventListener("mousemove", trackMouseMovement);
    window.addEventListener("mousedown", trackUserActivity);
    window.addEventListener("touchstart", trackUserActivity);
    window.addEventListener("wheel", handleVerticalScroll, { passive: false });

    return () => {
      // Clean up event listeners
      document.removeEventListener("keydown", handleKeyDown);
      window.removeEventListener("mousemove", trackMouseMovement);
      window.removeEventListener("mousedown", trackUserActivity);
      window.removeEventListener("touchstart", trackUserActivity);
      window.removeEventListener("wheel", handleVerticalScroll);

      // Clear any pending timeout
      if (inactivityTimeout !== null) {
        clearTimeout(inactivityTimeout);
      }
    };
  });
</script>

<div class="relative flex h-[100dvh] w-full flex-col overflow-hidden bg-[#151515] text-[#DFDFDF]">
  {#key currentIndex}
    <div class="absolute inset-0 z-0" transition:fade={{ duration: 1000, easing: cubicInOut }}>
      <img class="hidden h-full w-full object-cover object-top sm:block" src={backgroundImage} alt="Background" />
      <img class="block h-full w-full object-cover object-top sm:hidden" src={mobileImage} alt="Background" />
    </div>
  {/key}

  <div class="relative z-10 mx-auto flex w-full flex-1 flex-col px-5 md:px-[50px]">
    <Header />

    <div class="flex-1 flex-col justify-center sm:flex" ontouchstart={handleTouchStart} ontouchend={handleTouchEnd}>
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
              <div class="grid grid-cols-10 items-center gap-[10px]">
                <div class={cn("col-span-10 p-4 md:col-span-3 md:p-0 md:even:col-start-7", slide.flipped ? "md:col-start-7" : "md:col-start-2")}>
                  {#if currentIndex === i}
                    <a href={slide.href}>
                      <div class="mt-12 space-y-6 text-center md:mt-0 md:space-y-10 md:pb-0 md:text-left" in:blur={{ amount: 15, duration: 800, delay: 300, easing: cubicInOut }}>
                        {#if slide.logo}
                          <h1 class="text-5xl font-bold">
                            <img src={slide.logo} alt={slide.title} class="mx-auto pl-1 md:mx-0" />
                          </h1>
                        {:else}
                          <h1 class="text-4xl font-bold">
                            {slide.title}
                          </h1>
                        {/if}

                        <p class="font-book text-2xl md:text-4xl">
                          {slide.description}
                        </p>

                        <div class="inline-block pt-4 md:pt-8">
                          <div class="relative flex cursor-pointer flex-col items-center">
                            <span class="relative text-xs tracking-widest text-white uppercase">Learn more</span>
                            <div class="interactive-string-wrapper">
                              <InteractiveString />
                            </div>
                          </div>
                        </div>
                      </div>
                    </a>
                  {/if}
                </div>
              </div>
            </Carousel.Item>
          {/each}
        </Carousel.Content>
      </Carousel.Root>
    </div>

    <!-- Vertical Dots Navigation - Fixed on right side, vertically centered -->
    <div class="absolute top-1/2 right-5 z-20 flex -translate-y-1/2 flex-col gap-5 md:right-10">
      {#each slides as _, i (i)}
        <button
          class="p-1 transition-all duration-200"
          onclick={() => {
            userInteracting = true;
            currentIndex = i;
            resetAutoplay();
            setTimeout(() => {
              userInteracting = false;
            }, 500);
          }}
          aria-label={`Navigate to slide ${i + 1}`}>
          <div class="relative h-[7px] w-[7px] transition-all duration-500" class:scale-150={currentIndex === i}>
            <img src={dot} alt="Dot" class="h-full w-full transition-all duration-500 hover:opacity-100" class:opacity-100={currentIndex === i} class:opacity-40={currentIndex !== i} />
          </div>
        </button>
      {/each}
    </div>
  </div>
</div>
