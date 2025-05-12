<script lang="ts">
  import { onMount } from "svelte";
  import { fade } from "svelte/transition";

  // Initialize state based on current scroll position (SSR-friendly)
  let visible = $state(typeof window !== "undefined" && window.scrollY === 0);

  // Flag to ensure timeout is only set once if conditions are met
  let timeoutId: ReturnType<typeof setTimeout> | null = null;

  function handleScroll() {
    // Hide if currently visible and user scrolls away from the top
    if (visible && window.scrollY > 0) {
      visible = false;
      // Clear the timeout if scrolling hides it first
      if (timeoutId) {
        clearTimeout(timeoutId);
        timeoutId = null;
      }
    }
  }

  onMount(() => {
    // Re-check visibility on mount for client-side hydration consistency
    // This handles cases where SSR value might differ from initial client state
    const isAtTop = window.scrollY === 0;
    if (!visible && isAtTop) {
      // If SSR rendered it hidden, but client is at top, make it visible
      visible = true;
    } else if (visible && !isAtTop) {
      // If SSR rendered it visible, but client isn't at top, hide it
      visible = false;
    }

    // Only set the timeout if it's currently visible AND the page is at the top
    if (visible && isAtTop) {
      timeoutId = setTimeout(() => {
        visible = false;
        timeoutId = null; // Clear the stored ID
      }, 5000); // 5 seconds
    }

    window.addEventListener("scroll", handleScroll, { passive: true });

    // Cleanup listener and any active timer
    return () => {
      window.removeEventListener("scroll", handleScroll);
      if (timeoutId) {
        clearTimeout(timeoutId);
      }
    };
  });
</script>

{#if visible}
  <div class="fixed bottom-8 left-1/2 z-50 flex -translate-x-1/2 flex-col items-center opacity-30" transition:fade={{ duration: 500 }}>
    <div class="animate-scroll-dot h-3 w-1 rounded-full"></div>
  </div>
{/if}

<style>
  @keyframes scrollAnimation {
    0%,
    100% {
      transform: translateY(0);
      opacity: 1;
    }
    50% {
      transform: translateY(12px);
      opacity: 0.3;
    }
  }

  .animate-scroll-dot {
    animation: scrollAnimation 1.8s infinite ease-in-out;
  }
</style>
