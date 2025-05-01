<script lang="ts">
  import { fade } from "svelte/transition";

  import Header from "$lib/Header.svelte";
  import Footer from "$lib/Footer.svelte";
  import YouTubeCarousel from "$lib/YouTubeCarousel.svelte";
  import ScrollIndicator from "$lib/ScrollIndicator.svelte";

  import softwave_hero from "$lib/assets/softwave-hero.webp";
  import toti from "$lib/assets/toti-cool.webp";
  import quote from "$lib/assets/quote.webp";

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
        tabindex="0">
        <img src={softwave_hero} alt="Softwave, companion software to the Wave music ring" class="w-full transition-opacity duration-300" class:opacity-0={isRenderImage} />
        {#if isRenderImage}
          <div class="absolute inset-0 flex items-center justify-center">
            <img src={softwave_hero} alt="Softwave close-up render" class="w-full" transition:fade={{ duration: 300 }} />
          </div>
        {/if}
      </div>

      <!-- Product info - full width on mobile, positioned columns on desktop -->
      <div class="mt-8 w-full text-lg md:col-span-3 md:col-start-7 md:mt-0 md:text-2xl lg:text-4xl">
        <div>
          <div class="font-bold uppercase">Softwave</div>
          <br />
          <div>The key that unlocks the full potential of your Wave Ring. Control music with gestures, customize each button, and create saved presets from one seamlessly integrated application.</div>
        </div>
      </div>
    </div>
  </div>
</div>

<div class="w-full overflow-hidden">
  <img src={toti} alt="Tóti Guðnason in the studio" class="w-full object-cover" />
</div>
<div class="@container -mt-4 grid grid-cols-10">
  <div class="col-span-3 col-start-1 md:col-span-1 md:col-start-3">
    <img src={quote} alt="Quotation mark" />
  </div>
</div>
<div class="grid grid-cols-10 gap-4 px-5 pt-7 md:gap-0 md:px-0">
  <div class="col-span-8 col-start-3 text-xl md:col-span-3 md:col-start-3 md:text-4xl">The depth of this software knows no bounds</div>
  <div class="col-span-8 col-start-3 mt-4 space-y-2 md:col-span-2 md:col-start-8 md:mt-0 md:flex md:flex-col">
    <div class="text-xl md:text-4xl">Tóti Guðnason</div>
    <div class="text-lg leading-tight opacity-50 md:text-base">Music composer, producer and musician</div>
  </div>
</div>

<YouTubeCarousel class="w-full overflow-hidden py-40 md:py-68" ids={["9pEGV0H5nTw", "foX4YGlUg4g", "a8aStUjS6uk", "oOKxmoZd4H8", "vJ-KT38i9Ls", "puQloBX3XPQ"]} />

<Footer />

