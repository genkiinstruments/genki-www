<script lang="ts">
  import { onMount } from "svelte";
  import { page } from "$app/state";
  import { goto } from "$app/navigation";
  import { fade } from "svelte/transition";

  let showNotification = $state(false);

  onMount(() => {
    if (page.status === 404) {
      showNotification = true;
      setTimeout(() => {
        goto("/", { replaceState: true });
      }, 2500);
    }
  });
</script>

{#if page.status === 404}
  {#if showNotification}
    <div class="fixed inset-0 z-50 flex items-center justify-center bg-black/80 backdrop-blur-md" transition:fade={{ duration: 300 }}>
      <div class="rounded-md bg-[#161616] p-8 text-[#DFDFDF] shadow-2xl">
        <div class="text-center">
          <h2 class="text-2xl font-bold">Page not found</h2>
          <p class="mt-3 text-sm opacity-80">Redirecting to homepage...</p>
          <div class="mt-6 flex justify-center">
            <div class="h-0.5 w-32 overflow-hidden rounded-full bg-[#252525]">
              <div class="h-full animate-[slide_2.5s_ease-out] bg-[#DFDFDF]"></div>
            </div>
          </div>
        </div>
      </div>
    </div>
  {/if}
{:else}
  <div class="flex min-h-screen items-center justify-center bg-black text-[#DFDFDF]">
    <div class="text-center">
      <h1 class="text-4xl font-bold">{page.status}</h1>
      <p class="mt-4 text-xl opacity-80">{page.error?.message}</p>
    </div>
  </div>
{/if}

<style>
  @keyframes slide {
    from {
      width: 0;
    }
    to {
      width: 100%;
    }
  }
</style>
