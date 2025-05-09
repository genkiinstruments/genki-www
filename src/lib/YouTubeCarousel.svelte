<script lang="ts">
  import Autoplay from "embla-carousel-autoplay";
  import { WheelGesturesPlugin } from "embla-carousel-wheel-gestures";

  import YouTube from "$lib/YouTube.svelte";
  import * as Carousel from "$lib/components/ui/carousel/index.js";

  const youtube_plugin = Autoplay({ delay: 4000, stopOnInteraction: true });

  let { ids, class: className, ...restProps } = $props();
</script>

<Carousel.Root plugins={[youtube_plugin, WheelGesturesPlugin()]} opts={{ loop: true }} class={className} onmouseenter={youtube_plugin.stop} onmouseleave={youtube_plugin.reset} {...restProps}>
  <div class="relative overflow-hidden">
    <Carousel.Content>
      {#each ids as id, i (i)}
        <Carousel.Item class="rounded-lg lg:basis-3/4">
          <YouTube {id} />
        </Carousel.Item>
      {/each}
    </Carousel.Content>
    <Carousel.Previous />
    <Carousel.Next />
  </div>
</Carousel.Root>
