import { mdsvex } from 'mdsvex';
import adapter from '@sveltejs/adapter-auto';
import { vitePreprocess } from '@sveltejs/vite-plugin-svelte';

const config = {
	preprocess: [vitePreprocess(), mdsvex()],
	kit: {
		adapter: adapter(),

		alias: {
			$houdini: '.houdini/'
		}
	},
	extensions: ['.svelte', '.svx']
};

export default config;
