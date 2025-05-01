<script lang="ts">
  import quote_mark from "$lib/assets/quote.webp";

  const { src, quote, name, occupation, alt } = $props();
</script>

<div class="w-full overflow-hidden">
  <img {src} {alt} class="w-full object-cover" />
</div>
<div class="@container -mt-4 grid grid-cols-10">
  <div class="col-span-3 col-start-1 md:col-span-1 md:col-start-3">
    <img src={quote_mark} alt="Quotation mark" />
  </div>
</div>
<div class="grid grid-cols-10 gap-4 px-5 pt-7 md:gap-0 md:px-0">
  <div class="col-span-8 col-start-3 text-xl md:col-span-3 md:col-start-3 md:text-4xl">{quote}</div>
  <div class="col-span-8 col-start-3 mt-4 space-y-2 md:col-span-2 md:col-start-8 md:mt-0 md:flex md:flex-col">
    <div class="text-xl md:text-4xl">{name}</div>
    <div class="text-lg leading-tight opacity-50 md:text-base">{occupation}</div>
  </div>
</div>
