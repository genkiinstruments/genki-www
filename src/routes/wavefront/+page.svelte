<script lang="ts">
  import Header from "$lib/Header.svelte";
  import Footer from "$lib/Footer.svelte";
  import YouTubeCarousel from "$lib/YouTubeCarousel.svelte";
  import Hero from "$lib/Hero.svelte";
  import Testimonial from "$lib/Testimonial.svelte";
  import BFCMBanner from "$lib/BFCMBanner.svelte";

  import wavefront_stack from "$lib/assets/WaveFront_01.webp";
  import wavefront_single from "$lib/assets/WaveFront_02.webp";
  import heymun from "$lib/assets/Testimonials_Heymun_Large.webp";
  import heymun_mobile from "$lib/assets/wavefront-testimonials-heymun-mobile.webp";
</script>

<div class="relative mx-auto flex min-h-screen w-full flex-1 flex-col px-5 md:px-[50px]">
  <Header />
  <BFCMBanner message="Ultimate Bundle with Wave, Wavefront, WIDI Master & Cosmos for $599 (save $247)" anchor="ultimate-bundle" />
  <Hero
    title="WAVEFRONT"
    description="Elevate any modular setup. This customizable Eurorack receiver puts you in control of shaping effects, triggering samples and controlling gates — with your Wave Ring or your other favorite Bluetooth device."
    price="$349"
    mainImage={wavefront_stack}
    altImage={wavefront_single}
    altText="Wavefront Bluetooth LE Eurorack module"
    cartUrl="https://buy.stripe.com/14k8xj6WYgCG66keUX" />
</div>

<Testimonial
  src={heymun}
  mobileSrc={heymun_mobile}
  quote="I am blown away by the Wavefront module. Now I am able to communicate, express, and explore sounds via my movements on my Eurorack system."
  name="Heymun"
  occupation="Music composer, producer and musician"
  alt="HEYMUN is a Malaysian born Sydney based." />

<YouTubeCarousel class="w-full overflow-hidden py-40 md:py-68" ids={["Mxx2AuXiYWM", "I3hlnmP7yJU", "OxGjLVSPjCE", "MqfF2m-Mi-Y"]} />

<Footer />
