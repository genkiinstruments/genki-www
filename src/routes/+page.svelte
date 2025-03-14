<script lang="ts">
  import wave from "$lib/assets/wave-hand.png";
  import wavefront from "$lib/assets/wavefront-clean-hero-many-yellow.png";
  import katla from "$lib/assets/katla-hero.png";
  import softwave from "$lib/assets/softwave-hero.png";
  import cosmos from "$lib/assets/cosmos-2_3-space-closer.png";
  import cosmos_square from "$lib/assets/cosmos-2_3-gray.png";

  const heros = [
    {
      name: "Wave",
      src: wave,
      href: "/wave",
      alt: "Wave ring",
      description: "Control your sound from afar",
      price: "$349",
    },
    {
      name: "Softwave",
      src: softwave,
      href: "/softwave",
      alt: "Softwave is a free software editor for the Wavefront module",
      description: "Adjust Wave to fit your setup",
      price: "Free",
    },
    {
      name: "Wavefront",
      src: wavefront,
      href: "/wavefront",
      alt: "Wavefront is a Eurorack module specifically made for connecting with Bluetooth LE devices",
      description: "Add movement to your Eurorack",
      price: "$349",
    },
    {
      name: "Katla (coming soon)",
      src: katla,
      href: "/katla",
      alt: "Katla is a 5-voice analog syntheiszer with powerful modulation and happy accidents",
      description: "Analog polysynth inspired by Icelandic volcano Katla",
      price: "$4990",
    },
    {
      name: "Cosmos",
      src: cosmos,
      mobile_src: cosmos_square,
      href: "/cosmos",
      alt: "Embark on an epic sonic journey through space and time with the new Cosmos softsynth. Hitchhike a ride on friendly UFOs and make your music echo across the universe",
      description: "Embark on an epic journey through space and time",
      price: "$99",
    },
  ];
</script>

<div class="min-h-screen w-full flex items-center justify-center">
  <div class="px-4 py-8 sm:px-6 lg:max-w-9/10 lg:px-8 w-full mx-auto">
    <h2 id="products-heading" class="sr-only">Products</h2>

    <div
      class="grid grid-cols-1 gap-x-6 gap-y-10 sm:grid-cols-2 lg:grid-cols-3 xl:grid-cols-5 xl:gap-x-8"
    >
      {#each heros as { name, src, mobile_src, href, alt, description, price }, i (i)}
        <a {href} class="group">
          {#if mobile_src}
            <img
              src={mobile_src}
              {alt}
              class="aspect-square w-full overflow-hidden rounded-md object-cover group-hover:opacity-96 block sm:hidden"
            />
            <img
              {src}
              {alt}
              class="aspect-square w-full overflow-hidden rounded-md object-cover group-hover:opacity-96 hidden sm:block sm:aspect-2/3 shadow-lg"
            />
          {:else}
            <img
              {src}
              {alt}
              class="aspect-square w-full overflow-hidden rounded-md object-cover group-hover:opacity-96 sm:aspect-2/3 shadow-lg"
            />
          {/if}
          <div
            class="mt-4 flex items-center justify-between text-base font-medium text-gray-900"
          >
            <h3>{name}</h3>
            <p>{price}</p>
          </div>
          <p
            class="mt-1 text-sm text-gray-500 italic overflow-hidden text-ellipsis whitespace-nowrap"
          >
            {description}
          </p>
        </a>
      {/each}
    </div>
  </div>
</div>
