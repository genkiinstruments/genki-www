<script lang="ts">
  import { NavigationMenu } from "bits-ui";
  import CaretDown from "phosphor-svelte/lib/CaretDown";

  // Define hardware and software dropdown content
  type ListItemProps = {
    title: string;
    href: string;
    content: string;
  };
  const hardware: ListItemProps[] = [
    {
      href: "/wave",
      title: "Wave",
      content: "The ring for musicians",
    },
    {
      href: "/wavefront",
      title: "Wavefront",
      content: "Your Wireless Eurorack",
    },
    {
      href: "/katla",
      title: "Katla",
      content: "Analog. Volcanic. Polysynth.",
    },
  ];

  const software = [
    {
      title: "Softwave",
      href: "/softwave",
      content: "Customize Wave",
    },
    {
      title: "Wave for Work",
      href: "/wave-for-work",
      content: "Swipe for next song",
    },
    {
      title: "Cosmos",
      href: "/cosmos",
      content: "Happy accident soft-synth",
    },
  ];
</script>

{#snippet ListItem({ title, content, href }: ListItemProps)}
  <li>
    <NavigationMenu.Link class={"block space-y-1 rounded-md p-3 leading-none no-underline outline-hidden transition-all duration-200 select-none hover:bg-[#252525] focus:bg-[#252525]"} {href}>
      <div class="text-sm leading-none font-medium transition-colors duration-200">{title}</div>
      <p class="text-muted-foreground line-clamp-2 text-sm leading-snug transition-colors duration-200 group-hover:text-gray-300">
        {content}
      </p>
    </NavigationMenu.Link>
  </li>
{/snippet}

<!-- Header - Fixed height -->
<header class="mt-2 grid h-[72px] flex-shrink-0 grid-cols-10 gap-[10px] bg-transparent">
  <!-- Logo (left-most) -->
  <div class="col-span-2 flex items-center">
    <a href="/" class="text-white opacity-60 transition-opacity duration-200 hover:opacity-100">
      <div class="h-6 w-auto">
        <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 58.9 97.5" class="h-full" fill="currentColor">
          <path
            d="M16.5 56A29 29 0 0 0 28 58.8h1.5c4.8 0 9.5-1.2 13.8-3.4l1.3-.8c2.9-1.7 5.4-3.9 7.5-6.5l1-1.1A29.5 29.5 0 0 0 29.5 0H28A29.4 29.4 0 0 0 5.3 46.2c2-2.2 4.2-4 6.7-5.7a20.9 20.9 0 0 1 16.7-32h.8a20.8 20.8 0 0 1 0 41.6h-.7l-.8.1a18 18 0 0 0-11.5 5.6" />
          <path
            d="M29.5 38.5c-4.8 0-9.6 1.2-13.9 3.5l-.6.3-.7.4a29.7 29.7 0 0 0-7.5 6.5l-.4.5-.6.7a29.5 29.5 0 1 0 47.8.8c-2 2.1-4.2 4-6.6 5.6a20.8 20.8 0 1 1-34.1-1.3l.4-.6a20.8 20.8 0 0 1 16-7.7h.1c5 0 9.7-2 13-5.6-4-2-8.4-3-13-3" />
        </svg>
      </div>
    </a>
  </div>

  <!-- Empty space (hidden on mobile) -->
  <div class="hidden md:col-span-4 md:block"></div>

  <!-- Navigation and Cart (right-most) -->
  <NavigationMenu.Root class="jusity relative z-10 col-span-8 flex  w-full items-center justify-end md:col-span-4">
    <NavigationMenu.List class="group flex list-none items-center justify-center ">
      <NavigationMenu.Item value="hardware">
        <NavigationMenu.Trigger
          class="group inline-flex h-8 w-max items-center justify-center rounded-[7px] bg-transparent px-6 py-2 text-sm font-medium opacity-60 transition-colors hover:opacity-100 focus:outline-hidden disabled:pointer-events-none disabled:opacity-50 data-[state=open]:opacity-100">
          Hardware
          <CaretDown class="relative top-[1px] ml-1 size-3 transition-transform duration-200 group-data-[state=open]:rotate-180" aria-hidden="true" />
        </NavigationMenu.Trigger>
        <NavigationMenu.Content
          class="data-[motion=from-end]:animate-enter-from-right data-[motion=from-start]:animate-enter-from-left data-[motion=to-end]:animate-exit-to-right data-[motion=to-start]:animate-exit-to-left absolute top-0 left-0 w-full sm:w-auto">
          <ul class="m-0 grid list-none gap-x-2.5 p-3 sm:w-[600px] sm:grid-flow-col sm:grid-rows-3 sm:p-[22px]">
            <li class="row-span-3 mb-2 sm:mb-0">
              <NavigationMenu.Link class="flex h-full w-full flex-col justify-end rounded-md bg-black p-6 no-underline outline-hidden transition-all duration-200 select-none focus:shadow-md">
                <!-- <Icons.logo class="h-6 w-6" /> -->
                <div class="mt-4 mb-2 text-lg font-medium transition-colors duration-200">Our hardware</div>
                <p class="text-muted-foreground text-sm leading-tight transition-colors duration-200">Handcrafted with Love in Iceland</p>
              </NavigationMenu.Link>
            </li>
            {#each hardware as component (component.title)}
              {@render ListItem(component)}
            {/each}
          </ul>
        </NavigationMenu.Content>
      </NavigationMenu.Item>
      <NavigationMenu.Item value="software">
        <NavigationMenu.Trigger
          class="group inline-flex h-8 w-max items-center justify-center rounded-[7px] bg-transparent px-6 py-2 text-sm font-medium opacity-60 transition-colors hover:opacity-100 focus:outline-hidden disabled:pointer-events-none disabled:opacity-50 data-[state=open]:opacity-100">
          Software
          <CaretDown class="relative top-[1px] ml-1 size-3 transition-transform duration-200 group-data-[state=open]:rotate-180" aria-hidden="true" />
        </NavigationMenu.Trigger>
        <NavigationMenu.Content
          class="data-[motion=from-end]:animate-enter-from-right data-[motion=from-start]:animate-enter-from-left data-[motion=to-end]:animate-exit-to-right data-[motion=to-start]:animate-exit-to-left absolute top-0 left-0 w-full sm:w-auto">
          <ul class="m-0 grid list-none gap-x-2.5 p-3 sm:w-[600px] sm:grid-flow-col sm:grid-rows-3 sm:p-[22px]">
            <li class="row-span-3 mb-2 sm:mb-0">
              <NavigationMenu.Link class="flex h-full w-full flex-col justify-end rounded-md bg-black p-6 no-underline outline-hidden transition-all duration-200 select-none focus:shadow-md">
                <!-- <Icons.logo class="h-6 w-6" /> -->
                <div class="mt-4 mb-2 text-lg font-medium transition-colors duration-200">Our software</div>
                <p class="text-muted-foreground text-sm leading-tight transition-colors duration-200">Tools making you a litle bit more creative</p>
              </NavigationMenu.Link>
            </li>
            {#each software as component (component.title)}
              {@render ListItem(component)}
            {/each}
          </ul>
        </NavigationMenu.Content>
      </NavigationMenu.Item>
      <NavigationMenu.Item>
        <NavigationMenu.Link
          class="group inline-flex h-8 w-max items-center justify-center rounded-[7px] bg-transparent px-6 py-2 text-sm font-medium opacity-60 transition-colors hover:opacity-100 focus:outline-hidden disabled:pointer-events-none disabled:opacity-50"
          href="/documentation">
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
        class="text-popover-foreground data-[state=closed]:animate-scale-out data-[state=open]:animate-scale-in relative mt-2.5 h-[var(--bits-navigation-menu-viewport-height)] w-full origin-[top_center] overflow-hidden rounded-md border border-gray-800 bg-[#161616] shadow-2xl transition-all duration-200 sm:w-[var(--bits-navigation-menu-viewport-width)]" />
    </div>

    <span class="inline-block w-[15px] md:w-[30px]"></span>

    <!-- Cart Icon -->
    <!-- [TODO]: Fix link (April 02, 2025 16:17, ) -->
    <a href="/documentation" aria-label="View shopping cart" class="flex items-center justify-center opacity-60 transition-opacity duration-200 hover:opacity-100">
      <svg class="h-[1.2em] w-[1.2em]">
        <use xlink:href="#cart-icon"></use>
      </svg>
    </a>
  </NavigationMenu.Root>
  <span class="inline-block w-4 md:w-10"></span>
</header>
