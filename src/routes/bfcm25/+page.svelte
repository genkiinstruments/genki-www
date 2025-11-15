<script lang="ts">
  import { onMount } from "svelte";
  import Header from "$lib/Header.svelte";
  import ultimate_img from "$lib/assets/bfcm-ultimate.webp";
  import two_waves_img from "$lib/assets/bfcm-two-waves.webp";
  import katla_img from "$lib/assets/bfcm-katla.webp";
  import Footer from "$lib/Footer.svelte";

  onMount(() => {
    // Handle hash navigation on page load
    if (window.location.hash) {
      const id = window.location.hash.substring(1);
      const element = document.getElementById(id);
      if (element) {
        setTimeout(() => {
          element.scrollIntoView({ behavior: "smooth", block: "start" });
        }, 100);
      }
    }
  });
</script>

<svelte:head>
  <style>
    html {
      scroll-behavior: smooth;
    }
  </style>
</svelte:head>

<div class="bg-background min-h-screen text-[#DFDFDF]">
  <div class="bg-background px-5 md:px-[50px]">
    <Header />
  </div>

  <div class="bg-background mx-auto max-w-6xl px-5 py-16 md:px-[50px] md:py-24">
    <div class="mb-16 text-center">
      <h1 class="mb-4 text-5xl font-bold md:text-7xl">Black Friday</h1>
      <p class="text-muted-foreground text-xl md:text-2xl">Limited time only</p>
    </div>

    <div class="grid gap-8 md:grid-cols-1 lg:gap-12">
      <!-- Ultimate Genki Bundle -->
      <div
        id="ultimate-bundle"
        class="group relative scroll-mt-24 overflow-hidden rounded-2xl border border-gray-800 bg-gradient-to-br from-[#1a1a1a] to-[#0d0d0d] transition-all duration-300 hover:border-gray-600">
        <div class="grid gap-8 md:grid-cols-2 md:items-center">
          <div class="relative z-10 p-8 md:p-12">
            <div class="mb-6">
              <span class="inline-block rounded-full bg-red-600/20 px-4 py-1 text-sm font-medium text-red-400">Save $247</span>
            </div>
            <h2 class="mb-4 text-3xl font-bold md:text-4xl">Ultimate Bundle</h2>

            <!-- Mobile image - shows after title -->
            <div class="mb-6 flex items-center justify-center md:hidden">
              <img src={ultimate_img} alt="Ultimate Genki Bundle" class="h-auto w-full max-w-md rounded-lg" />
            </div>

            <p class="text-muted-foreground mb-6 text-lg">Wave + Wavefront + WIDI Master + Cosmos</p>
            <div class="mb-8 flex items-baseline gap-4">
              <span class="text-5xl font-bold text-white">$599</span>
              <span class="text-muted-foreground text-2xl line-through">$846</span>
            </div>
            <a
              href="https://buy.stripe.com/9B64gz1H1e6vabd1Ca5c406?prefilled_promo_code=ULTIMATE30"
              class="inline-flex items-center justify-center rounded-lg bg-white px-8 py-4 text-lg font-medium text-black transition-all duration-200 hover:bg-gray-200">
              Buy now
            </a>
          </div>
          <!-- Desktop image -->
          <div class="relative hidden items-center justify-center p-8 md:flex md:p-12">
            <img src={ultimate_img} alt="Ultimate Genki Bundle" class="h-auto w-full max-w-md rounded-lg" />
          </div>
        </div>
        <div class="absolute top-0 right-0 h-full w-1/3 bg-gradient-to-l from-red-600/10 to-transparent opacity-0 transition-opacity duration-300 group-hover:opacity-100"></div>
      </div>

      <!-- Two Waves -->
      <div
        id="two-waves"
        class="group relative scroll-mt-24 overflow-hidden rounded-2xl border border-gray-800 bg-gradient-to-br from-[#1a1a1a] to-[#0d0d0d] transition-all duration-300 hover:border-gray-600">
        <div class="grid gap-8 md:grid-cols-2 md:items-center">
          <!-- Desktop image -->
          <div class="relative hidden items-center justify-center p-8 md:order-2 md:flex md:p-12">
            <img src={two_waves_img} alt="Two Waves Bundle" class="h-auto w-full max-w-md rounded-lg" />
          </div>
          <div class="relative z-10 p-8 md:order-1 md:p-12">
            <div class="mb-6">
              <span class="inline-block rounded-full bg-red-600/20 px-4 py-1 text-sm font-medium text-red-400">Save $199</span>
            </div>
            <h2 class="mb-4 text-3xl font-bold md:text-4xl">Two Waves</h2>

            <!-- Mobile image - shows after title -->
            <div class="mb-6 flex items-center justify-center md:hidden">
              <img src={two_waves_img} alt="Two Waves Bundle" class="h-auto w-full max-w-md rounded-lg" />
            </div>

            <p class="text-muted-foreground mb-6 text-lg">The Christmas gift for your musician relatives, or just one for each hand? Great offer, either way!</p>
            <div class="mb-8 flex items-baseline gap-4">
              <span class="text-5xl font-bold text-white">$499</span>
              <span class="text-muted-foreground text-2xl line-through">$698</span>
            </div>
            <a
              href="https://buy.stripe.com/cNi3cv4Td8Mb1EHcgO5c409?prefilled_promo_code=BFCM25"
              class="inline-flex items-center justify-center rounded-lg bg-white px-8 py-4 text-lg font-medium text-black transition-all duration-200 hover:bg-gray-200">
              Buy now
            </a>
          </div>
        </div>
        <div class="absolute top-0 right-0 h-full w-1/3 bg-gradient-to-l from-red-600/10 to-transparent opacity-0 transition-opacity duration-300 group-hover:opacity-100"></div>
      </div>

      <!-- Katla Special Offer -->
      <div
        id="katla-offer"
        class="group relative scroll-mt-24 overflow-hidden rounded-2xl border border-gray-800 bg-gradient-to-br from-[#1a1a1a] to-[#0d0d0d] transition-all duration-300 hover:border-gray-600">
        <div class="grid gap-8 md:grid-cols-2 md:items-center">
          <div class="relative z-10 p-8 md:p-12">
            <div class="mb-6">
              <span class="inline-block rounded-full bg-purple-600/20 px-4 py-1 text-sm font-medium text-purple-400">Limited Time</span>
            </div>
            <h2 class="mb-4 text-3xl font-bold md:text-4xl">Katla Special Offer</h2>

            <!-- Mobile image - shows after title -->
            <div class="mb-6 flex items-center justify-center md:hidden">
              <img src={katla_img} alt="Katla Synthesizer" class="h-auto w-full max-w-md rounded-lg" />
            </div>

            <p class="text-muted-foreground mb-6 text-lg">Wave and WIDI Master with every Katla purchase</p>
            <div class="mb-8">
              <p class="text-xl text-white">Valid until end of November</p>
            </div>
            <a href="/katla" class="inline-flex items-center justify-center rounded-lg bg-white px-8 py-4 text-lg font-medium text-black transition-all duration-200 hover:bg-gray-200">
              Learn more about Katla
            </a>
          </div>
          <!-- Desktop image -->
          <div class="relative hidden items-center justify-center p-8 md:flex md:p-12">
            <img src={katla_img} alt="Katla Synthesizer" class="h-auto w-full max-w-md rounded-lg" />
          </div>
        </div>
        <div class="absolute top-0 right-0 h-full w-1/3 bg-gradient-to-l from-purple-600/10 to-transparent opacity-0 transition-opacity duration-300 group-hover:opacity-100"></div>
      </div>
    </div>
  </div>
</div>

<Footer />
