<script lang="ts">
  import "../app.css";
  import { onMount } from "svelte";
  
  let { children } = $props();
  
  // Enable cross-page horizontal swipe navigation
  onMount(() => {
    // This ensures that when swipes start from the edge of the screen,
    // the browser handles them for back/forward navigation
    document.documentElement.style.overscrollBehaviorX = "auto";
    
    return () => {
      document.documentElement.style.overscrollBehaviorX = "";
    };
  });
</script>

{@render children()}
