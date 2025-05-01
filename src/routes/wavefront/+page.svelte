<script lang="ts">
  import Header from "$lib/Header.svelte";
  import Footer from "$lib/Footer.svelte";
  import YouTubeCarousel from "$lib/YouTubeCarousel.svelte";
  import Hero from "$lib/Hero.svelte";
  import Testimonial from "$lib/Testimonial.svelte";

  import wavefront_stack from "$lib/assets/wavefront-stack.webp";
  import wavefront_single from "$lib/assets/wavefront-clean-hero-transparent.webp";
  import heymun from "$lib/assets/heymun.webp";
</script>

<div class="relative mx-auto flex min-h-screen w-full flex-1 flex-col px-5 md:px-[50px]">
  <Header />
  <Hero
    title="WAVEFRONT"
    description="Elevate any modular setup. This customizable Eurorack receiver puts you in control of shaping effects, triggering samples and controlling gates — with your Wave Ring or your other favorite Bluetooth device."
    price="$349"
    mainImage={wavefront_stack}
    altImage={wavefront_single}
    altText="Wavefront Bluetooth LE Eurorack module"
    cartUrl="/" />
</div>

<div class="w-full overflow-hidden">
  <img src={heymun} alt="HEYMUN is a Malaysian born Sydney based." class="w-full object-cover" />
</div>
<div class="@container -mt-4 grid grid-cols-10">
  <div class="col-span-3 col-start-1 md:col-span-1 md:col-start-3">
    <img src={quote} alt="Quotation mark" />
  </div>
</div>
<div class="grid grid-cols-10 gap-4 px-5 pt-7 md:gap-0 md:px-0">
  <div class="col-span-8 col-start-3 text-xl md:col-span-3 md:col-start-3 md:text-4xl">
    I am blown away by the Wave ring and the Wavefront module, I am now able to communicate, express, and explore sounds via my movements from my Eurorack system.
  </div>
  <div class="col-span-8 col-start-3 mt-4 space-y-2 md:col-span-2 md:col-start-8 md:mt-0 md:flex md:flex-col">
    <div class="text-xl md:text-4xl">Heymun</div>
    <div class="text-lg leading-tight opacity-50 md:text-base">Music composer, producer and musician</div>
  </div>
</div>

<YouTubeCarousel class="w-full overflow-hidden py-40 md:py-68" ids={["Mxx2AuXiYWM", "I3hlnmP7yJU", "OxGjLVSPjCE", "MqfF2m-Mi-Y"]} />

<Footer />