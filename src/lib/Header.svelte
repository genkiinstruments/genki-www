<script lang="ts">
  import { NavigationMenu } from "bits-ui";
  import CaretDown from "phosphor-svelte/lib/CaretDown";
  import List from "phosphor-svelte/lib/List";

  import waveHoverImg from "$lib/assets/wave-header-hover.webp";
  import wavefrontHoverImg from "$lib/assets/wavefront-header-hover.webp";
  import katlaHoverImg from "$lib/assets/katla-header-hover.webp";

  import softwaveHoverImg from "$lib/assets/softwave-hero.webp"; // Using wave image as placeholder for now
  import waveForWorkHoverImg from "$lib/assets/wavefront-header-hover.webp"; // Using wavefront image as placeholder for now
  import cosmosHoverImg from "$lib/assets/cosmos-space.webp"; // Using cosmos space image

  import software_header from "$lib/assets/software-header.webp"; // Using cosmos space image

  let activeHoverImage: string | null = $state(null);
  let mobileMenuOpen = $state(false);

  function toggleMobileMenu() {
    mobileMenuOpen = !mobileMenuOpen;
  }

  // Define hardware and software dropdown content
  type ListItemProps = {
    title: string;
    href: string;
    content: string;
    hoverImage?: string;
  };

  const hardware: ListItemProps[] = [
    {
      href: "/wave",
      title: "Wave",
      content: "The ring for musicians",
      hoverImage: waveHoverImg,
    },
    {
      href: "/wavefront",
      title: "Wavefront",
      content: "Eurorack. Wireless.",
      hoverImage: wavefrontHoverImg,
    },
    {
      href: "/katla",
      title: "Katla",
      content: "Volcanic. Caotic. Analog polysynth.",
      hoverImage: katlaHoverImg,
    },
  ];

  const software: ListItemProps[] = [
    {
      title: "Softwave",
      href: "/softwave",
      content: "Customize Wave",
      hoverImage: softwaveHoverImg,
    },
    {
      title: "Cosmos",
      href: "/cosmos",
      content: "The Cosmos smiles upon you",
      hoverImage: cosmosHoverImg,
    },
  ];
</script>

