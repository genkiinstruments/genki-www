<script lang="ts">
  import { fade } from "svelte/transition";

  import Header from "$lib/Header.svelte";
  import Footer from "$lib/Footer.svelte";
  import YouTubeCarousel from "$lib/YouTubeCarousel.svelte";
  import InteractiveString from "$lib/InteractiveString.svelte";

  import softwave_hero from "$lib/assets/softwave-hero.webp";
  import toti from "$lib/assets/toti-cool.webp";
  import quote from "$lib/assets/quote.webp";

  let isRenderImage = $state(false);
</script>

<Header />

<div class="bg-white">
  <div class="pt-6">
    <div class="mx-auto mt-8 max-w-2xl px-4 sm:px-6 lg:max-w-7xl lg:px-8"></div>
  </div>
</div>


<YouTubeCarousel ids={["TB789hiIJfA", "zgtGceSGlHg", "1P4O6aG_XWk", "6EdUOi37k10"]} />

<Footer />
