<script lang="ts">
  import Header from "$lib/Header.svelte";
  import Footer from "$lib/Footer.svelte";
  import YouTube from "$lib/YouTube.svelte";
  import Testimonials from "$lib/Testimonials.svelte";

  import toti from "$lib/assets/index-toti-studio.png";
  import wave from "$lib/assets/wave-hand.png";
  import box from "$lib/assets/wave-open-box.png";
  import korg from "$lib/assets/wave-korg.png";
  import cool from "$lib/assets/wave-cool.png";
  import fabris from "$lib/assets/wave-fabris.png";
  import korg_red from "$lib/assets/wave-korg-orange.png";
  import piano from "$lib/assets/wave-piano.png";
  import wavefront from "$lib/assets/wavefront-hero.png";

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
  const images_plugin = Autoplay({ delay: 2000, stopOnInteraction: true });
  const youtube_plugin = Autoplay({ delay: 2000, stopOnInteraction: true });
</script>

<Header></Header>

<div class="mx-auto mt-8 px-4 pt-6 sm:px-6 lg:max-w-7xl lg:px-8">
  <div class="lg:grid lg:auto-rows-min lg:grid-cols-12 lg:gap-x-8">
    <div class="lg:col-span-5 lg:col-start-8">
      <div class="flex justify-between">
        <h1 class="text-xl font-medium text-gray-900">Wave Ring</h1>
        <p class="text-xl font-medium text-gray-900">$349</p>
      </div>
      <!-- Reviews -->
      <div class="mt-4">
        <h2 class="sr-only">Reviews</h2>
        <div class="flex items-center">
          <p class="text-sm text-gray-700">
            4.8
            <span class="sr-only"> out of 5 stars</span>
          </p>
          <div class="ml-1 flex items-center">
            <!-- Active: "text-yellow-400", Inactive: "text-gray-200" -->
            <svg class="size-5 shrink-0 text-yellow-400" viewBox="0 0 20 20" fill="currentColor" aria-hidden="true" data-slot="icon">
              <path
                fill-rule="evenodd"
                d="M10.868 2.884c-.321-.772-1.415-.772-1.736 0l-1.83 4.401-4.753.381c-.833.067-1.171 1.107-.536 1.651l3.62 3.102-1.106 4.637c-.194.813.691 1.456 1.405 1.02L10 15.591l4.069 2.485c.713.436 1.598-.207 1.404-1.02l-1.106-4.637 3.62-3.102c.635-.544.297-1.584-.536-1.65l-4.752-.382-1.831-4.401Z"
                clip-rule="evenodd" />
            </svg>
            <svg class="size-5 shrink-0 text-yellow-400" viewBox="0 0 20 20" fill="currentColor" aria-hidden="true" data-slot="icon">
              <path
                fill-rule="evenodd"
                d="M10.868 2.884c-.321-.772-1.415-.772-1.736 0l-1.83 4.401-4.753.381c-.833.067-1.171 1.107-.536 1.651l3.62 3.102-1.106 4.637c-.194.813.691 1.456 1.405 1.02L10 15.591l4.069 2.485c.713.436 1.598-.207 1.404-1.02l-1.106-4.637 3.62-3.102c.635-.544.297-1.584-.536-1.65l-4.752-.382-1.831-4.401Z"
                clip-rule="evenodd" />
            </svg>
            <svg class="size-5 shrink-0 text-yellow-400" viewBox="0 0 20 20" fill="currentColor" aria-hidden="true" data-slot="icon">
              <path
                fill-rule="evenodd"
                d="M10.868 2.884c-.321-.772-1.415-.772-1.736 0l-1.83 4.401-4.753.381c-.833.067-1.171 1.107-.536 1.651l3.62 3.102-1.106 4.637c-.194.813.691 1.456 1.405 1.02L10 15.591l4.069 2.485c.713.436 1.598-.207 1.404-1.02l-1.106-4.637 3.62-3.102c.635-.544.297-1.584-.536-1.65l-4.752-.382-1.831-4.401Z"
                clip-rule="evenodd" />
            </svg>
            <svg class="size-5 shrink-0 text-yellow-400" viewBox="0 0 20 20" fill="currentColor" aria-hidden="true" data-slot="icon">
              <path
                fill-rule="evenodd"
                d="M10.868 2.884c-.321-.772-1.415-.772-1.736 0l-1.83 4.401-4.753.381c-.833.067-1.171 1.107-.536 1.651l3.62 3.102-1.106 4.637c-.194.813.691 1.456 1.405 1.02L10 15.591l4.069 2.485c.713.436 1.598-.207 1.404-1.02l-1.106-4.637 3.62-3.102c.635-.544.297-1.584-.536-1.65l-4.752-.382-1.831-4.401Z"
                clip-rule="evenodd" />
            </svg>
            <svg class="size-5 shrink-0 text-yellow-400" viewBox="0 0 20 20" fill="currentColor" aria-hidden="true" data-slot="icon">
              <path
                fill-rule="evenodd"
                d="M10.868 2.884c-.321-.772-1.415-.772-1.736 0l-1.83 4.401-4.753.381c-.833.067-1.171 1.107-.536 1.651l3.62 3.102-1.106 4.637c-.194.813.691 1.456 1.405 1.02L10 15.591l4.069 2.485c.713.436 1.598-.207 1.404-1.02l-1.106-4.637 3.62-3.102c.635-.544.297-1.584-.536-1.65l-4.752-.382-1.831-4.401Z"
                clip-rule="evenodd" />
            </svg>
          </div>
          <div aria-hidden="true" class="ml-4 text-sm text-gray-300">·</div>
          <div class="ml-4 flex">
            <a href="/" class="text-sm font-medium text-[#FF5F49] hover:text-[#FF5F49]/80">See all 190 reviews</a>
          </div>
        </div>
      </div>
    </div>

    <div class="mt-8 lg:col-span-12 lg:col-start-1 lg:row-span-3 lg:row-start-1 lg:mt-0">
      <h2 class="sr-only">Images</h2>

      <div class="relative w-full">
        <img src={wavefront} alt="Wavefront Eurorack module" class="absolute inset-0 h-full w-full object-cover" />
      </div>
    </div>

    <div class="lg:col-span-5">
      <form>
        <a href="/" class="text-sm font-medium text-[#FF5F49] hover:text-[#FF5F49]/80">
          <button
            type="submit"
            class="mt-8 flex w-full items-center justify-center rounded-md border border-transparent bg-[#FF5F49] px-8 py-3 text-base font-medium text-white hover:bg-[#FF5F49]/80 focus:ring-2 focus:ring-[#FF5F49]/80 focus:ring-offset-2 focus:outline-hidden"
            >Buy now</button
          ></a>
      </form>

      <!-- Product details -->
      <div class="mt-10">
        <h2 class="text-sm font-medium text-gray-900">Description</h2>

        <div class="mt-4 space-y-4 text-sm/6 text-gray-500">
          <p>
            Wave is the ring that allows artists and producers to easily control sound, shape effects and send commands. Worn on the index finger, Wave detects the most finesse gestures and enables
            natural interaction with sound through movement.
          </p>
          <p>
            Included with your purchase of Wave, <a href="/softwave" class="text-sm font-medium text-[#FF5F49] hover:text-[#FF5F49]/80">Softwave</a> unlocks the full functionality of your wearable technology.
            Customize each and every input range, CC value, movement curve, and more.
          </p>
          <p>
            When paired with <a class="text-[#FF5F49] hover:text-[#FF5F49]/80" href="/wavefront">Wavefront</a>, Wave switches to a ultra-low sub millisecond transmission layer for instant feedback.
          </p>
        </div>
      </div>

      <div class="mt-8 border-t border-gray-200 pt-8">
        <h2 class="text-sm font-medium text-gray-900">Features</h2>

        <div class="mt-4">
          <ul role="list" class="list-disc space-y-1 pl-5 text-sm/6 text-gray-500 marker:text-gray-300">
            <li class="pl-2">Used by musicians all over the world</li>
            <li class="pl-2">Press record from anywhere in the studio</li>
            <li class="pl-2">Use natural movements to interact with your gear like never before</li>
            <li class="pl-2">Send commands and switch between settings on the ring</li>
            <li class="pl-2">Engineered to enable low-latency Bluetooth LE</li>
            <li class="pl-2">Made with love in Iceland.</li>
            <li class="pl-2 text-sm font-medium text-[#FF5F49] hover:text-[#FF5F49]/80">
              <!-- [TODO]: Fix link (March 05, 2025 14:50, ) -->
              <a href="/wave">Technical Specification </a>
            </li>
          </ul>
        </div>
      </div>
      <div class="mt-8 border-gray-200 pt-8"></div>
    </div>
  </div>
</div>

<Carousel.Root plugins={[youtube_plugin]} opts={{ loop: true }} class="w-full py-32" onmouseenter={youtube_plugin.stop} onmouseleave={youtube_plugin.reset}>
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

<!-- <Testimonials></Testimonials> -->

<Footer></Footer>
