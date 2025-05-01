<script lang="ts">
  import { onMount, onDestroy } from "svelte";

  import Header from "$lib/Header.svelte";
  import Footer from "$lib/Footer.svelte";
  import YouTubeCarousel from "$lib/YouTubeCarousel.svelte";
  import InteractiveString from "$lib/InteractiveString.svelte";
  import ScrollIndicator from "$lib/ScrollIndicator.svelte";

  import cosmos from "$lib/assets/cosmos-main.webp";
  import viktor from "$lib/assets/viktor-cosmos.webp";
  import quote from "$lib/assets/quote.webp";

  let skewAmount = $state(0);
  let isTouched = $state(false);

  let animationFrame: number;
  let startTime: number;

  function animateSkew(timestamp: number) {
    if (!startTime) startTime = timestamp;
    const elapsed = timestamp - startTime;
    // Reduce animation intensity on mobile
    const amplitude = typeof window !== "undefined" && window.innerWidth < 768 ? 1.5 : 3;
    skewAmount = Math.sin(elapsed / 2500) * amplitude;

    animationFrame = requestAnimationFrame(animateSkew);
  }

  // Touch handler for mobile
  function handleTouch() {
    isTouched = !isTouched;
  }

  function handleTouchStartEvent(event: TouchEvent) {
    event.preventDefault();
    handleTouch();
  }

  onMount(() => {
    if (typeof window !== "undefined") {
      animationFrame = requestAnimationFrame(animateSkew);
    }
  });

  onDestroy(() => {
    if (typeof window !== "undefined") {
      if (animationFrame) cancelAnimationFrame(animationFrame);
    }
  });
</script>

<div class="@container mx-auto flex w-full flex-1 flex-col px-5 md:px-[50px]">
  <Header />

  <ScrollIndicator />

  <div class="flex min-h-[100vh] flex-col items-center justify-center py-10 md:py-20">
    <!-- Mobile layout stacks the elements vertically -->
    <div class="grid w-full grid-cols-1 items-center gap-6 md:grid-cols-10 md:gap-10">
      <!-- Product image - full width on mobile, positioned columns on desktop -->
      <div
        class="relative mx-auto w-full max-w-[300px] overflow-hidden md:col-span-6 md:col-start-1 md:max-w-none"
        role="button"
        onclick={handleTouch}
        onkeydown={(e) => e.key === "Enter" && handleTouch()}
        ontouchstart={handleTouchStartEvent}
        aria-roledescription="slide"
        tabindex="0">
        <img src={cosmos} alt="Cosmos" class="w-full transition-all duration-300" style="transform: skew({skewAmount}deg, 0deg);" class:animate-pulse={isTouched} />
      </div>

      <!-- Product info - full width on mobile, positioned columns on desktop -->
      <div class="mt-8 w-full text-lg md:col-span-3 md:col-start-7 md:mt-0 md:text-2xl lg:text-4xl">
        <div>
          <div class="flex items-center justify-between">
            <div class="font-bold uppercase">Cosmos</div>
            <div class="text-xl md:hidden">$99</div>
          </div>
          <br />
          <div>
            Cosmos is a softsynth with hand-crafted effects and a playful interface. Shape sound with 8-voice polyphony, flexible modulation, and the spiralling galaxy arp. Dive into unexpected sonic
            turns. Try it for free!
          </div>
          <br />
          <div class="flex w-full flex-row items-center justify-center md:flex md:items-center md:justify-start md:space-x-10">
            <div class="hidden md:flex md:items-center">$99</div>
            <a href="/" class="flex items-center">
              <div class="relative flex cursor-pointer flex-col items-center">
                <span class="text-xs tracking-widest text-white uppercase">Add to cart</span>
                <InteractiveString />
              </div>
            </a>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>

<div class="w-full overflow-hidden">
  <img src={viktor} alt="Audio director at Myrkur Games" class="w-full object-cover" />
</div>
<div class="@container -mt-4 grid grid-cols-10">
  <div class="col-span-3 col-start-1 md:col-span-1 md:col-start-3">
    <img src={quote} alt="Quotation mark" />
  </div>
</div>
<div class="grid grid-cols-10 gap-4 px-5 pt-7 md:gap-0 md:px-0">
  <div class="col-span-8 col-start-3 text-xl md:col-span-3 md:col-start-3 md:text-4xl">Cosmos is such a unique way to represent audio.</div>
  <div class="col-span-8 col-start-3 mt-4 space-y-2 md:col-span-2 md:col-start-8 md:mt-0 md:flex md:flex-col">
    <div class="text-xl md:text-4xl">Viktor Ingi Guðmundsson</div>
    <div class="text-lg leading-tight opacity-50 md:text-base">Audio director at Myrkur Games</div>
  </div>
</div>

<YouTubeCarousel class="w-full overflow-hidden py-40 md:py-68" ids={["hctbLL4QM9A", "oIC_tuHz7Lc", "mbNBF-5gRm8", "mL7KyOQ1rtk", "KgfDu7Jqe8s", "eLHipJuft6w", "QCxFXucFRTI"]} />

<Footer />
