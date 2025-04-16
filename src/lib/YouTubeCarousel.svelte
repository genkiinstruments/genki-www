<script lang="ts">
  import Autoplay from "embla-carousel-autoplay";

  import YouTube from "$lib/YouTube.svelte";
  import * as Carousel from "$lib/components/ui/carousel/index.js";

  const youtube_plugin = Autoplay({ delay: 4000, stopOnInteraction: true });

  let { ids } = $props();
</script>

<Carousel.Root plugins={[youtube_plugin]} opts={{ loop: true }} class="w-full py-68" onmouseenter={youtube_plugin.stop} onmouseleave={youtube_plugin.reset}>
  <div class="relative overflow-hidden">
    <Carousel.Content>
      {#each ids as id, i (i)}
        <Carousel.Item class="rounded-lg lg:basis-1/2">
          <YouTube {id} />
        </Carousel.Item>
      {/each}
    </Carousel.Content>
    <Carousel.Previous />
    <Carousel.Next />
  </div>
</Carousel.Root>
