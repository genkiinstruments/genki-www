<script lang="ts">
  import Header from "$lib/Header.svelte";
  import Footer from "$lib/Footer.svelte";
  import Carousel from "$lib/Carousel.svelte";

  import toti from "$lib/assets/toti-studio.jpg";
  import YouTube from "$lib/YouTube.svelte";
</script>

<Header></Header>

<div class="bg-white">
  <div
    class="mx-auto max-w-2xl px-4 py-16 sm:px-6 sm:py-24 lg:max-w-7xl lg:px-8"
  >
    <h2 id="products-heading" class="sr-only">Products</h2>

    <div
      class="grid grid-cols-1 gap-x-6 gap-y-10 sm:grid-cols-2 lg:grid-cols-3 xl:gap-x-8"
    >
      <a href="/wave" class="group">
        <img
          src="https://tailwindcss.com/plus-assets/img/ecommerce-images/category-page-01-image-card-01.jpg"
          alt="Person using a pen to cross a task off a productivity paper card."
          class="aspect-square w-full overflow-hidden rounded-lg object-cover group-hover:opacity-75 sm:aspect-2/3"
        />
        <div
          class="mt-4 flex items-center justify-between text-base font-medium text-gray-900"
        >
          <h3>Wave ring</h3>
          <p>$349</p>
        </div>
        <p class="mt-1 text-sm text-gray-500 italic">
          The ring to control sound and shape effects
        </p>
      </a>
      <a href="/katla" class="group">
        <img
          src="https://tailwindcss.com/plus-assets/img/ecommerce-images/category-page-01-image-card-02.jpg"
          alt="Paper card sitting upright in walnut card holder on desk."
          class="aspect-square w-full overflow-hidden rounded-lg object-cover group-hover:opacity-75 sm:aspect-2/3"
        />
        <div
          class="mt-4 flex items-center justify-between text-base font-medium text-gray-900"
        >
          <h3>Katla</h3>
          <p>$4990</p>
        </div>
        <p class="mt-1 text-sm text-gray-500 italic">
          Analog polyphonic happy-accident machine
        </p>
      </a>
      <a href="/cosmos" class="group">
        <img
          src="https://tailwindcss.com/plus-assets/img/ecommerce-images/category-page-01-image-card-03.jpg"
          alt="Textured gray felt pouch for paper cards with snap button flap and elastic pen holder loop."
          class="aspect-square w-full overflow-hidden rounded-lg object-cover group-hover:opacity-75 sm:aspect-2/3"
        />
        <div
          class="mt-4 flex items-center justify-between text-base font-medium text-gray-900"
        >
          <h3>Cosmos</h3>
          <p>$99</p>
        </div>
        <p class="mt-1 text-sm text-gray-500 italic">
          Explore the sonic cosmos through the eyes of th...
        </p>
      </a>
      <a href="/softwave" class="group">
        <img
          src="https://tailwindcss.com/plus-assets/img/ecommerce-images/category-page-01-image-card-03.jpg"
          alt="Textured gray felt pouch for paper cards with snap button flap and elastic pen holder loop."
          class="aspect-square w-full overflow-hidden rounded-lg object-cover group-hover:opacity-75 sm:aspect-2/3"
        />
        <div
          class="mt-4 flex items-center justify-between text-base font-medium text-gray-900"
        >
          <h3>Wavefront</h3>
          <p>$349</p>
        </div>
        <p class="mt-1 text-sm text-gray-500 italic">
          Add Wave into your Eurorack system
        </p>
      </a>
      <a href="/softwave" class="group">
        <img
          src="https://tailwindcss.com/plus-assets/img/ecommerce-images/category-page-01-image-card-03.jpg"
          alt="Textured gray felt pouch for paper cards with snap button flap and elastic pen holder loop."
          class="aspect-square w-full overflow-hidden rounded-lg object-cover group-hover:opacity-75 sm:aspect-2/3"
        />
        <div
          class="mt-4 flex items-center justify-between text-base font-medium text-gray-900"
        >
          <h3>Softwave</h3>
          <p>Free</p>
        </div>
        <p class="mt-1 text-sm text-gray-500 italic">
          Customize Wave to fit your unique setup
        </p>
      </a>
      <a href="/softwave" class="group">
        <img
          src="https://tailwindcss.com/plus-assets/img/ecommerce-images/category-page-01-image-card-03.jpg"
          alt="Textured gray felt pouch for paper cards with snap button flap and elastic pen holder loop."
          class="aspect-square w-full overflow-hidden rounded-lg object-cover group-hover:opacity-75 sm:aspect-2/3"
        />
        <div
          class="mt-4 flex items-center justify-between text-base font-medium text-gray-900"
        >
          <h3>Andrea</h3>
          <p>$9999</p>
        </div>
        <p class="mt-1 text-sm text-gray-500 italic">Epic coolness 😎</p>
      </a>
    </div>
  </div>
</div>

<div class="mx-auto max-w-7xl px-4 sm:px-6 lg:px-8 rounded-lg relative py-8">
  <div class="overflow-hidden rounded-lg">
    <YouTube id="vJ-KT38i9Ls" />
  </div>
</div>

<!-- Add the full-width Toti image section -->
<div class="relative w-full h-screen mb-16">
  <img src={toti} alt="Toti Studio" class="w-full h-full object-cover" />
  <!-- Optional overlay text -->
</div>

<Carousel></Carousel>

<Footer></Footer>
