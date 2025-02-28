<script lang="ts">
  import { NavigationMenu } from "bits-ui";
  import CaretDown from "phosphor-svelte/lib/CaretDown";
  import cn from "clsx";
  import logo from "$lib/assets/logo.svg";

  const components: { title: string; href: string; description: string }[] = [
    {
      title: "Softwave",
      href: "/",
      description:
        "The digital companion to Wave and Wavefront. Get started out of the box with the rich built-in sound enging",
    },
    {
      title: "Wave for Work",
      href: "/",
      description: "Use Wave to control slides, ",
    },
    {
      title: "Glover",
      href: "/",
      description:
        "Made by our friends at Mi.Mu, Glover allows you to connect more than two Waves for composing and performing music using movement.",
    },
    {
      title: "Scroll Area",
      href: "/",
      description: "Visually or semantically separates content.",
    },
    {
      title: "Tabs",
      href: "/",
      description:
        "A set of layered sections of content—known as tab panels—that are displayed one at a time.",
    },
    {
      title: "Tooltip",
      href: "/",
      description:
        "A popup that displays information related to an element when the element receives keyboard focus or the mouse hovers over it.",
    },
  ];

  type ListItemProps = {
    className?: string;
    title: string;
    href: string;
    content: string;
  };
  import { Avatar } from "bits-ui";

  let loadingStatus = $state<Avatar.RootProps["loadingStatus"]>("loading");
</script>

