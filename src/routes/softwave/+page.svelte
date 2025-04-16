<script lang="ts">
  import { fade } from "svelte/transition";

  import Header from "$lib/Header.svelte";
  import Footer from "$lib/Footer.svelte";
  import YouTubeCarousel from "$lib/YouTubeCarousel.svelte";

  import softwave_hero from "$lib/assets/softwave-hero.webp";
  import toti from "$lib/assets/toti-cool.webp";
  import quote from "$lib/assets/quote.webp";

  let isRenderImage = $state(false);
</script>

<div class="@container mx-auto flex h-[100vh] w-full flex-1 flex-col px-5 md:px-[50px]">
  <Header />

  <div class="flex min-h-[100vh] flex-col items-center justify-center py-20">
    <div class="grid w-full grid-cols-10 items-center gap-10">
      <div class="relative col-span-4 col-start-2" role="button" onmouseenter={() => (isRenderImage = true)} onmouseleave={() => (isRenderImage = false)} aria-roledescription="slide" tabindex="0">
        <img src={softwave_hero} alt="Softwave, companion software to the Wave music ring" class="w-full transition-opacity duration-300" class:opacity-0={isRenderImage} />
        {#if isRenderImage}
          <div class="absolute inset-0 flex items-center justify-center">
            <img src={softwave_hero} alt="Softwave close-up render" class="w-full" transition:fade={{ duration: 300 }} />
          </div>
        {/if}
      </div>
      <div class="col-span-3 col-start-7 md:text-2xl lg:text-4xl">
        <div>
          <div class="font-bold uppercase">Softwave</div>
          <br />
          <div>The key that unlocks the full potential of your Wave Ring. Control music with gestures, customize each button, and create saved presets from one seamlessly integrated application.</div>
        </div>
      </div>
    </div>
  </div>
</div>

<img src={toti} alt="Tóti Guðnason in the studio" class="w-full object-cover" />
<div class="@container -mt-4 grid grid-cols-10">
  <div class="col-span-1 col-start-3">
    <img src={quote} alt="Quotation mark" />
  </div>
</div>
<div class="grid grid-cols-10 pt-7">
  <div class="col-span-3 col-start-3 text-4xl">The depth of this software knows no bounds</div>
  <div class="col-span-2 col-start-8 flex flex-col space-y-2">
    <div class=" text-4xl">Tóti Guðnason</div>
    <div class=" text-sm">Music composer, producer and musician</div>
  </div>
</div>

<YouTubeCarousel ids={["TB789hiIJfA", "a8aStUjS6uk", "1P4O6aG_XWk", "6EdUOi37k10"]} />

<Footer />
