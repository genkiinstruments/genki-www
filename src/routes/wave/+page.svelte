<script lang="ts">
  import Header from "$lib/Header.svelte";
  import Footer from "$lib/Footer.svelte";
  import YouTubeCarousel from "$lib/YouTubeCarousel.svelte";
  import Hero from "$lib/Hero.svelte";
  import Testimonial from "$lib/Testimonial.svelte";
  import { onMount } from "svelte";

  import wave_hand from "$lib/assets/wave-hand.webp";
  import wave_render from "$lib/assets/wave-render.webp";
  import bergur from "$lib/assets/bergur-in-the-studio.webp";
  
  // Enable browser history navigation with horizontal swipe
  onMount(() => {
    // Set up swipe detection for browser navigation
    const touchStartHandler = (e: TouchEvent) => {
      // Only capture wide horizontal swipes near the edge of the screen
      if (e.touches[0].clientX < 50 || e.touches[0].clientX > window.innerWidth - 50) {
        // Allow browser to handle this swipe for navigation
        e.stopPropagation();
      }
    };
    
    document.addEventListener('touchstart', touchStartHandler, {passive: true, capture: true});
    
    return () => {
      document.removeEventListener('touchstart', touchStartHandler, {capture: true});
    };
  });
</script>

<div class="@container mx-auto flex min-h-screen w-full flex-1 flex-col px-5 md:px-[50px]">
  <Header />

  <Hero
    title="WAVE"
    description="Wave is the ring that allows artists and producers to easily control sound, shape effects and send commands. Detecting the most finesse gestures, Wave enables natural interaction with sound through movement."
    price="$349"
    mainImage={wave_hand}
    altImage={wave_render}
    altText="Wave ring for musicians"
    cartUrl="/" />
</div>

<div class="w-full overflow-hidden">
  <img src={bergur} alt="Bergur Torisson in the studio" class="hidden w-full object-cover sm:block" />
  <img src={bergur_mobile} alt="Bergur Torisson in the studio" class="block w-full object-cover sm:hidden" />
</div>
<div class="@container -mt-10 grid grid-cols-10">
  <div class="col-span-3 col-start-1 md:col-start-3">
    <img src={quote} alt="Quotation mark" />
  </div>
</div>
<div class="grid grid-cols-10 gap-4 px-5 pt-10 md:gap-0 md:px-0">
  <div class="col-span-8 col-start-3 text-xl md:col-span-3 md:col-start-3 md:text-4xl">Wave adds a dimension to musical creativity</div>
  <div class="col-span-8 col-start-3 mt-4 space-y-2 md:col-span-2 md:col-start-8 md:mt-0 md:flex md:flex-col">
    <div class="text-xl md:text-4xl">Bergur Þórisson</div>
    <div class="text-lg leading-tight opacity-50 md:text-base">Grammy nominated musical director (Björk)</div>
  </div>
</div>

<YouTubeCarousel class="w-full overflow-hidden py-40 md:py-68" ids={["9pEGV0H5nTw", "foX4YGlUg4g", "a8aStUjS6uk", "oOKxmoZd4H8", "vJ-KT38i9Ls", "puQloBX3XPQ"]} />

<Footer />

