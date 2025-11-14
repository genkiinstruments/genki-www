<script lang="ts">
  import cn from "clsx";
  import { onMount } from "svelte";

  import wavefront_bg from "$lib/assets/wavefront-bg.webp";
  import wave_bg from "$lib/assets/wave-bg.webp";
  import katla_bg from "$lib/assets/katla-index-hero-render2.webp";
  import cosmos_bg from "$lib/assets/Cosmos_3D.webp";
  import softwave_bg from "$lib/assets/Softwave_3D.webp";
  import bfcm_bg from "$lib/assets/bfcm-index-desktop.webp";

  import wavefront_mobile from "$lib/assets/index-wavefront-mobile.webp";
  import wave_mobile from "$lib/assets/index-wave-mobile.webp";
  import katla_mobile from "$lib/assets/index-katla-mobile.webp";
  import cosmos_mobile from "$lib/assets/index-cosmos-mobile.webp";
  import softwave_mobile from "$lib/assets/index-softwave-mobile.webp";
  import bfcm_mobile from "$lib/assets/bfcm-index-mobile.webp";

  import katla_logo from "$lib/assets/katla-logo.webp";
  import InteractiveString from "$lib/InteractiveString.svelte";
  import dot from "$lib/assets/dot.svg"; // Assuming dot is needed for controls

  import { fade } from "svelte/transition";
  import { cubicInOut } from "svelte/easing";
  import Autoplay from "embla-carousel-autoplay";
  import Fade from "embla-carousel-fade";
  import { WheelGesturesPlugin } from "embla-carousel-wheel-gestures";

  import * as Carousel from "$lib/components/ui/carousel/index.js";
  import { type CarouselAPI } from "$lib/components/ui/carousel/context.js";
  import Header from "$lib/Header.svelte";

  let api = $state<CarouselAPI>();
  let currentIndex = $state(0);
  $effect(() => {
    if (api) {
      currentIndex = api.selectedScrollSnap();
      api.on("select", () => {
        currentIndex = api!.selectedScrollSnap();
      });
    }
  });

  const slides = [
    {
      title: "BLACK FRIDAY",
      description: "Limited time offers on bundles and instruments. Save up to 30%.",
      background: bfcm_bg,
      mobile: bfcm_mobile,
      logo: null,
      href: "/bfcm25",
      flipped: false,
    },
    { title: "KATLA", description: "Five-voice polyphonic synth, made from the ashes of Katla.", background: katla_bg, mobile: katla_mobile, logo: katla_logo, href: "/katla", flipped: false },
    { title: "WAVE", description: "Control your sound, shape effects and send commands with the Wave ring.", background: wave_bg, mobile: wave_mobile, logo: null, href: "/wave", flipped: false },
    { title: "WAVEFRONT", description: "Connect Wave, or any Bluetooth device, to your Eurorack.", background: wavefront_bg, mobile: wavefront_mobile, logo: null, href: "/wavefront", flipped: false },
    { title: "SOFTWAVE", description: "Unlock your setup with Wave's software counterpart.", background: softwave_bg, mobile: softwave_mobile, logo: null, href: "/softwave", flipped: true },
    { title: "COSMOS", description: "Experience the cosmos, featuring playful effects and a fun interface.", background: cosmos_bg, mobile: cosmos_mobile, logo: null, href: "/cosmos", flipped: true },
  ];

  function handleKeyDown(event: KeyboardEvent) {
    if (api) {
      if (event.key === "ArrowRight" || event.key === "ArrowUp") {
        api.scrollNext();
      } else if (event.key === "ArrowLeft" || event.key === "ArrowDown") {
        api.scrollPrev();
      }
    }
  }

  let lastScrollTime = 0;
  const scrollThrottle = 1200; // milliseconds between scroll actions

  function handleWheel(event: WheelEvent) {
    const now = Date.now();
    if (api && now - lastScrollTime > scrollThrottle) {
      if (Math.abs(event.deltaY) > Math.abs(event.deltaX)) {
        // Vertical scroll detected
        if (event.deltaY > 0) {
          api.scrollNext();
        } else {
          api.scrollPrev();
        }
        lastScrollTime = now;
      }
    }
  }

  let touchStartY = 0;
  let touchStartX = 0;

  function handleTouchStart(event: TouchEvent) {
    touchStartY = event.touches[0].clientY;
    touchStartX = event.touches[0].clientX;
  }

  function handleTouchEnd(event: TouchEvent) {
    const now = Date.now();
    if (api && now - lastScrollTime > scrollThrottle) {
      const touchEndY = event.changedTouches[0].clientY;
      const touchEndX = event.changedTouches[0].clientX;
      const deltaY = touchStartY - touchEndY;
      const deltaX = touchStartX - touchEndX;

      // Check if vertical swipe is more significant than horizontal
      if (Math.abs(deltaY) > Math.abs(deltaX) && Math.abs(deltaY) > 50) {
        if (deltaY > 0) {
          // Swiped up - go to next
          api.scrollNext();
        } else {
          // Swiped down - go to previous
          api.scrollPrev();
        }
        lastScrollTime = now;
      }
    }
  }

  onMount(() => {
    document.addEventListener("keydown", handleKeyDown);
    document.addEventListener("wheel", handleWheel, { passive: true });
    document.addEventListener("touchstart", handleTouchStart, { passive: true });
    document.addEventListener("touchend", handleTouchEnd, { passive: true });
    return () => {
      document.removeEventListener("keydown", handleKeyDown);
      document.removeEventListener("wheel", handleWheel);
      document.removeEventListener("touchstart", handleTouchStart);
      document.removeEventListener("touchend", handleTouchEnd);
    };
  });
