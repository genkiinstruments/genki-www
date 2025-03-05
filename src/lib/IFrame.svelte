<script lang="ts">
  interface Props {
    title: string;
    id: string;
  }

  let { title, id }: Props = $props();
</script>

<iframe
  src="https://www.youtube-nocookie.com/embed/{id}?autoplay=1&rel=0"
  {title}
  frameborder="0"
  allow="autoplay; picture-in-picture; clipboard-write"
  allowfullscreen
></iframe>

<style>
  iframe {
    height: auto;
    aspect-ratio: var(--aspect-ratio);
    width: 100%;
  }
</style>
