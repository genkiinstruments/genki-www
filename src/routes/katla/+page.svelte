<script lang="ts">
  import { fade } from "svelte/transition";

  import Autoplay from "embla-carousel-autoplay";
  import * as Carousel from "$lib/components/ui/carousel/index.js";
  import InteractiveString from "$lib/InteractiveString.svelte";
  const youtube_plugin = Autoplay({ delay: 4000, stopOnInteraction: true });

  import Header from "$lib/Header.svelte";
  import Footer from "$lib/Footer.svelte";
  import YouTube from "$lib/YouTube.svelte";

  import quote from "$lib/assets/quote.webp";
  import katla_fill from "$lib/assets/katla-hero.webp";
  import katla_logo from "$lib/assets/katla-logo.webp";
  import katla_bg from "$lib/assets/katla-bg.webp";
  import herdis from "$lib/assets/herdis-stefans.webp";

  let isRenderImage = $state(false);
</script>

<div class="@container mx-auto flex h-[100vh] w-full flex-1 flex-col px-5 md:px-[50px]">
  <Header />

  <div class="flex min-h-[100vh] flex-col items-center justify-center py-20">
    <div class="absolute inset-0 -z-10">
      <img class="h-full w-full object-cover" src={katla_bg} alt="Background" />
    </div>
    <div class="grid w-full grid-cols-10 items-center gap-10">
      <div class="relative col-span-4 col-start-7" role="button" onmouseenter={() => (isRenderImage = true)} onmouseleave={() => (isRenderImage = false)} aria-roledescription="slide" tabindex="0">
        <!-- <img src={katla_fill} alt="Katla synthesizer" class="w-full transition-opacity duration-300" class:opacity-0={isRenderImage} /> -->
        {#if isRenderImage}
          <div class="absolute inset-0 flex items-center justify-center">
            <img src={katla_fill} alt="Katla close-up render" class="w-full" transition:fade={{ duration: 300 }} />
          </div>
        {/if}
      </div>
      <div class="col-span-3 col-start-2 md:text-2xl lg:text-4xl">
        <div>
          <img src={katla_logo} alt="Katla synthesizer" class="mx-auto md:mx-0" />
          <br />
          <div>
            Five-voice analog synthesizer from Iceland. Volcanic modulation, tactile sliders, with lava rock knobs and side-panels. Crafted for performers and sound designers seeking a unique chaos
            instrument.
          </div>
          <br />
          <div class="flex w-full flex-row space-x-10">
            <div>$4,990</div>
            <a href="/" class="inline-block">
              <div class="relative flex cursor-pointer flex-col items-center">
                <span class="relative -mb-2 text-sm tracking-widest text-white uppercase">Add to cart</span>
                <InteractiveString />
              </div>
            </a>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>

<img src={herdis} alt="Bergur Torisson in the studio" class="w-full object-cover" />
<div class="@container -mt-4 grid grid-cols-10">
  <div class="col-span-1 col-start-3">
    <img src={quote} alt="Quotation mark" />
  </div>
</div>
<div class="grid grid-cols-10 pt-7">
  <div class="col-span-3 col-start-3 text-4xl">I quickly got very interesting and exciting results</div>
  <div class="col-span-2 col-start-8 flex flex-col space-y-2">
    <div class=" text-4xl">Herdís Stefánsdóttir</div>
    <div class=" text-sm">Composer of music for multimedia, songwriter, and an electronic musician</div>
  </div>
</div>

<Carousel.Root plugins={[youtube_plugin]} opts={{ loop: true }} class="w-full py-68" onmouseenter={youtube_plugin.stop} onmouseleave={youtube_plugin.reset}>
  <div class="relative overflow-hidden">
    <Carousel.Content>
      {#each ["vPgHiyOXmMQ", "By-shXpcjSg", "BpfhsBbgY8M"] as id, i (i)}
        <Carousel.Item class="rounded-lg lg:basis-1/2">
          <YouTube {id} />
        </Carousel.Item>
      {/each}
    </Carousel.Content>
    <Carousel.Previous />
    <Carousel.Next />
  </div>
</Carousel.Root>

<Footer />