</script>

<div class="relative flex h-[100dvh] w-full flex-col overflow-hidden px-5 text-[#DFDFDF] md:px-[50px]">
  <Header />
  {#key currentIndex}
    <div class="absolute inset-0 z-0 mask-t-from-60% mask-b-from-60%" transition:fade={{ duration: 500, easing: cubicInOut }}>
      <img class="hidden h-full w-full object-cover object-top sm:block" src={slides[currentIndex].background} alt="Background" />
      <img class="block h-full w-full object-cover object-top sm:hidden" src={slides[currentIndex].mobile} alt="Background" />
    </div>
  {/key}

  <div class="relative flex-1 items-center justify-center">
    <Carousel.Root
      opts={{ loop: true }}
      class="flex h-full w-full"
      plugins={[Autoplay({ playOnInit: true, delay: 4000, stopOnInteraction: true }), Fade(), WheelGesturesPlugin()]}
      setApi={(emblaApi) => {
        api = emblaApi;
      }}>
      <Carousel.Content class="flex h-full w-full grow py-4">
        {#each slides as { href, logo, title, description, flipped }, i (i)}
          <Carousel.Item class="flex flex-grow flex-col">
            <div class="hidden h-full grid-cols-10 items-center gap-[10px] md:grid">
              <div class={cn("col-span-10 p-4 md:col-span-3 md:p-0 lg:col-span-3", !flipped ? "md:col-start-2 lg:col-start-2" : "md:col-start-7 lg:col-start-7")}>
                <a {href}>
                  <div class="mt-12 space-y-6 text-center md:mt-0 md:space-y-10 md:pb-0 md:text-left">
                    {#if logo}
                      <h1 class="h-8 text-5xl font-bold">
                        <img src={logo} alt={title} class="mx-auto h-full pl-1 md:mx-0" />
                      </h1>
                    {:else}
                      <h1 class="text-4xl font-bold">
                        {title}
                      </h1>
                    {/if}
                    <p class="font-book text-2xl md:text-4xl">
                      {description}
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
              </div>
            </div>
            <a class="flex h-full grow flex-col items-center justify-between md:hidden" {href}>
              <div class="space-y-6 text-center">
                {#if logo}
                  <h1 class="text-5xl font-bold">
                    <img src={logo} alt={title} class="mx-auto h-8 pl-1 md:mx-0" />
                  </h1>
                {:else}
                  <h1 class="text-4xl font-bold">
                    {title}
                  </h1>
                {/if}
                <p class="font-book text-xl md:text-4xl">
                  {description}
                </p>
              </div>
              <div class="inline-block pt-4 md:pt-8">
                <div class="relative flex cursor-pointer flex-col items-center">
                  <span class="relative text-xs tracking-widest text-white uppercase">Learn more</span>
                  <div class="interactive-string-wrapper">
                    <InteractiveString />
                  </div>
                </div>
              </div>
            </a>
          </Carousel.Item>
        {/each}
      </Carousel.Content>
    </Carousel.Root>
  </div>

  <div class="absolute bottom-10 left-1/2 z-20 hidden -translate-x-1/2 transform flex-col items-center gap-4 md:bottom-12 md:flex">
    <div class="flex gap-3">
      {#each slides as _, i (i)}
        <button class="p-1 transition-all duration-200" onclick={() => api?.scrollTo(i)} aria-label={`Navigate to slide ${i + 1}`}>
          <div class="relative h-[6px] w-[6px] transition-all duration-500" class:scale-150={currentIndex === i}>
            <img src={dot} alt="Dot" class="h-full w-full transition-all duration-500 hover:opacity-100" class:opacity-100={currentIndex === i} class:opacity-40={currentIndex !== i} />
          </div>
        </button>
      {/each}
    </div>
  </div>
</div>
