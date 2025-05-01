<script lang="ts">
  import Header from "$lib/Header.svelte";
  import Footer from "$lib/Footer.svelte";
  import YouTubeCarousel from "$lib/YouTubeCarousel.svelte";
  import Testimonial from "$lib/Testimonial.svelte";
  import Hero from "$lib/Hero.svelte";

  import softwave_hero from "$lib/assets/softwave-hero.webp";
  import toti_mobile from "$lib/assets/softwave-testimonials-toti-mobile.webp";
  import toti from "$lib/assets/toti-cool.webp";
</script>

<div class="relative mx-auto flex min-h-screen w-full flex-1 flex-col px-5 md:px-[50px]">
  <Header />
  <Hero
    title="Softwave"
    description="The key that unlocks the full potential of your Wave Ring. Control music with gestures, customize each button, and create saved presets from one seamlessly integrated application."
    price="FREE"
    mainImage={softwave_hero}
    altText="Softwave, companion software to the Wave music ring"
    cartUrl="/"
    flippedLayout={true} />
</div>

<Testimonial
  src={toti}
  mobileSrc={toti_mobile}
  quote="The depth of this software knows no bounds"
  name="Tóti Guðnason"
  occupation="Music composer, producer and musician"
  alt="Tóti Guðnason in the studio" />

<YouTubeCarousel class="w-full overflow-hidden py-40 md:py-68" ids={["9pEGV0H5nTw", "foX4YGlUg4g", "a8aStUjS6uk", "oOKxmoZd4H8", "vJ-KT38i9Ls", "puQloBX3XPQ"]} />

<Footer />
