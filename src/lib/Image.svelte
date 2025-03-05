<script>
  let { id = "", title = "", altThumb = false, play = false } = $props();
</script>

{#key play}
  <!-- prettier-ignore -->
  <img
    src="https://i.ytimg.com/vi/{id}/{altThumb ? 'hqdefault' : 'maxresdefault'}.jpg"
    {title}
    alt="Youtube video: {title}"
    referrerpolicy="no-referrer"
  />
{/key}

<style>
  img {
    height: auto;
    aspect-ratio: var(--aspect-ratio);
    width: 100%;
  }
</style>
