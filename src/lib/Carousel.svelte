<script lang="ts">
  import box from "$lib/assets/wave-open-box.png";
  import wave from "$lib/assets/wave-render-closeup.png";
  import korg from "$lib/assets/wave-korg.png";
  import cool from "$lib/assets/wave-cool.png";
  import fabris from "$lib/assets/wave-fabris.png";
  import korg_red from "$lib/assets/wave-korg-orange.png";
  import piano from "$lib/assets/wave-piano.png";
  import toti from "$lib/assets/wave-toti-producer.png";

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

<Carousel.Root
  plugins={[plugin]}
  opts={{ loop: true }}
  class="w-full max-h-1/5"
  onmouseenter={plugin.stop}
  onmouseleave={plugin.reset}
>
  <Carousel.Content>
    {#each images as { src, alt }, i (i)}
      <Carousel.Item class="md:basis-1/2 lg:basis-1/3 border-0">
        <img {src} {alt} />
      </Carousel.Item>
    {/each}
  </Carousel.Content>
  <Carousel.Previous />
  <Carousel.Next />
</Carousel.Root>
