<script lang="ts">
  import Header from "$lib/Header.svelte";
  import Footer from "$lib/Footer.svelte";
  import YouTubeCarousel from "$lib/YouTubeCarousel.svelte";
  import Testimonial from "$lib/Testimonial.svelte";
  import Hero from "$lib/Hero.svelte";
  import InteractiveString from "$lib/InteractiveString.svelte";
  import BFCMBanner from "$lib/BFCMBanner.svelte";

  import softwave_hero from "$lib/assets/Softwave.webp";
  import toti_mobile from "$lib/assets/softwave-testimonials-toti-mobile.webp";
  import toti from "$lib/assets/toti-cool.webp";
</script>

<div class="relative mx-auto flex min-h-screen w-full flex-1 flex-col px-5 md:px-[50px]">
  <Header />
  <BFCMBanner message="Wave Ring bundles with huge savings - Two Waves for $499 or Ultimate Bundle for $599" anchor="ultimate-bundle" />
  <Hero
    title="Softwave"
    description="The key that unlocks the full potential of your Wave Ring. Control music with gestures, customize each button, and create saved presets from one seamlessly integrated application."
    price="FREE"
    mainImage={softwave_hero}
    altText="Softwave, companion software to the Wave music ring"
    flipped={true} />
</div>

<Testimonial
  src={toti}
  mobileSrc={toti_mobile}
  quote="The depth of this software knows no bounds"
  name="Tóti Guðnason"
  occupation="Music composer, producer and musician"
  alt="Tóti Guðnason in the studio" />

<YouTubeCarousel class="w-full overflow-hidden py-40 md:py-68" ids={["9pEGV0H5nTw", "foX4YGlUg4g", "a8aStUjS6uk", "oOKxmoZd4H8", "vJ-KT38i9Ls", "puQloBX3XPQ"]} />

<div class="flex h-full w-full flex-col items-center justify-center py-48 sm:py-96">
  <div class="group mb-6 flex w-full items-center justify-center text-center text-5xl/20 md:col-span-3 md:col-start-2 md:text-left md:text-3xl lg:text-7xl">Downloaded over 30,000 times</div>
  <div class="flex flex-col items-center justify-center space-y-8 md:col-span-3 md:col-start-7 md:text-left">
    <div class="flex flex-col justify-center space-y-4">
      <a href="https://github.com/genkiinstruments/releases/releases/tag/softwave" class="mt-3 flex w-full">
        <div class="relative flex cursor-pointer flex-col items-center justify-end md:justify-center">
          <span class="-mb-4 py-4 text-sm tracking-widest text-white uppercase sm:-mb-1 sm:py-0">Download now</span>
          <InteractiveString />
        </div>
      </a>
    </div>
  </div>
</div>

<Footer />
