<script lang="ts">
  import box from "$lib/assets/wave-open-box.webp";
  import wave from "$lib/assets/wave-render-closeup.webp";
  import korg from "$lib/assets/wave-korg.webp";
  import cool from "$lib/assets/wave-cool.webp";
  import fabris from "$lib/assets/wave-fabris.webp";
  import korg_red from "$lib/assets/wave-korg-orange.webp";
  import piano from "$lib/assets/wave-piano.webp";
  import toti from "$lib/assets/wave-toti-producer.webp";

  const images = [
    { src: box, alt: "Side profile" },
    { src: korg, alt: "Front view" },
    { src: wave, alt: "Side profile" },
    { src: cool, alt: "Side profile" },
    { src: fabris, alt: "Front view" },
    { src: korg_red, alt: "Side profile" },
    { src: piano, alt: "Side profile" },
    { src: toti, alt: "Front view" },
  ];

  import Autoplay from "embla-carousel-autoplay";
  import * as Carousel from "$lib/components/ui/carousel/index.js";

  const plugin = Autoplay({ delay: 2000, stopOnInteraction: true });
</script>

<Carousel.Root plugins={[plugin]} opts={{ loop: true }} class="max-h-1/5 w-full" onmouseenter={plugin.stop} onmouseleave={plugin.reset}>
  <Carousel.Content>
    {#each images as { src, alt }, i (i)}
      <Carousel.Item class="border-0 md:basis-1/2 lg:basis-1/3">
        <img {src} {alt} />
      </Carousel.Item>
    {/each}
  </Carousel.Content>
  <Carousel.Previous />
  <Carousel.Next />
</Carousel.Root>
