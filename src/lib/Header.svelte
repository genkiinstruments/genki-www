<script lang="ts">
  import { NavigationMenu } from "bits-ui";
  import CaretDown from "phosphor-svelte/lib/CaretDown";
  import cn from "clsx";

  import logo from "$lib/assets/logo.svg";

  const hardware: { title: string; href: string; content: string }[] = [
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

  const software: ListItemProps[] = [
    {
      title: "Softwave",
      href: "/softwve",
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

  type ListItemProps = {
    className?: string;
    title: string;
    href: string;
    content: string;
    rel?: string;
  };
</script>

{#snippet ListItem({ className, title, content, href, rel }: ListItemProps)}
  <li>
    <NavigationMenu.Link
      class={cn(
        "hover:bg-muted hover:text-accent-foreground focus:bg-muted focus:text-accent-foreground block space-y-1 rounded-md p-3 leading-none no-underline outline-hidden transition-colors select-none",
        className
      )}
      {href}
      {rel}>
      <div class="text-sm leading-none font-medium">{title}</div>
      <p class="text-muted-foreground line-clamp-2 text-sm leading-snug">
        {content}
      </p>
    </NavigationMenu.Link>
  </li>
{/snippet}

<div class="flex h-24 w-full justify-center">
  <header class="mx-auto flex w-full max-w-7xl items-center justify-between px-4">
    <a href="/"><img class="hidden h-8 w-9 sm:inline" src={logo} alt="" /></a>

    <div class="flex flex-1 justify-center">
      <NavigationMenu.Root class="relative z-10 flex w-full justify-center">
        <NavigationMenu.List class="group flex list-none items-center justify-center ">
          <NavigationMenu.Item value="getting-started">
            <NavigationMenu.Trigger
              class="hover:text-accent-foreground focus:bg-muted focus:text-accent-foreground data-[state=open]:shadow-mini dark:hover:bg-muted dark:data-[state=open]:bg-muted group inline-flex h-8 w-max items-center justify-center rounded-[7px] bg-transparent px-6 py-2 text-sm font-medium transition-colors hover:bg-white focus:outline-hidden disabled:pointer-events-none disabled:opacity-50 data-[state=open]:bg-white">
              Hardware
              <CaretDown class="relative top-[1px] ml-1 size-3 transition-transform duration-200 group-data-[state=open]:rotate-180" aria-hidden="true" />
            </NavigationMenu.Trigger>
            <NavigationMenu.Content
              class="data-[motion=from-end]:animate-enter-from-right data-[motion=from-start]:animate-enter-from-left data-[motion=to-end]:animate-exit-to-right data-[motion=to-start]:animate-exit-to-left absolute top-0 left-0 w-full sm:w-auto">
              <ul class="m-0 grid list-none gap-x-2.5 p-3 sm:w-[600px] sm:grid-flow-col sm:grid-rows-3 sm:p-[22px]">
                <li class="row-span-3 mb-2 sm:mb-0">
                  <NavigationMenu.Link
                    href="/"
                    class="from-muted/50 to-muted flex h-full w-full flex-col justify-end rounded-md bg-linear-to-b p-6 no-underline outline-hidden select-none focus:shadow-md">
                    <!-- <Icons.logo class="h-6 w-6" /> -->
                    <div class="mt-4 mb-2 text-lg font-medium">Our hardware</div>
                    <p class="text-muted-foreground text-sm leading-tight">Handcrafted with Love in Iceland</p>
                  </NavigationMenu.Link>
                </li>
                {#each hardware as component (component.title)}
                  {@render ListItem(component)}
                {/each}
              </ul>
            </NavigationMenu.Content>
          </NavigationMenu.Item>
          <NavigationMenu.Item>
            <NavigationMenu.Trigger
              class="hover:text-accent-foreground focus:bg-muted focus:text-accent-foreground data-[state=open]:shadow-mini dark:hover:bg-muted dark:data-[state=open]:bg-muted group inline-flex h-8 w-max items-center justify-center rounded-[7px] bg-transparent px-6 py-2 text-sm font-medium transition-colors hover:bg-white focus:outline-hidden disabled:pointer-events-none disabled:opacity-50 data-[state=open]:bg-white">
              Software
              <CaretDown class="relative top-[1px] ml-1 size-3 transition-transform duration-200 group-data-[state=open]:rotate-180" aria-hidden="true" />
            </NavigationMenu.Trigger>
            <NavigationMenu.Content
              class="data-[motion=from-end]:animate-enter-from-right data-[motion=from-start]:animate-enter-from-left data-[motion=to-end]:animate-exit-to-right data-[motion=to-start]:animate-exit-to-left absolute top-0 left-0 w-full sm:w-auto">
              <ul class="grid gap-3 p-3 sm:w-[400px] sm:p-6 md:w-[500px] md:grid-cols-2 lg:w-[600px]">
                {#each software as component (component.title)}
                  {@render ListItem(component)}
                {/each}
              </ul>
            </NavigationMenu.Content>
          </NavigationMenu.Item>
          <NavigationMenu.Item>
            <NavigationMenu.Link
              class="hover:text-accent-foreground focus:bg-muted focus:text-accent-foreground data-[state=open]:shadow-mini dark:hover:bg-muted dark:data-[state=open]:bg-muted group inline-flex h-8 w-max items-center justify-center rounded-[7px] bg-transparent px-6 py-2 text-sm font-medium transition-colors hover:bg-white focus:outline-hidden disabled:pointer-events-none disabled:opacity-50 data-[state=open]:bg-white"
              href="">
              <span class="hidden sm:inline"> Documentation </span>
              <span class="inline sm:hidden"> Docs </span>
            </NavigationMenu.Link>
          </NavigationMenu.Item>
          <NavigationMenu.Indicator
            class="data-[state=hidden]:animate-fade-out data-[state=visible]:animate-fade-in top-full z-10 flex h-2.5 items-end justify-center overflow-hidden opacity-100 transition-[all,transform_250ms_ease] duration-200 data-[state=hidden]:opacity-0">
            <div class="bg-border relative top-[70%] size-2.5 rotate-[45deg] rounded-tl-[2px]"></div>
          </NavigationMenu.Indicator>
        </NavigationMenu.List>
        <div class="absolute top-full left-0 flex w-full justify-center perspective-[2000px]">
          <NavigationMenu.Viewport
            class="text-popover-foreground bg-background data-[state=closed]:animate-scale-out data-[state=open]:animate-scale-in relative mt-2.5 h-[var(--bits-navigation-menu-viewport-height)] w-full origin-[top_center] overflow-hidden rounded-md border shadow-lg transition-[width,_height] duration-200 sm:w-[var(--bits-navigation-menu-viewport-width)] " />
        </div>
      </NavigationMenu.Root>
    </div>
  </header>
</div>
