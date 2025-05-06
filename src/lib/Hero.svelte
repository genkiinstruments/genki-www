<script lang="ts">
  import InteractiveString from "./InteractiveString.svelte";
  import ScrollIndicator from "./ScrollIndicator.svelte";

  type Props = {
    title: string;
    description: string;
    price: string;
    mainImage?: string;
    altText: string;
    altImage?: string;
    logoSrc?: string;
    cartUrl?: string;
    flipped?: boolean;
  };

  const { title, description, price, mainImage = undefined, altText, altImage = "", logoSrc = "", cartUrl = "/", flipped = false }: Props = $props();
</script>

<ScrollIndicator />

<div class="flex grow flex-col items-center py-16 sm:py-0 md:grid md:grid-cols-10 md:items-stretch">
  {#if !flipped}
    <div class="group mb-6 flex w-full items-center justify-center md:col-span-4 md:col-start-2">
      {#if mainImage}
        <img src={mainImage} class="flex h-auto w-full group-hover:hidden" alt="Main" />
      {/if}
      {#if altImage}
        <img src={altImage} class="hidden h-auto w-full group-hover:flex" alt="Alternative" />
      {/if}
    </div>
    <div class="flex items-center justify-center space-y-8 md:col-span-3 md:col-start-7 md:text-left">
      <div class="flex flex-col space-y-4">
        <div class="flex items-center justify-between">
          {#if logoSrc}
            <img src={logoSrc} alt={altText} class="mx-auto max-h-16 md:mx-0" />
          {:else}
            <h1 class="text-2xl font-bold uppercase md:text-4xl">{title}</h1>
          {/if}
          <div class="font-mono text-xl md:hidden">{price}</div>
        </div>
        <p class="mt-4 justify-start md:text-2xl">
          {description}
        </p>
        <div class="mt-6 flex w-full flex-row items-center justify-center gap-6 md:justify-start md:space-x-10">
          <div class="hidden font-mono text-2xl md:block">{price}</div>
          <a href={cartUrl} class="mt-3 flex">
            <div class="relative flex cursor-pointer flex-col items-center">
              <span class="-mb-4 py-4 text-sm tracking-widest text-white uppercase sm:-mb-1 sm:py-0">Add to cart</span>
              <InteractiveString />
            </div>
          </a>
        </div>
      </div>
    </div>
  {:else}
    <div class="flex items-center justify-center md:col-span-3 md:col-start-2 md:text-left">
      <div class="flex flex-col space-y-4">
        <div class="flex items-center justify-between">
          {#if logoSrc}
            <img src={logoSrc} alt={altText} class="h-7 w-auto object-contain md:mx-0" />
          {:else}
            <h1 class="text-2xl font-bold uppercase md:text-4xl">{title}</h1>
          {/if}
          <div class="font-mono text-xl md:hidden">
            {price}
          </div>
        </div>
        <p class="mt-4 justify-start md:text-2xl">
          {description}
        </p>
        <div class="mt-6 flex w-full flex-row items-center justify-center gap-6 md:justify-start md:space-x-10">
          <div class="hidden items-center justify-center font-mono text-2xl md:flex">{price}</div>
          <a href={cartUrl} class="flex items-center justify-center">
            <div class="relative flex cursor-pointer flex-col items-center">
              <span class="-mb-4 py-4 text-sm tracking-widest text-white uppercase sm:-mb-1 sm:py-0">Add to cart</span>
              <InteractiveString />
            </div>
          </a>
        </div>
      </div>
    </div>
    <div class="group mb-6 flex w-full items-center justify-center md:col-span-4 md:col-start-6 lg:col-span-5">
      {#if mainImage}
        <img src={mainImage} class="flex h-auto w-full items-center justify-center {altImage ?? 'group-hover:hidden'}" alt="Main" />
      {/if}
      {#if altImage}
        <img src={altImage} class="hidden h-auto w-full group-hover:flex" alt="Alternative" />
      {/if}
    </div>
  {/if}
</div>
