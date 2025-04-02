<script lang="ts">
  import logo from "$lib/assets/logo.svg";
  import katla from "$lib/assets/Katla_Placeholder.png";
  import katla_logo from "$lib/assets/katla-logo.png";
  import learn_more from "$lib/assets/learn-more.png";
  import { onMount } from "svelte";

  // For hover-based dropdown
  let hardwareHovered = false;
  let softwareHovered = false;

  // Define hardware and software dropdown content
  const hardware = [
    {
      href: "/wave",
      title: "Wave",
      content: "The ring for music",
    },
    {
      href: "/wavefront",
      title: "Wavefront",
      content: "Move your Eurorack",
    },
    {
      href: "/katla",
      title: "Katla",
      content: "Happy-accident machine",
    },
  ];

  const software = [
    {
      title: "Softwave",
      href: "/softwave",
      content: "Customize your Wave",
    },
    {
      title: "Wave for Work",
      href: "/wave-for-work",
      content: "Wave as a peripheral",
    },
    {
      title: "Cosmos",
      href: "/cosmos",
      content: "Cosmos is the",
    },
  ];

  // Grid toggle
  let showGrid = false;

  onMount(() => {
    const handleKeyDown = (event) => {
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
      font-family: "Circular Std Book";
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

    .font-book {
      font-family: "Circular Std Book", sans-serif;
      font-weight: normal;
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
      <div class="col-span-4 flex items-center justify-end">
        <!-- Hardware Dropdown with hover -->
        <div class="relative" on:mouseenter={() => (hardwareHovered = true)} on:mouseleave={() => (hardwareHovered = false)}>
          <button class="flex items-center hover:text-gray-300">
            Hardware
            <svg class="ml-1 h-3 w-3" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
              <path d="M6 9L12 15L18 9" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" />
            </svg>
          </button>

          <!-- Dropdown content -->
          {#if hardwareHovered}
            <div class="absolute top-8 right-0 z-50 w-[300px] rounded bg-[#252525] p-3 shadow-md">
              <ul class="grid gap-2">
                {#each hardware as item}
                  <li>
                    <a href={item.href} class="block rounded p-2 hover:bg-[#353535]">
                      <div class="font-medium">{item.title}</div>
                      <p class="text-sm text-gray-400">{item.content}</p>
                    </a>
                  </li>
                {/each}
              </ul>
            </div>
          {/if}
        </div>

        <span class="inline-block w-10"></span>
        <!-- 40px gap -->

        <!-- Software Dropdown with hover -->
        <div class="relative" on:mouseenter={() => (softwareHovered = true)} on:mouseleave={() => (softwareHovered = false)}>
          <button class="flex items-center hover:text-gray-300">
            Software
            <svg class="ml-1 h-3 w-3" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
              <path d="M6 9L12 15L18 9" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" />
            </svg>
          </button>

          <!-- Dropdown content -->
          {#if softwareHovered}
            <div class="absolute top-8 right-0 z-50 w-[300px] rounded bg-[#252525] p-3 shadow-md">
              <ul class="grid gap-2">
                {#each software as item}
                  <li>
                    <a href={item.href} class="block rounded p-2 hover:bg-[#353535]">
                      <div class="font-medium">{item.title}</div>
                      <p class="text-sm text-gray-400">{item.content}</p>
                    </a>
                  </li>
                {/each}
              </ul>
            </div>
          {/if}
        </div>

        <span class="inline-block w-10"></span>
        <!-- 40px gap -->

        <!-- Documentation Link -->
        <a href="/documentation" class="hover:text-gray-300">Documentation</a>

        <span class="inline-block w-[30px]"></span>
        <!-- 30px gap -->

        <!-- Cart Icon -->
        <a href="#" class="flex items-center justify-center hover:text-gray-300">
          <svg class="h-[1em] w-[1em] translate-y-[0.1em]">
            <use xlink:href="#cart-icon"></use>
          </svg>
        </a>
      </div>
    </header>

    <!-- Hero Section -->
    <div class="relative mt-8 grid min-h-[80vh] grid-cols-10 items-center gap-[10px] pb-20">
      <!-- Hero Text (Left Side - spans 4 columns with more spacing) -->
      <div class="col-span-3 col-start-2 flex flex-col justify-center">
        <div class="space-y-10">
          <h1 class="text-7xl font-bold">
            <img src={katla_logo} alt="Learn more" />
          </h1>
          <p class="font-book text-4xl">Five-voice polyphonic synth, made from the ashes of Katla.</p>

          <div class="pt-8">
            <img src={learn_more} class="w-24" alt="Learn more" />
          </div>
        </div>
      </div>

      <!-- Hero Image (starting at column 6 from left and extending to right edge) -->
      <div class="relative col-span-5 col-start-6 h-full">
        <div class="absolute inset-y-0 right-[-100px] left-0 flex items-center">
          <div class="relative h-full w-full rounded-l-lg">
            <div class="absolute inset-0 flex items-center justify-center">
              <img src={katla} alt="Katla" class="h-full w-full object-cover" />
            </div>
          </div>
        </div>
      </div>
    </div>

    {#if showGrid}
      <div class="pointer-events-none fixed inset-0 z-[9998]">
        <div class="mx-auto h-full" style="max-width: calc(100% - 100px);">
          <div class="flex h-full justify-between">
            {#each Array(10) as _, i (i)}
              <div class="mx-[5px] h-full flex-1 bg-[rgba(85,85,85,0.5)] first:ml-0 last:mr-0"></div>
            {/each}
          </div>
        </div>
      </div>
    {/if}
  </div>
</div>
