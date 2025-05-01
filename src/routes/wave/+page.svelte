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
  import bergur_mobile from "$lib/assets/wave-testimonials-bergur-mobile.webp";

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

<Testimonial
  src={bergur}
  mobileSrc={bergur_mobile}
  quote="Wave adds a dimension to musical creativity"
  name="Bergur Þórisson"
  occupation="Grammy nominated musical director (Björk)"
  alt="Bergur Torisson in the studio" />

<YouTubeCarousel class="w-full overflow-hidden py-40 md:py-68" ids={["9pEGV0H5nTw", "foX4YGlUg4g", "a8aStUjS6uk", "oOKxmoZd4H8", "vJ-KT38i9Ls", "puQloBX3XPQ"]} />

<Footer />

