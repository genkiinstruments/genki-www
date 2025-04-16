<script lang="ts">
  import { onMount, onDestroy } from "svelte";

  import Header from "$lib/Header.svelte";
  import Footer from "$lib/Footer.svelte";
  import YouTubeCarousel from "$lib/YouTubeCarousel.svelte";
  import InteractiveString from "$lib/InteractiveString.svelte";

  import cosmos from "$lib/assets/cosmos-main.webp";
  import viktor from "$lib/assets/viktor-cosmos.webp";
  import quote from "$lib/assets/quote.webp";

  let skewAmount = $state(0);

  let animationFrame: number;
  let startTime: number;

  function animateSkew(timestamp: number) {
    if (!startTime) startTime = timestamp;
    const elapsed = timestamp - startTime;
    skewAmount = Math.sin(elapsed / 2500) * 5;

    animationFrame = requestAnimationFrame(animateSkew);
  }

  onMount(() => {
    animationFrame = requestAnimationFrame(animateSkew);
  });

  onDestroy(() => {
    if (animationFrame) cancelAnimationFrame(animationFrame);
  });
</script>

<div class="@container mx-auto flex h-[100vh] w-full flex-1 flex-col px-5 md:px-[50px]">
  <Header />
  <div class="flex min-h-[100vh] flex-col items-center justify-center py-20">
    <div class="grid w-full grid-cols-10 items-center gap-10">
      <div class="relative col-span-6 col-start-1 overflow-hidden" role="button" aria-roledescription="slide" tabindex="0">
        <img src={cosmos} alt="Cosmos" class="w-full transition-all duration-300" style="transform: skew({skewAmount}deg, 0deg);" />
      </div>
      <div class="col-span-3 col-start-7 md:text-2xl lg:text-4xl">
        <div>
          <div class="font-bold uppercase">Cosmos</div>
          <br />
          <div>
            Cosmos is a softsynth with hand-crafted effects and a playful interface. Shape sound with 8-voice polyphony, flexible modulation, and the spiralling galaxy arp. Dive into unexpected sonic
            turns. Try it for free!
          </div>
          <br />
          <div class="flex w-full flex-row space-x-10">
            <div>$99</div>
            <a href="/" class="inline-block">
              <div class="relative flex cursor-pointer flex-col items-center">
                <span class="relative -mb-2 text-sm tracking-widest text-white uppercase">Add to cart</span>
                <InteractiveString />
              </div>
            </a>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>

<img src={viktor} alt="Audio director at Myrkur Games" class="w-full object-cover" />
<div class="@container -mt-4 grid grid-cols-10">
  <div class="col-span-1 col-start-3">
    <img src={quote} alt="Quotation mark" />
  </div>
</div>
<div class="grid grid-cols-10 pt-7">
  <div class="col-span-3 col-start-3 text-4xl">Cosmos is such a unique way to represent audio.</div>
  <div class="col-span-2 col-start-8 flex flex-col space-y-2">
    <div class=" text-4xl">Viktor Ingi Guðmundsson</div>
    <div class=" text-sm">Audio director at Myrkur Games</div>
  </div>
</div>

<YouTubeCarousel ids={["hctbLL4QM9A", "oIC_tuHz7Lc", "mbNBF-5gRm8", "mL7KyOQ1rtk", "KgfDu7Jqe8s", "eLHipJuft6w", "QCxFXucFRTI"]} />

<Footer />
