<script>
  import logo from "$lib/assets/logo.svg";

  import { onMount } from "svelte";

  let showGrid = false;

  onMount(() => {
    const handleKeyDown = (/** @type {{ key: string; }} */ event) => {
      if (event.key === "'") {
        showGrid = !showGrid;
      }
    };

    window.addEventListener("keydown", handleKeyDown);

    return () => {
      window.removeEventListener("keydown", handleKeyDown);
    };
  });
</script>

<svelte:head>
  <!-- Circular Std Font -->
  <link href="https://db.onlinewebfonts.com/c/860c3ec7bbc5da3e97233ccecafe512e?family=Circular+Std+Book" rel="stylesheet" type="text/css" />
  <style>
    @font-face {
      font-family: "Circular Std";
      src: url("https://db.onlinewebfonts.com/t/860c3ec7bbc5da3e97233ccecafe512e.eot");
      src:
        url("https://db.onlinewebfonts.com/t/860c3ec7bbc5da3e97233ccecafe512e.eot?#iefix") format("embedded-opentype"),
        url("https://db.onlinewebfonts.com/t/860c3ec7bbc5da3e97233ccecafe512e.woff2") format("woff2"),
        url("https://db.onlinewebfonts.com/t/860c3ec7bbc5da3e97233ccecafe512e.woff") format("woff"),
        url("https://db.onlinewebfonts.com/t/860c3ec7bbc5da3e97233ccecafe512e.ttf") format("truetype"),
        url("https://db.onlinewebfonts.com/t/860c3ec7bbc5da3e97233ccecafe512e.svg#Circular Std Book") format("svg");
      font-weight: normal;
      font-style: normal;
    }

    @font-face {
      font-family: "Circular Std";
      src: url("https://db.onlinewebfonts.com/t/961a181da27e7cbc072ec2fb5bbfe2a9.eot");
      src:
        url("https://db.onlinewebfonts.com/t/961a181da27e7cbc072ec2fb5bbfe2a9.eot?#iefix") format("embedded-opentype"),
        url("https://db.onlinewebfonts.com/t/961a181da27e7cbc072ec2fb5bbfe2a9.woff2") format("woff2"),
        url("https://db.onlinewebfonts.com/t/961a181da27e7cbc072ec2fb5bbfe2a9.woff") format("woff"),
        url("https://db.onlinewebfonts.com/t/961a181da27e7cbc072ec2fb5bbfe2a9.ttf") format("truetype"),
        url("https://db.onlinewebfonts.com/t/961a181da27e7cbc072ec2fb5bbfe2a9.svg#Circular Std Medium") format("svg");
      font-weight: 500;
      font-style: normal;
    }

    @font-face {
      font-family: "Circular Std";
      src: url("https://db.onlinewebfonts.com/t/56855be2ba5bb40d6c2be889b8a96ca3.eot");
      src:
        url("https://db.onlinewebfonts.com/t/56855be2ba5bb40d6c2be889b8a96ca3.eot?#iefix") format("embedded-opentype"),
        url("https://db.onlinewebfonts.com/t/56855be2ba5bb40d6c2be889b8a96ca3.woff2") format("woff2"),
        url("https://db.onlinewebfonts.com/t/56855be2ba5bb40d6c2be889b8a96ca3.woff") format("woff"),
        url("https://db.onlinewebfonts.com/t/56855be2ba5bb40d6c2be889b8a96ca3.ttf") format("truetype"),
        url("https://db.onlinewebfonts.com/t/56855be2ba5bb40d6c2be889b8a96ca3.svg#Circular Std Bold") format("svg");
      font-weight: bold;
      font-style: normal;
    }
  </style>
</svelte:head>

<!-- Cart Icon SVG -->
<svg xmlns="http://www.w3.org/2000/svg" style="display:none">
  <symbol id="cart-icon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
    <circle cx="9" cy="21" r="1"></circle>
    <circle cx="20" cy="21" r="1"></circle>
    <path d="M1 1h4l2.68 13.39a2 2 0 0 0 2 1.61h9.72a2 2 0 0 0 2-1.61L23 6H6"></path>
  </symbol>
</svg>

<div class="min-h-screen bg-[#151515] font-['Circular_Std'] text-[#F6F6F6]">
  <!-- Grid-aligned container with 50px margins -->
  <div class="mx-auto" style="max-width: calc(100% - 100px);">
    <!-- Header -->
    <header class="grid grid-cols-10 gap-[10px] py-8">
      <!-- Logo (left-most) -->
      <div class="col-span-2">
        <a href="/"><img class="hidden h-6 sm:inline" src={logo} alt="" /></a>
      </div>

      <!-- Empty space -->
      <div class="col-span-4"></div>

      <!-- Navigation and Cart (right-most) -->
      <!-- svelte-ignore a11y_invalid_attribute -->
      <div class="col-span-4 flex items-center justify-end">
        <a href="#" class="hover:text-gray-300">Hardware</a>
        <span class="inline-block w-10"></span>
        <!-- 40px gap -->
        <a href="#" class="hover:text-gray-300">Software</a>
        <span class="inline-block w-10"></span>
        <!-- 40px gap -->
        <a href="#" class="hover:text-gray-300">Documentation</a>
        <span class="inline-block w-[30px]"></span>
        <!-- 30px gap -->
        <a href="#" class="flex items-center justify-center hover:text-gray-300">
          <svg class="h-[1em] w-[1em] translate-y-[0.1em]">
            <use xlink:href="#cart-icon"></use>
          </svg>
        </a>
      </div>
    </header>

    <h1 class="mb-4 text-3xl font-bold">Figma Grid Demo</h1>
    <p class="mb-8">Press the ' key to toggle the grid overlay</p>

    <!-- Grid column layout -->
    <div class="relative grid min-h-[500px] grid-cols-10 gap-[10px]">
      <div class="col-span-4">
        <h2 class="mb-4 text-2xl font-bold">Your Content</h2>
        <p>This content spans 4 columns. The grid overlay shows exactly where these columns are positioned.</p>
      </div>

      <div class="col-span-6">
        <div class="rounded bg-blue-900/20 p-6">
          <h3 class="mb-2 text-xl">Content Area</h3>
          <p>This section spans 6 columns. All content is aligned to the same grid that the overlay visualizes.</p>
          <p class="mt-4">The grid has 10 columns with 10px gutters and 50px margins on each side.</p>
        </div>
      </div>

      <div class="col-span-10 mt-8">
        <div class="rounded bg-purple-900/20 p-6">
          <h3 class="mb-2 text-xl">Full Width</h3>
          <p>This section spans all 10 columns while still respecting the grid.</p>
        </div>
      </div>
    </div>

    {#if showGrid}
      <div class="pointer-events-none fixed inset-0 z-[9999]">
        <div class="mx-auto h-full" style="max-width: calc(100% - 100px);">
          <div class="flex h-full justify-between">
            {#each Array(10) as _, i}
              <div class="mx-[5px] h-full flex-1 bg-[rgba(85,85,85,0.5)] first:ml-0 last:mr-0"></div>
            {/each}
          </div>
        </div>
      </div>
    {/if}
  </div>
</div>
