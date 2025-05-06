<script lang="ts">
  import Header from "$lib/Header.svelte";
  import Footer from "$lib/Footer.svelte";
  import YouTubeCarousel from "$lib/YouTubeCarousel.svelte";
  import Hero from "$lib/Hero.svelte";
  import Testimonial from "$lib/Testimonial.svelte";

  import cosmos from "$lib/assets/cosmos-main.webp";
  import viktor from "$lib/assets/viktor-cosmos.webp";
  import viktor_mobile from "$lib/assets/cosmos-testimonials-viktor-mobile.png.webp";
</script>

<Header />

<div class="relative mx-auto flex min-h-screen w-full flex-1 flex-col px-5 md:px-[50px]">
  <Hero
    title="COSMOS"
    description="Cosmos is a softsynth with hand-crafted effects and a playful interface. Shape sound with 8-voice polyphony, flexible modulation, and the spiralling galaxy arp. Dive into unexpected sonic turns. Try it for free!"
    price="$99"
    mainImage={cosmos}
    altText="Cosmos synthesizer interface"
    cartUrl="/"
    flipped={true} />
</div>

<Testimonial
  src={viktor}
  mobileSrc={viktor_mobile}
  quote="Cosmos is such a unique way to represent audio."
  name="Viktor Ingi Guðmundsson"
  occupation="Audio director at Myrkur Games"
  alt="Audio director at Myrkur Games" />

<YouTubeCarousel class="w-full overflow-hidden py-40 md:py-68" ids={["hctbLL4QM9A", "oIC_tuHz7Lc", "mbNBF-5gRm8", "mL7KyOQ1rtk", "KgfDu7Jqe8s", "eLHipJuft6w", "QCxFXucFRTI"]} />

<Footer />
