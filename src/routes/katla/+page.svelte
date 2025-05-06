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
  <!-- <img class="absolute inset-0 -z-10 h-[100dvh] w-full object-cover object-top" src={katla_bg} alt="Background" /> -->
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

<div class="space-y-24">
  <div class="w-full border-b border-[#F6F6F6] py-1 opacity-30"></div>

  <div class="grid grid-cols-10 md:px-[50px]">
    <p class="cap col-span-2 col-start-3 text-xl uppercase">Key features</p>
    <ul class="col-span-3 col-start-7 space-y-8 text-lg capitalize">
      <li>→ Five digiloc voices</li>
      <li>→ Handmade basalt side-panels</li>
      <li>→ Paraphonic-inpired polyphony</li>
      <li>→ Volcanic modulation matrix</li>
      <li>→ 80s inspired digital reverb</li>
      <li>→ Analog wavefolder and distortion</li>
      <li>→ Mountable in standard rack</li>
    </ul>
  </div>

  <div class="w-full border-b border-[#F6F6F6] py-1 opacity-30"></div>

  <div class="grid grid-cols-10 md:px-[50px]">
    <p class="col-span-2 col-start-3 text-xl uppercase">Hardware</p>
    <ul class="col-span-3 col-start-7 space-y-8 text-lg capitalize">
      <li>→ Lava rock knobs</li>
      <li>→ Lava rock side-panels</li>
      <li>→ Aluminium enclosure</li>
      <!-- [TODO]: Update with real dimenstions and weight (May 06, 2025 00:17, Oli) -->
      <li>→ Dimensions are 43cm x 33cm x 25cm</li>
      <li>→ Roughly 3kg</li>
    </ul>
  </div>

  <div class="w-full border-b border-[#F6F6F6] py-1 opacity-30"></div>

  <div class="grid grid-cols-10 md:px-[50px]">
    <p class="col-span-2 col-start-3 text-xl uppercase">Two preset modes</p>
    <ul class="col-span-3 col-start-7 space-y-8 text-lg capitalize">
      <li>→ Store full panel as user preset</li>
      <li>→ Store each row as row preset</li>
    </ul>
  </div>

  <div class="w-full border-b border-[#F6F6F6] py-1 opacity-30"></div>

  <div class="grid grid-cols-10 md:px-[50px]">
    <p class="col-span-2 col-start-3 text-xl uppercase">IN THE BOX</p>
    <ul class="col-span-3 col-start-7 space-y-8 text-lg capitalize">
      <li>→ KATLA</li>
      <li>→ USB-C cable power supply</li>
      <li>→ 2x rack ears</li>
      <li>→ Your own piece of Iceland</li>
    </ul>
  </div>
</div>

<Footer />
