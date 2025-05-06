<script lang="ts">
  import Header from "$lib/Header.svelte";
  import Footer from "$lib/Footer.svelte";
  import YouTubeCarousel from "$lib/YouTubeCarousel.svelte";

  import katla_logo from "$lib/assets/katla-logo.webp";
  import katla_bg from "$lib/assets/katla-bg.webp";
  import herdis from "$lib/assets/herdis-stefans.webp";
  import herdis_mobile from "$lib/assets/katla-testimonials-herdis-mobile.webp";
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
    flipped={true}
    cartUrl="/" />
</div>

<Testimonial
  src={herdis}
  mobileSrc={herdis_mobile}
  quote="I quickly got very interesting and exciting results"
  name="Herdís Stefánsdóttir"
  occupation="Composer of music for multimedia, songwriter, and an electronic musician"
  alt="Herdís Stefánsdóttir in the studio" />

<YouTubeCarousel class="w-full overflow-hidden py-40 md:py-68" ids={["vPgHiyOXmMQ", "By-shXpcjSg", "BpfhsBbgY8M"]} />

<Footer />