{#snippet ListItem({ title, content, href, hoverImage }: ListItemProps)}
  <li class="w-full">
    <a
      {href}
      class="block w-full space-y-1 rounded-md p-3 text-left leading-none no-underline outline-hidden transition-all duration-300 ease-in-out select-none hover:bg-[#252525] focus:bg-[#252525]"
      onmouseenter={() => {
        console.log("Hovering", title, hoverImage);
        if (hoverImage) activeHoverImage = hoverImage;
      }}
      onmouseleave={() => {
        console.log("Leaving", title);
        activeHoverImage = null;
      }}
      onclick={() => {
        window.location.href = href;
      }}>
      <div class="text-sm leading-none font-medium transition-colors duration-300 ease-in-out">{title}</div>
      <p class="text-muted-foreground line-clamp-2 text-sm leading-snug transition-colors duration-300 ease-in-out group-hover:text-gray-300">
        {content}
      </p>
    </a>
  </li>
{/snippet}

<!-- Header - Fixed height -->
<header class="mt-2 grid h-[72px] flex-shrink-0 grid-cols-10 gap-[10px] bg-transparent">
  <!-- Logo (left-most) in regular header layout -->
  <div class="col-span-1 flex items-center justify-start overflow-auto sm:col-span-2">
    <!-- Give the anchor appropriate height, remove fixed width, remove overflow-visible (likely not needed now) -->
    <a href="/" class="h-8 w-auto text-white opacity-80 transition-opacity duration-200 hover:opacity-100" aria-label="Go to index page">
      <!-- SVG remains h-full w-full to fill the anchor -->
      <svg xmlns="http://www.w3.org/2000/svg" class="h-full w-full" viewBox="0 0 60 100" fill="currentColor" aria-hidden="true">
        <path
          d="M16.5 56A29 29 0 0 0 28 58.8h1.5c4.8 0 9.5-1.2 13.8-3.4l1.3-.8c2.9-1.7 5.4-3.9 7.5-6.5l1-1.1A29.5 29.5 0 0 0 29.5 0H28A29.4 29.4 0 0 0 5.3 46.2c2-2.2 4.2-4 6.7-5.7a20.9 20.9 0 0 1 16.7-32h.8a20.8 20.8 0 0 1 0 41.6h-.7l-.8.1a18 18 0 0 0-11.5 5.6" />
        <path
          d="M29.5 38.5c-4.8 0-9.6 1.2-13.9 3.5l-.6.3-.7.4a29.7 29.7 0 0 0-7.5 6.5l-.4.5-.6.7a29.5 29.5 0 1 0 47.8.8c-2 2.1-4.2 4-6.6 5.6a20.8 20.8 0 1 1-34.1-1.3l.4-.6a20.8 20.8 0 0 1 16-7.7h.1c5 0 9.7-2 13-5.6-4-2-8.4-3-13-3" />
      </svg>
    </a>
  </div>

  <!-- Empty space (hidden on mobile) -->
  <div class="hidden md:col-span-4 md:block"></div>

  <!-- Mobile menu toggle button (only visible on small screens) -->
  <div class="col-start-10 flex items-center justify-end md:hidden">
    <button aria-label="Toggle menu" class="text-white opacity-80 transition-opacity hover:opacity-100" onclick={toggleMobileMenu}>
      <List size={24} />
    </button>
  </div>

  <!-- Navigation and Cart (right-most) -->
  <NavigationMenu.Root class="jusity relative z-10 col-span-8 hidden w-full items-center justify-end md:col-span-4 md:flex">
    <NavigationMenu.List class="group flex list-none items-center justify-center ">
      <NavigationMenu.Item value="hardware">
        <NavigationMenu.Trigger
          class="group inline-flex h-8 w-max items-center justify-center rounded-[7px] bg-transparent px-6 py-2 text-sm font-medium opacity-80 transition-all duration-300 ease-in-out hover:opacity-100 focus:outline-hidden disabled:pointer-events-none disabled:opacity-50 data-[state=open]:opacity-100">
          Hardware
          <CaretDown class="relative top-[1px] ml-1 size-3 transition-transform duration-300 ease-in-out group-data-[state=open]:rotate-180" aria-hidden="true" />
        </NavigationMenu.Trigger>
        <NavigationMenu.Content
          class="data-[motion=from-end]:animate-enter-from-right data-[motion=from-start]:animate-enter-from-left data-[motion=to-end]:animate-exit-to-right data-[motion=to-start]:animate-exit-to-left absolute top-0 left-0 w-full sm:w-auto">
          <div class="relative h-full w-full overflow-hidden">
            <ul class="relative z-10 m-0 grid list-none gap-x-2.5 p-3 sm:w-[600px] sm:grid-flow-col sm:grid-rows-3 sm:p-[22px]">
              <li class="row-span-3 mb-2 sm:mb-0">
                <NavigationMenu.Link
                  class="relative flex h-full w-full flex-col justify-end rounded-md bg-black/80 p-6 no-underline outline-hidden backdrop-blur-sm transition-all duration-300 ease-in-out select-none focus:shadow-md">
                  <!-- Background image container with smooth transition -->
                  <div class="absolute inset-0 z-0 transition-opacity duration-300 ease-in-out" style="opacity: {activeHoverImage ? '1' : '0'}">
                    {#if activeHoverImage}
                      <img src={activeHoverImage} alt="" class="h-full w-full object-cover opacity-70" />
                    {/if}
                  </div>
                  <!-- Logo positioned with the same padding as the text -->
                  <div class="transition-opacity duration-300 ease-in-out {activeHoverImage ? 'opacity-0' : 'opacity-100'}">
                    <div class="absolute top-6 left-6 z-10 h-8 w-auto text-white">
                      <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 58.9 97.5" class="h-full" fill="currentColor">
                        <path
                          d="M16.5 56A29 29 0 0 0 28 58.8h1.5c4.8 0 9.5-1.2 13.8-3.4l1.3-.8c2.9-1.7 5.4-3.9 7.5-6.5l1-1.1A29.5 29.5 0 0 0 29.5 0H28A29.4 29.4 0 0 0 5.3 46.2c2-2.2 4.2-4 6.7-5.7a20.9 20.9 0 0 1 16.7-32h.8a20.8 20.8 0 0 1 0 41.6h-.7l-.8.1a18 18 0 0 0-11.5 5.6" />
                        <path
                          d="M29.5 38.5c-4.8 0-9.6 1.2-13.9 3.5l-.6.3-.7.4a29.7 29.7 0 0 0-7.5 6.5l-.4.5-.6.7a29.5 29.5 0 1 0 47.8.8c-2 2.1-4.2 4-6.6 5.6a20.8 20.8 0 1 1-34.1-1.3l.4-.6a20.8 20.8 0 0 1 16-7.7h.1c5 0 9.7-2 13-5.6-4-2-8.4-3-13-3" />
                      </svg>
                    </div>
                    <div class="z-10 mt-4 mb-2 text-lg font-medium transition-colors duration-300 ease-in-out">Hardware</div>
                    <p class="text-muted-foreground z-10 text-sm leading-tight transition-colors duration-300 ease-in-out">Handcrafted in Iceland</p>
                  </div>
                </NavigationMenu.Link>
              </li>
              {#each hardware as item}
                {@render ListItem(item)}
              {/each}
            </ul>
          </div>
        </NavigationMenu.Content>
      </NavigationMenu.Item>
      <NavigationMenu.Item value="software">
        <NavigationMenu.Trigger
          class="group inline-flex h-8 w-max items-center justify-center rounded-[7px] bg-transparent px-6 py-2 text-sm font-medium opacity-80 transition-all duration-300 ease-in-out hover:opacity-100 focus:outline-hidden disabled:pointer-events-none disabled:opacity-50 data-[state=open]:opacity-100">
          Software
          <CaretDown class="relative top-[1px] ml-1 size-3 transition-transform duration-300 ease-in-out group-data-[state=open]:rotate-180" aria-hidden="true" />
        </NavigationMenu.Trigger>
        <NavigationMenu.Content
          class="data-[motion=from-end]:animate-enter-from-right data-[motion=from-start]:animate-enter-from-left data-[motion=to-end]:animate-exit-to-right data-[motion=to-start]:animate-exit-to-left absolute top-0 left-0 w-full sm:w-auto">
          <div class="relative h-full w-full overflow-hidden">
            <ul class="relative z-10 m-0 grid list-none gap-x-2.5 p-3 sm:w-[600px] sm:grid-flow-col sm:grid-rows-3 sm:p-[22px]">
              <li class="row-span-3 mb-2 sm:mb-0">
                <NavigationMenu.Link
                  class="relative flex h-full w-full flex-col justify-end rounded-md bg-black/80 p-6 no-underline outline-hidden backdrop-blur-sm transition-all duration-300 ease-in-out select-none focus:shadow-md">
                  <!-- Background image container with smooth transition -->
                  <div class="absolute inset-0 z-0 transition-opacity duration-300 ease-in-out" style="opacity: {activeHoverImage ? '1' : '0'}">
                    {#if activeHoverImage}
                      <img src={activeHoverImage} alt="" class="h-full w-full object-cover opacity-70" />
                    {/if}
                  </div>
                  <!-- Logo and text that fades out when hovering -->
                  <div class="transition-opacity duration-300 ease-in-out {activeHoverImage ? 'opacity-0' : 'opacity-100'}">
                    <div class="absolute top-6 left-6 z-10 h-10 w-auto text-white">
                      <img src={software_header} alt="" />
                    </div>
                    <div class="z-10 mt-4 mb-2 text-lg font-medium transition-colors duration-300 ease-in-out">Software</div>
                    <p class="text-muted-foreground z-10 text-sm leading-tight transition-colors duration-300 ease-in-out">Making you better, bit-by-bit</p>
                  </div>
                </NavigationMenu.Link>
              </li>
              {#each software as item}
                {@render ListItem(item)}
              {/each}
            </ul>
          </div></NavigationMenu.Content>
      </NavigationMenu.Item>
      <NavigationMenu.Item>
        <!-- [TODO]: Fix link (April 02, 2025 16:17, ) -->
        <NavigationMenu.Link
          class="group inline-flex h-8 w-max items-center justify-center rounded-[7px] bg-transparent px-6 py-2 text-sm font-medium opacity-80 transition-all duration-300 ease-in-out hover:opacity-100 focus:outline-hidden disabled:pointer-events-none disabled:opacity-50"
          href="https://genkiinstruments.github.io/"
          target="_blank">
          <span class="hidden sm:inline"> Documentation </span>
          <span class="inline sm:hidden"> Docs </span>
        </NavigationMenu.Link>
      </NavigationMenu.Item>
      <NavigationMenu.Indicator
        class="data-[state=hidden]:animate-fade-out data-[state=visible]:animate-fade-in top-full z-10 flex h-2.5 items-end justify-center overflow-hidden opacity-100 transition-[all,transform_250ms_ease] duration-200 data-[state=hidden]:opacity-0">
        <div class="relative top-[70%] size-2.5 rotate-[45deg] rounded-tl-[2px] border-t border-l border-gray-800 bg-[#161616]"></div>
      </NavigationMenu.Indicator>
    </NavigationMenu.List>
    <div class="absolute top-full left-0 flex w-full justify-center perspective-[2000px]">
      <NavigationMenu.Viewport
        class="text-popover-foreground data-[state=closed]:animate-scale-out data-[state=open]:animate-scale-in relative mt-2.5 h-[var(--bits-navigation-menu-viewport-height)] w-full origin-[top_center] overflow-hidden rounded-md bg-[#161616] shadow-2xl transition-all duration-200 sm:w-[var(--bits-navigation-menu-viewport-width)]" />
    </div>

    <span class="inline-block w-[15px] md:w-[30px]"></span>

    <!-- Cart Icon -->
    <!-- [TODO]: Fix link (April 02, 2025 16:17, ) -->
    <a href="/documentation" aria-label="View shopping cart" class="flex items-center justify-center opacity-80 transition-opacity duration-300 ease-in-out hover:opacity-100">
      <svg class="h-[1.2em] w-[1.2em]">
        <use xlink:href="#cart-icon"></use>
      </svg>
    </a>
    <!-- Cart Icon SVG -->
    <svg xmlns="http://www.w3.org/2000/svg" style="display:none">
      <symbol id="cart-icon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
        <circle cx="9" cy="21" r="1"></circle>
        <circle cx="20" cy="21" r="1"></circle>
        <path d="M1 1h4l2.68 13.39a2 2 0 0 0 2 1.61h9.72a2 2 0 0 0 2-1.61L23 6H6"></path>
      </symbol>
    </svg>
  </NavigationMenu.Root>
  <span class="hidden w-10 md:inline-block"></span>
</header>

<!-- Mobile Navigation Menu (only visible when toggled) -->
{#if mobileMenuOpen}
  <div class="fixed inset-0 z-50 flex flex-col overflow-auto bg-black/95 backdrop-blur-sm">
    <div class="flex justify-end p-5">
      <button aria-label="Close menu" class="p-2 text-white" onclick={toggleMobileMenu}>
        <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
          <line x1="18" y1="6" x2="6" y2="18"></line>
          <line x1="6" y1="6" x2="18" y2="18"></line>
        </svg>
      </button>
    </div>

    <nav class="flex-1 p-6">
      <div class="mb-8">
        <h2 class="mb-4 text-xl font-bold">Hardware</h2>
        <ul class="space-y-4">
          {#each hardware as item}
            <li>
              <a href={item.href} class="block py-2" onclick={toggleMobileMenu}>
                <div class="font-medium">{item.title}</div>
                <div class="text-sm text-gray-400">{item.content}</div>
              </a>
            </li>
          {/each}
        </ul>
      </div>

      <div class="mb-8">
        <h2 class="mb-4 text-xl font-bold">Software</h2>
        <ul class="space-y-4">
          {#each software as item}
            <li>
              <a href={item.href} class="block py-2" onclick={toggleMobileMenu}>
                <div class="font-medium">{item.title}</div>
                <div class="text-sm text-gray-400">{item.content}</div>
              </a>
            </li>
          {/each}
        </ul>
      </div>

      <div>
        <a href="https://genkiinstruments.github.io/" target="_blank" class="block py-2 font-medium" onclick={toggleMobileMenu}> Documentation </a>
      </div>
    </nav>
  </div>
{/if}
