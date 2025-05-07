<script lang="ts">
  import Header from "$lib/Header.svelte";
  import Footer from "$lib/Footer.svelte";
  import YouTubeCarousel from "$lib/YouTubeCarousel.svelte";
  import Hero from "$lib/Hero.svelte";
  import Testimonial from "$lib/Testimonial.svelte";
  import InteractiveString from "$lib/InteractiveString.svelte";

  import cosmos from "$lib/assets/cosmos-main.webp";
  import viktor from "$lib/assets/viktor-cosmos.webp";
  import viktor_mobile from "$lib/assets/cosmos-testimonials-viktor-mobile.png.webp";
</script>

<div class="relative mx-auto flex min-h-screen w-full flex-1 flex-col px-5 md:px-[50px]">
  <Header />
  <Hero
    title="COSMOS"
    description="Cosmos is a softsynth with hand-crafted effects and a playful interface. Shape sound with 8-voice polyphony, flexible modulation, and the spiralling galaxy arp. Dive into unexpected sonic turns. Try it for free!"
    price="$99"
    mainImage={cosmos}
    altText="Cosmos synthesizer interface"
    cartUrl="https://buy.stripe.com/aEU14R0yAcmq1Q47sw"
    />
</div>

<Testimonial
  src={viktor}
  mobileSrc={viktor_mobile}
  quote="Cosmos is such a unique way to represent audio."
  name="Viktor Ingi Guðmundsson"
  occupation="Audio director at Myrkur Games"
  alt="Audio director at Myrkur Games" />

<YouTubeCarousel class="w-full overflow-hidden py-40 md:py-68" ids={["hctbLL4QM9A", "oIC_tuHz7Lc", "mbNBF-5gRm8", "mL7KyOQ1rtk", "KgfDu7Jqe8s", "eLHipJuft6w", "QCxFXucFRTI"]} />

<div class="flex flex-col justify-center items-center sm:py-96 py-48  w-full h-full">
  <div class="group mb-6 flex w-full items-center justify-center md:col-span-3 md:col-start-2 md:text-left text-center text-5xl/20 md:text-3xl lg:text-5xl">Downloaded over 30,000 times</div>
  <div class="flex flex-col items-center justify-center space-y-8 md:col-span-3 md:col-start-7 md:text-left">
    <div class="flex flex-col space-y-4 justify-center">
        <a href="https://github.com/genkiinstruments/releases/releases/tag/cosmos" class="mt-3 flex w-full">
          <div class="relative flex cursor-pointer flex-col items-center justify-end md:justify-center">
            <span class="-mb-4 py-4 text-sm tracking-widest text-white uppercase sm:-mb-1 sm:py-0">Download now</span>
            <InteractiveString />
          </div>
        </a>
    </div>
  </div>
</div>

<Footer />
