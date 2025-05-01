<script lang="ts">
  import Header from "$lib/Header.svelte";
  import Footer from "$lib/Footer.svelte";
  import YouTubeCarousel from "$lib/YouTubeCarousel.svelte";
  import Testimonial from "$lib/Testimonial.svelte";
  import Hero from "$lib/Hero.svelte";

  import softwave_hero from "$lib/assets/softwave-hero.webp";
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
