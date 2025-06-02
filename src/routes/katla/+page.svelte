<script lang="ts">
  import Header from "$lib/Header.svelte";
  import Footer from "$lib/Footer.svelte";
  import YouTubeCarousel from "$lib/YouTubeCarousel.svelte";

  import katla_bg from "$lib/assets/katla-hero-render2.webp";
  import katla_mobile_bg from "$lib/assets/katla-mobile-hero.webp";
  import herdis from "$lib/assets/Testimonials_Herdis_Medium.webp";
  import herdis_mobile from "$lib/assets/herdis-mobile.webp";
  import Testimonial from "$lib/Testimonial.svelte";
  import ScrollIndicator from "$lib/ScrollIndicator.svelte";
  import InteractiveString from "$lib/InteractiveString.svelte";

  const sold = 5;

  type ListItemProps = {
    title: string;
    features: string[];
  };
</script>

<div class="relative mx-auto flex min-h-[70dvh] w-full flex-1 flex-col px-5 md:min-h-[100dvh] md:px-[50px]">
  <Header />
  <div class="group mb-6 flex w-full items-center justify-center text-center text-4xl md:hidden">PRE-ORDER</div>
  <img class="absolute inset-0 -z-10 hidden h-auto w-full mask-t-from-60% object-cover sm:block" src={katla_bg} alt="Background" />
  <img class="absolute inset-0 -z-10 h-auto w-full mask-t-from-60% object-cover sm:hidden" src={katla_mobile_bg} alt="Background" />
</div>

<ScrollIndicator />

<div class="grid items-center py-8 sm:py-48 md:grid-cols-10 md:items-stretch">
  <div class="group -mt-36 mb-6 flex w-full items-center justify-center text-center text-3xl md:col-span-3 md:col-start-2 md:text-left md:text-5xl lg:text-9xl">
    LIMITED ROUND <br />
    {sold}/100 SOLD
  </div>

  <div class="flex items-center justify-center space-y-8 md:col-span-3 md:col-start-7 md:text-left">
    <div class="flex flex-col space-y-4">
      <p class="mt-4 justify-start px-5 text-xl md:px-0 md:text-5xl lg:text-6xl">
        Five-voice analog synthesizer from Iceland. Volcanic modulation, tactile sliders, with lava rock knobs and side-panels.
      </p>
      <p class="mt-4 justify-start px-5 text-xl md:px-0 md:text-5xl lg:text-6xl">Crafted for performers and sound designers seeking a unique instrument of volcanic caos.</p>
      <div class="mt-6 flex w-full flex-row items-center justify-center gap-6 md:justify-between">
        <div class="hidden font-mono text-2xl md:block md:text-3xl lg:text-4xl">$4,990</div>
        <a href="https://buy.stripe.com/8wMeVH1CE9aedyMcMN" class="md:justify-begin mt-3 flex w-full items-center justify-center">
          <div class="relative flex cursor-pointer flex-col items-center justify-center md:justify-end">
            <span class="-mb-4 py-4 text-sm tracking-widest text-white uppercase sm:-mb-1 sm:py-0">Buy now</span>
            <InteractiveString />
          </div>
        </a>
      </div>
    </div>
  </div>
</div>

<Testimonial
  src={herdis}
  mobileSrc={herdis_mobile}
  quote="I quickly got very interesting and exciting results"
  name="Herdís Stefánsdóttir"
  occupation="Composer of music for multimedia, songwriter, and an electronic musician"
  alt="Herdís Stefánsdóttir in the studio" />

<YouTubeCarousel class="w-full py-40 md:py-68" ids={["LBiltGvV4UI", "2c85TVuPOm4", "vPgHiyOXmMQ", "By-shXpcjSg", "BpfhsBbgY8M"]} />

{#snippet ListItem({ title, features }: ListItemProps)}
  <div class="grid grid-cols-10 space-y-8 px-5 md:space-y-0 md:px-[50px]">
    <p class="col-span-full font-bold uppercase md:col-span-2 md:col-start-3">{title}</p>
    <ul class="col-span-full col-start-2 space-y-12 md:col-span-3 md:col-start-7">
      {#each features as feature, i (i)}
        <li>→ {feature}</li>
      {/each}
    </ul>
  </div>
{/snippet}

<div class="text-md space-y-12 md:space-y-24 lg:text-3xl">
  <div class="w-full border-b border-[#F6F6F6] py-1 opacity-30"></div>

  {@render ListItem({ title: "Information", features: ["First pre-order run", "Limited units available", "Shipping Q4 2025", "Full support"] })}

  <div class="w-full border-b border-[#F6F6F6] py-1 opacity-30"></div>
  {@render ListItem({
    title: "Key features",
    features: [
      "Five digiloc voices",
      "Handmade basalt side-panels",
      "Paraphonic-inpired polyphony",
      "Volcanic modulation matrix",
      "80s inspired digital reverb",
      "Analog filter, mixer, wavefolder and distortion",
      "Mountable in standard rack",
    ],
  })}

  <div class="w-full border-b border-[#F6F6F6] py-1 opacity-30"></div>

  {@render ListItem({ title: "Hardware", features: ["Lava rock knobs", "Lava rock side-panels", "Rigid aluminium enclosure", "Dimensions are 43 by 33 by 25 cm³", "Weights roughly 3 kg"] })}

  <div class="w-full border-b border-[#F6F6F6] py-1 opacity-30"></div>

  {@render ListItem({ title: "Two preset modes", features: ["Store panel state as user preset", "Store each row independently"] })}

  <div class="w-full border-b border-[#F6F6F6] py-1 opacity-30"></div>

  {@render ListItem({ title: "IN THE BOX", features: ["KATLA", "2x rack ears", "2x basalt side-panels", "2x aluminium rack ears"] })}

  <div class="w-full border-b border-[#F6F6F6] py-1 opacity-30"></div>
</div>

<div class="flex h-full w-full flex-col items-center justify-center py-48 sm:py-96">
  <div class="group mb-6 flex w-full items-center justify-center text-center text-6xl/20 md:col-span-3 md:col-start-2 md:text-left md:text-5xl lg:text-9xl">{sold}/100 SOLD</div>
  <div class="flex flex-col items-center justify-center space-y-8 md:col-span-3 md:col-start-7 md:text-left">
    <div class="flex flex-col justify-center space-y-4">
      <a href="https://buy.stripe.com/8wMeVH1CE9aedyMcMN" class="mt-3 flex w-full">
        <div class="relative flex cursor-pointer flex-col items-center justify-end md:justify-center">
          <span class="-mb-4 py-4 text-sm tracking-widest text-white uppercase sm:-mb-1 sm:py-0">Buy now</span>
          <InteractiveString />
        </div>
      </a>
    </div>
  </div>
</div>

<div class="w-full border-b border-[#F6F6F6] py-1 opacity-30"></div>

<Footer />
