<script lang="ts">
  import Header from "$lib/Header.svelte";
  import Footer from "$lib/Footer.svelte";
  import YouTube from "$lib/YouTube.svelte";
  import { fade } from "svelte/transition";

  import wavefront_stack from "$lib/assets/wavefront-stack.webp";
  import wavefront_single from "$lib/assets/wavefront-clean-hero-transparent.webp";
  import heymun from "$lib/assets/heymun.webp";
  import quote from "$lib/assets/quote.webp";

  let isRenderImage = $state(false);

  import Autoplay from "embla-carousel-autoplay";
  import * as Carousel from "$lib/components/ui/carousel/index.js";
  import InteractiveString from "$lib/InteractiveString.svelte";
  const youtube_plugin = Autoplay({ delay: 4000, stopOnInteraction: true });
</script>

<div class="@container mx-auto flex h-[100vh] w-full flex-1 flex-col px-5 md:px-[50px]">
  <Header />

  <div class="flex min-h-[100vh] flex-col items-center justify-center py-20">
    <div class="grid w-full grid-cols-10 items-center gap-10">
      <div class="relative col-span-4 col-start-2" role="button" onmouseenter={() => (isRenderImage = true)} onmouseleave={() => (isRenderImage = false)} aria-roledescription="slide" tabindex="0">
        <img src={wavefront_stack} alt="Wave ring for musicians" class="w-full transition-opacity duration-300" class:opacity-0={isRenderImage} />
        {#if isRenderImage}
          <div class="absolute inset-0 flex items-center justify-center">
            <img src={wavefront_single} alt="Wave ring close-up render" class="w-full" transition:fade={{ duration: 300 }} />
          </div>
        {/if}
      </div>
      <div class="col-span-3 col-start-7 md:text-2xl lg:text-4xl">
        <div>
          <div class="font-bold">WAVEFRONT</div>
          <br />
          <div>
            Elevate any modular setup. This customizable Eurorack receiver puts you in control of shaping effects, triggering samples and controlling gates — with your Wave Ring or your other favorite
            Bluetooth device.
          </div>
          <br />
          <div class="flex w-full flex-row space-x-10">
            <div>$349</div>
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

<img src={heymun} alt="Bergur Torisson in the studio" class="w-full object-cover" />
<div class="@container -mt-4 grid grid-cols-10">
  <div class="col-span-1 col-start-3">
    <img src={quote} alt="Quotation mark" />
  </div>
</div>
<div class="grid grid-cols-10 pt-7">
  <div class="col-span-3 col-start-3 text-4xl">
    I am blown away by the Wave ring and the Wavefront module, I am now able to communicate, express, and explore sounds via my movements from my Eurorack system.
  </div>
  <div class="col-span-2 col-start-8 flex flex-col space-y-2">
    <div class=" text-4xl">Heymun</div>
    <div class=" text-sm">Music composer, producer and musician</div>
  </div>
</div>

<Carousel.Root plugins={[youtube_plugin]} opts={{ loop: true }} class="w-full py-68" onmouseenter={youtube_plugin.stop} onmouseleave={youtube_plugin.reset}>
  <div class="relative overflow-hidden">
    <Carousel.Content>
      {#each ["Mxx2AuXiYWM", "I3hlnmP7yJU", "OxGjLVSPjCE", "MqfF2m-Mi-Y"] as id, i (i)}
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
