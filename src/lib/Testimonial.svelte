<script lang="ts">
  import quote_mark from "$lib/assets/quote.webp";

  const { src, mobileSrc, quote, name, occupation, alt } = $props();
</script>

<div class="col-span-full w-full overflow-hidden">
  <img {src} {alt} class="hidden w-full object-cover sm:block" />
  <img src={mobileSrc ? mobileSrc : src} {alt} class="block w-full object-cover sm:hidden" />
</div>
<div class="grid grid-cols-10 space-y-4 px-[50px]">
  <div class="col-span-3 col-start-1 -mt-12 md:col-span-1 md:col-start-3">
    <img src={quote_mark} alt="Quotation mark" />
  </div>
  <div class="md:4xl col-span-7 col-start-3 text-xl md:col-span-3 md:col-start-3 md:text-4xl">{quote}</div>
  <div class="col-span-7 col-start-3 space-y-4 text-xl md:col-span-2 md:col-start-7">
    <div class="text-xl md:text-4xl">{name}</div>
    <div class="text-lg leading-tight opacity-50">{occupation}</div>
  </div>
</div>
