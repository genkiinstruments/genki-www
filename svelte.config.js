import adapter from '@sveltejs/adapter-static';
import { vitePreprocess } from "@sveltejs/vite-plugin-svelte";

/** @type {import('@sveltejs/kit').Config} */
const config = {
  // Consult https://svelte.dev/docs/kit/integrations
  // for more information about preprocessors
  preprocess: vitePreprocess(),

  kit: {
    // Use static adapter for simplicity
    adapter: adapter({
      // Output directory for the static site
      pages: 'build',
      assets: 'build',
      fallback: 'index.html',
      precompress: false
    })
  },
};

export default config;