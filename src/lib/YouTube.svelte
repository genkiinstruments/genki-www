<script lang="ts">
  import { onMount } from "svelte";
  import Button from "./Button.svelte";
  import Image from "./Image.svelte";

  let { id, altThumb = false, thumbnail = null, play_button = null } = $props();

  interface VideoInfo {
    title: string;
    width: number;
    height: number;
    [key: string]: unknown;
  }

  let videoInfo: VideoInfo;

  onMount(async () => {
    try {
      const response = await fetch(`https://www.youtube.com/oembed?url=https://www.youtube.com/watch?v=${id}&format=json`, { headers: { Accept: "application/json" } });

      if (!response.ok) {
        throw new Error(`HTTP error! status: ${response.status}`);
      }

      videoInfo = await response.json();
      title = videoInfo.title;
      width = videoInfo.width;
      height = videoInfo.height;
    } catch (error) {
      console.error("Failed to fetch video info:", error);
    }
  });

  let title = $state("");
  let width = $state(0);
  let height = $state(0);
  let play = $state(false);
</script>

<div class="you__tube" style="--aspect-ratio:{width / height || '16/9'}" {title}>
  {#if play}
    <iframe src="https://www.youtube-nocookie.com/embed/{id}?autoplay=1&rel=0" {title} frameborder="0" allow="autoplay; picture-in-picture; clipboard-write" allowfullscreen></iframe>

    <style>
      iframe {
        height: auto;
        aspect-ratio: var(--aspect-ratio);
        width: 100%;
      }
    </style>
  {:else}
    {#if thumbnail}
      {@render thumbnail()}
    {:else}
      <Image {id} {title} {altThumb} {play} />
    {/if}
    <div class="b__overlay" onclick={() => (play = true)} onkeypress={() => (play = true)} aria-label="video overlay" role="button" tabindex="0"></div>
    <div class="v__title hidden">{title}</div>
  {/if}
  {#if !play}
    <Button bind:play {play_button}></Button>
  {/if}
</div>

<style>
  .you__tube {
    position: relative;
    aspect-ratio: 1.76991;
    overflow: hidden;
  }

  .v__title {
    position: absolute;
    top: 0;
    width: 100%;
    background: linear-gradient(to bottom, hsla(0, 0%, 0%, 0.1), transparent);
    pointer-events: none;
  }
  .v__title {
    padding: 2ch;
    font-family: var(--title-font-family, "Segoe UI", Geneva, Verdana, sans-serif);
    font-size: 18px;
    color: var(--title-color, #ffffff);
    font-weight: 400;
    text-shadow: 0px 1px 3px var(--title-shadow-color, rgb(0, 0, 0, 0.2));
  }
  .b__overlay {
    position: absolute;
    top: 0;
    left: 0;
    width: 100%;
    aspect-ratio: var(--aspect-ratio);
    cursor: pointer;
    transition: var(--overlay-transition, all 250ms ease-in-out);
  }
  .you__tube:hover .b__overlay {
    background: var(--overlay-bg-color, #00000030);
  }
</style>
