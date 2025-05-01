<script lang="ts">
  import "../app.css";
  import { onMount } from "svelte";

  let { children } = $props();

  // Enable cross-page horizontal swipe navigation
  onMount(() => {
    // This ensures that when swipes start from the edge of the screen,
    // the browser handles them for back/forward navigation
    document.documentElement.style.overscrollBehaviorX = "auto";
    document.addEventListener("keydown", handleKeyDown);

    return () => {
      document.documentElement.style.overscrollBehaviorX = "";
      document.removeEventListener("keydown", handleKeyDown);
    };
  });

  let showGrid = $state(false);
  // Define the document-level handler - need to ensure this function reference doesn't change
  function handleKeyDown(event: KeyboardEvent) {
    if (event.key === "'") {
      showGrid = !showGrid;
    }
  }
</script>

{@render children()}

{#if showGrid}
  <div class="absopointer-events-none fixed inset-0 z-[9998]">
    <div class="mx-auto h-full px-5 md:px-[50px]">
      <div class="flex h-full justify-between">
        {#each Array(10) as _, i (i)}
          <div class="mx-[5px] h-full flex-1 bg-[rgba(85,85,85,0.5)] first:ml-0 last:mr-0"></div>
        {/each}
      </div>
    </div>
  </div>
{/if}
