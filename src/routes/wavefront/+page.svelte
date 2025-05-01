<script lang="ts">
  import { fade } from "svelte/transition";

  import Header from "$lib/Header.svelte";
  import Footer from "$lib/Footer.svelte";
  import YouTubeCarousel from "$lib/YouTubeCarousel.svelte";
  import InteractiveString from "$lib/InteractiveString.svelte";

  import wavefront_stack from "$lib/assets/wavefront-stack.webp";
  import wavefront_single from "$lib/assets/wavefront-clean-hero-transparent.webp";
  import heymun from "$lib/assets/heymun.webp";
  import quote from "$lib/assets/quote.webp";

  let isRenderImage = $state(false);

  // Touch handlers for mobile
  function handleTouch() {
    isRenderImage = !isRenderImage;
  }

  function handleTouchStartEvent(event) {
    event.preventDefault();
    handleTouch();
  }
</script>

<div class="@container mx-auto flex w-full flex-1 flex-col px-5 md:px-[50px]">
  <Header />

  <div class="flex flex-col items-center justify-center py-10 md:py-20 min-h-[90vh]">
    <!-- Mobile layout stacks the elements vertically -->
    <div class="grid w-full grid-cols-1 items-center gap-6 md:grid-cols-10 md:gap-10">
      <!-- Product image - full width on mobile, positioned columns on desktop -->
      <div 
        class="relative mx-auto w-full max-w-[300px] md:col-span-4 md:col-start-2 md:max-w-none" 
        role="button" 
        onmouseenter={() => (isRenderImage = true)} 
        onmouseleave={() => (isRenderImage = false)} 
        onclick={handleTouch}
        onkeydown={(e) => e.key === "Enter" && handleTouch()}
        ontouchstart={handleTouchStartEvent}
        aria-roledescription="slide" 
        tabindex="0"
      >
        <img src={wavefront_stack} alt="Wavefront Bluetooth LE Eurorack module" class="w-full transition-opacity duration-300" class:opacity-0={isRenderImage} />
        {#if isRenderImage}
          <div class="absolute inset-0 flex items-center justify-center">
            <img src={wavefront_single} alt="Wavefront close-up render" class="w-full" transition:fade={{ duration: 300 }} />
          </div>
        {/if}
      </div>

      <!-- Product info - full width on mobile, positioned columns on desktop -->
      <div class="mt-8 w-full text-lg md:col-span-3 md:col-start-7 md:mt-0 md:text-2xl lg:text-4xl">
        <div>
          <div class="flex items-center justify-between">
            <div class="font-bold">WAVEFRONT</div>
            <div class="text-xl md:hidden">$349</div>
          </div>
          <br />
          <div>
            Elevate any modular setup. This customizable Eurorack receiver puts you in control of shaping effects, triggering samples and controlling gates — with your Wave Ring or your other favorite
            Bluetooth device.
          </div>
          <br />
          <div class="flex w-full flex-row items-center justify-center md:items-baseline md:justify-start md:space-x-10">
            <div class="hidden md:block md:self-center">$349</div>
            <a href="/" class="inline-block">
              <div class="relative flex cursor-pointer flex-col items-center md:items-start">
                <span class="relative -mb-2 text-xs tracking-widest text-white uppercase">Add to cart</span>
                <InteractiveString />
              </div>
            </a>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>

<div class="w-full overflow-hidden">
  <img src={heymun} alt="HEYMUN is a Malaysian born Sydney based." class="w-full object-cover" />
</div>
<div class="@container -mt-4 grid grid-cols-10">
  <div class="col-span-3 col-start-1 md:col-span-1 md:col-start-3">
    <img src={quote} alt="Quotation mark" />
  </div>
</div>
<div class="grid grid-cols-10 gap-4 px-5 pt-7 md:gap-0 md:px-0">
  <div class="col-span-8 col-start-3 text-xl md:col-span-3 md:col-start-3 md:text-4xl">
    I am blown away by the Wave ring and the Wavefront module, I am now able to communicate, express, and explore sounds via my movements from my Eurorack system.
  </div>
  <div class="col-span-8 col-start-3 mt-4 space-y-2 md:col-span-2 md:col-start-8 md:mt-0 md:flex md:flex-col">
    <div class="text-xl md:text-4xl">Heymun</div>
    <div class="text-lg leading-tight opacity-50 md:text-base">Music composer, producer and musician</div>
  </div>
</div>

<YouTubeCarousel class="w-full overflow-hidden py-40 md:py-68" ids={["Mxx2AuXiYWM", "I3hlnmP7yJU", "OxGjLVSPjCE", "MqfF2m-Mi-Y"]} />

<Footer />