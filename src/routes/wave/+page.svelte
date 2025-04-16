<script lang="ts">
  import Header from "$lib/Header.svelte";
  import Footer from "$lib/Footer.svelte";
  import YouTube from "$lib/YouTube.svelte";
  import Testimonials from "$lib/Testimonials.svelte";
  import { fade } from "svelte/transition";
  import { fly } from "svelte/transition";

  import toti from "$lib/assets/index-toti-studio.webp";
  import wave from "$lib/assets/wave-hand.webp";
  import box from "$lib/assets/wave-open-box.webp";
  import korg from "$lib/assets/wave-korg.webp";
  import cool from "$lib/assets/wave-cool.webp";
  import fabris from "$lib/assets/wave-fabris.webp";
  import korg_red from "$lib/assets/wave-korg-orange.webp";
  import piano from "$lib/assets/wave-piano.webp";
  import wave_hand from "$lib/assets/wave-hand.webp";
  import wave_render from "$lib/assets/wave-render.webp";
  import bergur from "$lib/assets/bergur-in-the-studio.webp";
  import quote from "$lib/assets/quote.webp";

  let wave_img = $state(wave_hand);
  let isRenderImage = $state(false);

  const images = [
    { src: box, alt: "Side profile" },
    { src: korg, alt: "Front view" },
    { src: wave, alt: "Side profile" },
    { src: cool, alt: "Side profile" },
    { src: fabris, alt: "Front view" },
    { src: korg_red, alt: "Side profile" },
    { src: piano, alt: "Side profile" },
    { src: toti, alt: "Front view" },
  ];

  import Autoplay from "embla-carousel-autoplay";
  import * as Carousel from "$lib/components/ui/carousel/index.js";
  import InteractiveString from "$lib/InteractiveString.svelte";
  const youtube_plugin = Autoplay({ delay: 4000, stopOnInteraction: true });

  let is_hovering = $state(false);
  let hero = $derived(is_hovering ? box : wave);
</script>

<div class="@container mx-auto flex h-[100vh] w-full flex-1 flex-col px-5 md:px-[50px]">
  <Header />

  <div class="flex min-h-[100vh] flex-col items-center justify-center py-20">
    <div class="grid w-full grid-cols-10 items-center gap-10">
      <div class="relative col-span-4 col-start-2" role="button" onmouseenter={() => (isRenderImage = true)} onmouseleave={() => (isRenderImage = false)} aria-roledescription="slide" tabindex="0">
        <img src={wave_hand} alt="Wave ring for musicians" class="w-full transition-opacity duration-300" class:opacity-0={isRenderImage} />
        {#if isRenderImage}
          <div class="absolute inset-0 flex items-center justify-center">
            <img src={wave_render} alt="Wave ring close-up render" class="w-full" transition:fade={{ duration: 300 }} />
          </div>
        {/if}
      </div>
      <div class="col-span-3 col-start-7 md:text-2xl lg:text-4xl">
        <div>
          <div class="font-bold">WAVE</div>
          <br />
          <div>
            Wave is the ring that allows artists and producers to easily control sound, shape effects and send commands. Wave detects the most finesse gestures and enables natural interaction with
            sound through movement.
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

<img src={bergur} alt="Bergur Torisson in the studio" class="w-full object-cover" />
<div class="@container -mt-4 grid grid-cols-10">
  <div class="col-span-1 col-start-3">
    <img src={quote} alt="Quotation mark" />
  </div>
</div>
<div class="grid grid-cols-10 pt-7">
  <div class="col-span-3 col-start-3 text-4xl">Wave adds a dimension to musical creativity</div>
  <div class="col-span-2 col-start-8 flex flex-col space-y-2">
    <div class=" text-4xl">Bergur Þórisson</div>
    <div class=" text-sm">Grammy nominated engineer and musical director (Björk)</div>
  </div>
</div>

<Carousel.Root plugins={[youtube_plugin]} opts={{ loop: true }} class="w-full py-68" onmouseenter={youtube_plugin.stop} onmouseleave={youtube_plugin.reset}>
  <div class="relative overflow-hidden">
    <Carousel.Content>
      {#each ["9pEGV0H5nTw", "foX4YGlUg4g", "a8aStUjS6uk", "oOKxmoZd4H8", "vJ-KT38i9Ls"] as id, i (i)}
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
