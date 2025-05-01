<script lang="ts">
  import { fade } from "svelte/transition";

  import Header from "$lib/Header.svelte";
  import Footer from "$lib/Footer.svelte";
  import YouTubeCarousel from "$lib/YouTubeCarousel.svelte";
  import InteractiveString from "$lib/InteractiveString.svelte";
  import ScrollIndicator from "$lib/ScrollIndicator.svelte";

  import quote from "$lib/assets/quote.webp";
  import katla_fill from "$lib/assets/katla-hero.webp";
  import katla_logo from "$lib/assets/katla-logo.webp";
  import katla_bg from "$lib/assets/katla-bg.webp";
  import herdis from "$lib/assets/herdis-stefans.webp";

  let isRenderImage = $state(false);

  // Touch handlers for mobile
  function handleTouch() {
    isRenderImage = !isRenderImage;
  }

  function handleTouchStartEvent(event: TouchEvent) {
    event.preventDefault();
    handleTouch();
  }
</script>

<div class="@container mx-auto flex w-full flex-1 flex-col px-5 md:px-[50px]">
  <Header />

  <ScrollIndicator />

  <div class="flex min-h-[100vh] flex-col items-center justify-center py-10 md:py-20">
    <div class="absolute inset-0 -z-10">
      <img class="h-full w-full object-cover" src={katla_bg} alt="Background" />
    </div>

    <!-- Mobile layout stacks the elements vertically -->
    <div class="grid w-full grid-cols-1 items-center gap-6 md:grid-cols-10 md:gap-10">
      <!-- Logo and product info on top for mobile, left side for desktop -->
      <div class="order-1 mt-8 w-full text-lg md:order-1 md:col-span-3 md:col-start-2 md:mt-0 md:text-2xl lg:text-4xl">
        <div>
          <img src={katla_logo} alt="Katla synthesizer" class="mx-auto md:mx-0" />
          <br />
          <div>
            Five-voice analog synthesizer from Iceland. Volcanic modulation, tactile sliders, with lava rock knobs and side-panels. Crafted for performers and sound designers seeking a unique chaos
            instrument.
          </div>
          <br />
          <div class="flex w-full flex-row items-center justify-center md:flex md:items-center md:justify-start md:space-x-10">
            <div class="hidden md:flex md:items-center">$4,990</div>
            <a href="/" class="flex items-center">
              <div class="relative flex cursor-pointer flex-col items-center">
                <span class="text-xs tracking-widest text-white uppercase">Add to cart</span>
                <InteractiveString />
              </div>
            </a>
          </div>
        </div>
      </div>

      <!-- Price for mobile only -->
      <div class="order-2 flex items-center justify-center md:hidden">
        <div class="text-xl">$4,990</div>
      </div>

      <!-- Product image below text on mobile, right side on desktop -->
      <div
        class="relative order-3 mx-auto w-full max-w-[300px] md:order-2 md:col-span-4 md:col-start-7 md:max-w-none"
        role="button"
        onmouseenter={() => (isRenderImage = true)}
        onmouseleave={() => (isRenderImage = false)}
        onclick={handleTouch}
        onkeydown={(e) => e.key === "Enter" && handleTouch()}
        ontouchstart={handleTouchStartEvent}
        aria-roledescription="slide"
        tabindex="0">
        <!-- <img src={katla_fill} alt="Katla synthesizer" class="w-full transition-opacity duration-300" class:opacity-0={isRenderImage} /> -->
        {#if isRenderImage}
          <div class="absolute inset-0 flex items-center justify-center">
            <img src={katla_fill} alt="Katla close-up render" class="w-full" transition:fade={{ duration: 300 }} />
          </div>
        {/if}
      </div>
    </div>
  </div>
</div>

<div class="w-full overflow-hidden">
  <img src={herdis} alt="Herdís Stefánsdóttir in the studio" class="w-full object-cover" />
</div>
<div class="@container -mt-4 grid grid-cols-10">
  <div class="col-span-3 col-start-1 md:col-span-1 md:col-start-3">
    <img src={quote} alt="Quotation mark" />
  </div>
</div>
<div class="grid grid-cols-10 gap-4 px-5 pt-7 md:gap-0 md:px-0">
  <div class="col-span-8 col-start-3 text-xl md:col-span-3 md:col-start-3 md:text-4xl">I quickly got very interesting and exciting results</div>
  <div class="col-span-8 col-start-3 mt-4 space-y-2 md:col-span-2 md:col-start-8 md:mt-0 md:flex md:flex-col">
    <div class="text-xl md:text-4xl">Herdís Stefánsdóttir</div>
    <div class="text-lg leading-tight opacity-50 md:text-base">Composer of music for multimedia, songwriter, and an electronic musician</div>
  </div>
</div>

<YouTubeCarousel class="w-full overflow-hidden py-40 md:py-68" ids={["vPgHiyOXmMQ", "By-shXpcjSg", "BpfhsBbgY8M"]} />

<Footer />
