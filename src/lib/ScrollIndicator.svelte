<script lang="ts">
  import { onMount } from "svelte";
  import { fade } from "svelte/transition";

  // Automatically hide indicator after some time
  let visible = $state(true);

  onMount(() => {
    // Hide the indicator after 5 seconds
    const timeout = setTimeout(() => {
      visible = false;
    }, 5000);

    window.addEventListener("scroll", handleScroll);
    return () => {
      window.removeEventListener("scroll", handleScroll);
      clearTimeout(timeout);
    };
  });
  //
  // Hide scroll indicator when user scrolls
  function handleScroll() {
    if (window.scrollY > 5) {
      visible = false;
    }
  }
</script>

{#if visible}
  <div class="fixed bottom-8 left-1/2 z-50 flex -translate-x-1/2 flex-col items-center opacity-30" transition:fade={{ duration: 700 }}>
    <!-- <div class="text-xs uppercase tracking-widest mb-2 text-center opacity-60">Scroll</div> -->
    <div class="animate-scroll-dot h-3 w-1 rounded-full bg-white backdrop-opacity-20"></div>
  </div>
{/if}

<style>
  @keyframes scrollAnimation {
    0% {
      transform: translateY(0);
      opacity: 1;
    }
    70% {
      transform: translateY(15px);
      opacity: 0;
    }
    71% {
      transform: translateY(0);
      opacity: 0;
    }
    100% {
      transform: translateY(0);
      opacity: 1;
    }
  }

  :global(.animate-scroll-dot) {
    animation: scrollAnimation 2s infinite;
  }
</style>

