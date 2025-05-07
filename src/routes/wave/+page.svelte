<script lang="ts">
  import Header from "$lib/Header.svelte";
  import Footer from "$lib/Footer.svelte";
  import YouTubeCarousel from "$lib/YouTubeCarousel.svelte";
  import Hero from "$lib/Hero.svelte";
  import Testimonial from "$lib/Testimonial.svelte";
  import { onMount } from "svelte";

  import wave_hand from "$lib/assets/Wave_01.webp";
  import wave_render from "$lib/assets/Wave_02_Larger.webp";
  import bergur from "$lib/assets/Testimonials_Bergur_Larger.webp";
  import bergur_mobile from "$lib/assets/wave-testimonials-bergur-mobile.webp";
</script>

<div class="@container mx-auto flex min-h-screen w-full flex-1 flex-col px-5 md:px-[50px]">
  <Header />
  <Hero
    title="WAVE"
    description="Wave is the ring that allows artists and producers to easily control sound, shape effects and send commands. Detecting the most finesse gestures, Wave enables natural interaction with sound through movement."
    price="$349"
    altImage={wave_hand}
    mainImage={wave_render}
    altText="Wave ring for musicians"
    cartUrl="https://buy.stripe.com/eVacNz4OQdqubqE7su" />
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