{#snippet ListItem({ className, title, content, href }: ListItemProps)}
  <li>
    <NavigationMenu.Link
      class={cn(
        "hover:bg-muted hover:text-accent-foreground focus:bg-muted focus:text-accent-foreground outline-hidden block select-none space-y-1 rounded-md p-3 leading-none no-underline transition-colors",
        className,
      )}
      {href}
    >
      <div class="text-sm font-medium leading-none">{title}</div>
      <p class="text-muted-foreground line-clamp-2 text-sm leading-snug">
        {content}
      </p>
    </NavigationMenu.Link>
  </li>
{/snippet}

<div class="flex justify-center w-full h-24">
  <header
    class="flex items-center justify-between w-full px-4 max-w-7xl mx-auto"
  >
    <Avatar.Root
      bind:loadingStatus
      class="h-12 w-12 rounded-full {loadingStatus === 'loaded'
        ? 'border-foreground'
        : 'border-transparent'} bg-muted text-muted-foreground text-[17px] font-medium uppercase"
    >
      <div
        class="flex h-full w-full items-center justify-center overflow-hidden rounded-full"
      >
        <Avatar.Image src={logo} alt="@huntabyte" />
        <Avatar.Fallback class="border-muted border">HB</Avatar.Fallback>
      </div>
    </Avatar.Root>

    <div class="flex-1 flex justify-center">
      <NavigationMenu.Root class="relative z-10 flex w-full justify-center">
        <NavigationMenu.List
          class="group flex list-none items-center justify-center "
        >
          <NavigationMenu.Item value="getting-started">
            <NavigationMenu.Trigger
              class="hover:text-accent-foreground focus:bg-muted focus:text-accent-foreground data-[state=open]:shadow-mini dark:hover:bg-muted dark:data-[state=open]:bg-muted focus:outline-hidden group inline-flex h-8 w-max items-center justify-center rounded-[7px] bg-transparent px-6 py-2 text-sm font-medium transition-colors hover:bg-white disabled:pointer-events-none disabled:opacity-50 data-[state=open]:bg-white"
            >
              Hardware
              <CaretDown
                class="relative top-[1px] ml-1 size-3 transition-transform duration-200 group-data-[state=open]:rotate-180"
                aria-hidden="true"
              />
            </NavigationMenu.Trigger>
            <NavigationMenu.Content
              class="data-[motion=from-end]:animate-enter-from-right data-[motion=from-start]:animate-enter-from-left data-[motion=to-end]:animate-exit-to-right data-[motion=to-start]:animate-exit-to-left absolute left-0 top-0 w-full sm:w-auto"
            >
              <ul
                class="m-0 grid list-none gap-x-2.5 p-3 sm:w-[600px] sm:grid-flow-col sm:grid-rows-3 sm:p-[22px]"
              >
                <li class="row-span-3 mb-2 sm:mb-0">
                  <NavigationMenu.Link
                    href="/"
                    class="from-muted/50 to-muted bg-linear-to-b outline-hidden flex h-full w-full select-none flex-col justify-end rounded-md p-6 no-underline focus:shadow-md"
                  >
                    <!-- <Icons.logo class="h-6 w-6" /> -->
                    <div class="mb-2 mt-4 text-lg font-medium">
                      Our hardware
                    </div>
                    <p class="text-muted-foreground text-sm leading-tight">
                      Handcrafted with Love in Iceland
                    </p>
                  </NavigationMenu.Link>
                </li>

                {@render ListItem({
                  href: "/",
                  title: "Wave",
                  content: "Move and control sound",
                })}
                {@render ListItem({
                  href: "/",
                  title: "Wavefront",
                  content: "Add Wave/iPad™ to your Eurorack",
                })}
                {@render ListItem({
                  href: "/",
                  title: "Katla",
                  content: "5-voice, analog happy-accident machine",
                })}
              </ul>
            </NavigationMenu.Content>
          </NavigationMenu.Item>
          <NavigationMenu.Item>
            <NavigationMenu.Trigger
              class="hover:text-accent-foreground focus:bg-muted focus:text-accent-foreground data-[state=open]:shadow-mini dark:hover:bg-muted dark:data-[state=open]:bg-muted focus:outline-hidden group inline-flex h-8 w-max items-center justify-center rounded-[7px] bg-transparent px-6 py-2 text-sm font-medium transition-colors hover:bg-white disabled:pointer-events-none disabled:opacity-50 data-[state=open]:bg-white"
            >
              Software
              <CaretDown
                class="relative top-[1px] ml-1 size-3 transition-transform duration-200 group-data-[state=open]:rotate-180"
                aria-hidden="true"
              />
            </NavigationMenu.Trigger>
            <NavigationMenu.Content
              class="data-[motion=from-end]:animate-enter-from-right data-[motion=from-start]:animate-enter-from-left data-[motion=to-end]:animate-exit-to-right data-[motion=to-start]:animate-exit-to-left absolute left-0 top-0 w-full sm:w-auto"
            >
              <ul
                class="grid gap-3 p-3 sm:w-[400px] sm:p-6 md:w-[500px] md:grid-cols-2 lg:w-[600px]"
              >
                {#each components as component (component.title)}
                  {@render ListItem({
                    href: component.href,
                    title: component.title,
                    content: component.description,
                  })}
                {/each}
              </ul>
            </NavigationMenu.Content>
          </NavigationMenu.Item>
          <NavigationMenu.Item>
            <NavigationMenu.Link
              class="hover:text-accent-foreground focus:bg-muted focus:text-accent-foreground data-[state=open]:shadow-mini dark:hover:bg-muted dark:data-[state=open]:bg-muted focus:outline-hidden group inline-flex h-8 w-max items-center justify-center rounded-[7px] bg-transparent px-6 py-2 text-sm font-medium transition-colors hover:bg-white disabled:pointer-events-none disabled:opacity-50 data-[state=open]:bg-white"
              href=""
            >
              <span class="hidden sm:inline"> Documentation </span>
              <span class="inline sm:hidden"> Docs </span>
            </NavigationMenu.Link>
          </NavigationMenu.Item>
          <NavigationMenu.Indicator
            class="data-[state=hidden]:animate-fade-out data-[state=visible]:animate-fade-in top-full z-10 flex h-2.5 items-end justify-center overflow-hidden opacity-100 transition-[all,transform_250ms_ease] duration-200 data-[state=hidden]:opacity-0"
          >
            <div
              class="bg-border relative top-[70%] size-2.5 rotate-[45deg] rounded-tl-[2px]"
            ></div>
          </NavigationMenu.Indicator>
        </NavigationMenu.List>
        <div
          class="perspective-[2000px] absolute left-0 top-full flex w-full justify-center"
        >
          <NavigationMenu.Viewport
            class="text-popover-foreground bg-background data-[state=closed]:animate-scale-out data-[state=open]:animate-scale-in relative mt-2.5 h-[var(--bits-navigation-menu-viewport-height)] w-full origin-[top_center] overflow-hidden rounded-md border shadow-lg transition-[width,_height] duration-200 sm:w-[var(--bits-navigation-menu-viewport-width)] "
          />
        </div>
      </NavigationMenu.Root>
    </div>
    <!-- Right side empty space to balance layout -->
    <Avatar.Root
      bind:loadingStatus
      class="h-12 w-12 rounded-full {loadingStatus === 'loaded'
        ? 'border-foreground'
        : 'border-transparent'} bg-muted text-muted-foreground text-[17px] font-medium uppercase"
    >
      <div
        class="flex h-full w-full items-center justify-center overflow-hidden rounded-full"
      >
        <Avatar.Image src={logo} alt="@huntabyte" />
        <Avatar.Fallback class="">HB</Avatar.Fallback>
      </div>
    </Avatar.Root>
  </header>
</div>
