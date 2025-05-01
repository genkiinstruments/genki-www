<script lang="ts">
  import Header from "$lib/Header.svelte";
  import Footer from "$lib/Footer.svelte";
  import YouTubeCarousel from "$lib/YouTubeCarousel.svelte";

  import katla_logo from "$lib/assets/katla-logo.webp";
  import katla_bg from "$lib/assets/katla-bg.webp";
  import herdis from "$lib/assets/herdis-stefans.webp";
  import Hero from "$lib/Hero.svelte";
  import Testimonial from "$lib/Testimonial.svelte";
</script>

<div class="relative mx-auto flex min-h-screen w-full flex-1 flex-col px-5 md:px-[50px]">
  <Header />
  <img class="absolute inset-0 -z-10 h-[100dvh] w-full object-cover object-top" src={katla_bg} alt="Background" />
  <Hero
    title="Katla"
    logoSrc={katla_logo}
    description="Five-voice analog synthesizer from Iceland. Volcanic modulation, tactile sliders, with lava rock knobs and side-panels. Crafted for performers and sound designers seeking a unique chaos instrument."
    price="$349"
    altText="Katla synthesizer"
    flippedLayout={true}
    cartUrl="/" />
</div>

<div class="w-full overflow-hidden">
  <img src={herdis} alt="Herdís Stefánsdóttir in the studio" class="w-full object-cover" />
</div>
<div class="@container -mt-4 grid grid-cols-10">
  <div class="col-span-3 col-start-1 md:col-span-1 md:col-start-3">
    <img src={quote} alt="Quotation mark" />
  </div>
</div>
<div class="grid grid-cols-10 gap-4 px-5 pt-7 md:gap-0 md:px-0">
  <div class="col-span-8 col-start-3 text-xl md:col-span-3 md:col-start-3 md:text-4xl">I quickly got very interesting and exciting results</div>
  <div class="col-span-8 col-start-3 mt-4 space-y-2 md:col-span-2 md:col-start-8 md:mt-0 md:flex md:flex-col">
    <div class="text-xl md:text-4xl">Herdís Stefánsdóttir</div>
    <div class="text-lg leading-tight opacity-50 md:text-base">Composer of music for multimedia, songwriter, and an electronic musician</div>
  </div>
</div>

<YouTubeCarousel class="w-full overflow-hidden py-40 md:py-68" ids={["vPgHiyOXmMQ", "By-shXpcjSg", "BpfhsBbgY8M"]} />

<Footer />
