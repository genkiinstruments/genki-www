<script lang="ts">
  // Hero.svelte - Reusable hero component for product pages
  import { fade } from "svelte/transition";
  import InteractiveString from "./InteractiveString.svelte";
  import ScrollIndicator from "./ScrollIndicator.svelte";

  // --- Component Props ---
  type Props = {
    title: string;
    description: string;
    price: string; // Consider using number if calculations are needed
    mainImage?: string;
    altText: string;
    altImage?: string; // Optional alternate image for hover/touch effects
    logoSrc?: string;
    cartUrl?: string;
    flippedLayout?: boolean; // Controls if image is on left/right
  };

  const { title, description, price, mainImage = undefined, altText, altImage = "", logoSrc = "", cartUrl = "/", flippedLayout = false }: Props = $props();

  // --- State ---
  let isAltImageVisible = $state(false);

  // --- Event Handlers ---
  function toggleAltImage() {
    if (altImage) {
      isAltImageVisible = !isAltImageVisible;
    }
  }

  function handleTouchStart() {
    if (altImage) {
      toggleAltImage();
    }
  }

  // Determine if the image element should be interactive
  const isInteractive = !!altImage;

  // No longer need column start classes for flexbox
  // const imageColStartClass = flippedLayout ? "md:col-start-6" : "md:col-start-2";
  // const textColStartClass = flippedLayout ? "md:col-start-2" : "md:col-start-7";
</script>

<ScrollIndicator />

<section class="flex h-full grow flex-col items-center justify-center py-10 md:py-20">
  <div class="flex w-full flex-col items-center gap-10 md:flex-row md:justify-center md:gap-12 lg:gap-16">
    <!-- Product Image Container -->
    <!-- svelte-ignore a11y_no_noninteractive_tabindex -->
    <div
      class:cursor-pointer={isInteractive}
      class="relative mx-auto w-full max-w-[300px] md:mx-0 md:max-w-none md:basis-[45%] {flippedLayout ? 'md:order-2' : 'md:order-1'}"
      role={isInteractive ? "button" : undefined}
      aria-pressed={isInteractive ? isAltImageVisible : undefined}
      aria-label={isInteractive ? "Toggle product image view" : altText}
      tabindex={isInteractive ? 0 : undefined}
      onmouseenter={() => isInteractive && (isAltImageVisible = true)}
      onmouseleave={() => isInteractive && (isAltImageVisible = false)}
      onclick={toggleAltImage}
      onkeydown={(e) => e.key === "Enter" && toggleAltImage()}
      ontouchstart={handleTouchStart}>
      <!-- Main Image -->
      {#if mainImage}
        <img src={mainImage} alt={altText} class="w-full transition-opacity duration-300" class:opacity-0={isInteractive && isAltImageVisible} />
      {/if}
      <!-- Alternate Image (Conditional Rendering + Transition) -->
      {#if isInteractive && isAltImageVisible}
        <div class="absolute inset-0 flex items-center justify-center" transition:fade={{ duration: 300 }}>
          <img src={altImage} alt={`Alternate view of ${altText}`} class="w-full" />
        </div>
      {/if}
    </div>

    <!-- Product Info Container -->
    <div class="w-full text-center text-lg md:mx-0 md:basis-[35%] md:text-left md:text-2xl lg:text-4xl {flippedLayout ? 'md:order-1' : 'md:order-2'}">
      <div class="flex items-center justify-center md:justify-between">
        {#if logoSrc}
          <img src={logoSrc} alt={altText} class="mx-auto max-h-16 md:mx-0" />
        {:else}
          <h1 class="font-bold uppercase">{title}</h1>
        {/if}
        <div class="font-mono text-xl md:hidden">{price}</div>
      </div>
      <p class="mt-4 md:text-2xl">
        {description}
      </p>
      <div class="mt-6 flex w-full flex-row items-center justify-center gap-6 md:justify-start md:space-x-10">
        <div class="hidden font-mono text-2xl md:block">{price}</div>
        <a href={cartUrl} class="flex">
          <div class="relative flex cursor-pointer flex-col items-center">
            <span class="-mb-1 text-xs/5 tracking-widest text-white uppercase">Add to cart</span>
            <InteractiveString />
          </div>
        </a>
      </div>
    </div>
  </div>
</section>
