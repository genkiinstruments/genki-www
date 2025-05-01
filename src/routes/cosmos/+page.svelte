<script lang="ts">
  import Header from "$lib/Header.svelte";
  import Footer from "$lib/Footer.svelte";
  import YouTubeCarousel from "$lib/YouTubeCarousel.svelte";
  import Hero from "$lib/Hero.svelte";
  import Testimonial from "$lib/Testimonial.svelte";

  import cosmos from "$lib/assets/cosmos-main.webp";
  import viktor from "$lib/assets/viktor-cosmos.webp";
</script>

<div class="relative mx-auto flex min-h-screen w-full flex-1 flex-col px-5 md:px-[50px]">
  <Header />

  <Hero
    title="COSMOS"
    description="Cosmos is a softsynth with hand-crafted effects and a playful interface. Shape sound with 8-voice polyphony, flexible modulation, and the spiralling galaxy arp. Dive into unexpected sonic turns. Try it for free!"
    price="$99"
    mainImage={cosmos}
    altText="Cosmos synthesizer interface"
    cartUrl="/"
    flippedLayout={true} />
</div>

<div class="w-full overflow-hidden">
  <img src={viktor} alt="Audio director at Myrkur Games" class="w-full object-cover" />
</div>
<div class="@container -mt-4 grid grid-cols-10">
  <div class="col-span-3 col-start-1 md:col-span-1 md:col-start-3">
    <img src={quote} alt="Quotation mark" />
  </div>
</div>
<div class="grid grid-cols-10 gap-4 px-5 pt-7 md:gap-0 md:px-0">
  <div class="col-span-8 col-start-3 text-xl md:col-span-3 md:col-start-3 md:text-4xl">Cosmos is such a unique way to represent audio.</div>
  <div class="col-span-8 col-start-3 mt-4 space-y-2 md:col-span-2 md:col-start-8 md:mt-0 md:flex md:flex-col">
    <div class="text-xl md:text-4xl">Viktor Ingi Guðmundsson</div>
    <div class="text-lg leading-tight opacity-50 md:text-base">Audio director at Myrkur Games</div>
  </div>
</div>

<YouTubeCarousel class="w-full overflow-hidden py-40 md:py-68" ids={["hctbLL4QM9A", "oIC_tuHz7Lc", "mbNBF-5gRm8", "mL7KyOQ1rtk", "KgfDu7Jqe8s", "eLHipJuft6w", "QCxFXucFRTI"]} />

<Footer />
