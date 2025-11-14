<script lang="ts">
  let { message = "Get your own Wave and WIDI Master with every Katla purchase until end of November", anchor = "" } = $props();
</script>

<div class="relative z-10 mx-auto mt-4 w-full max-w-4xl">
  <a
    href={anchor ? `/bfcm25#${anchor}` : "/bfcm25"}
    class="block rounded-lg border border-red-600/30 bg-gradient-to-r from-red-600/20 to-purple-600/20 p-4 text-center backdrop-blur-sm transition-all duration-300 hover:border-red-600/50 hover:from-red-600/30 hover:to-purple-600/30 md:p-6">
    <div class="flex flex-col items-center gap-2 md:flex-row md:justify-center md:gap-4">
      <p class="text-sm font-medium text-white md:text-lg">{message}</p>
    </div>
  </a>
</div>
