<script lang="ts">
	import { type PageData } from './$houdini';

	let { data }: { data: PageData } = $props();
	let { CategoryQuery } = $derived(data);
</script>

<h1>쉬운 전문용어</h1>
{#each $CategoryQuery.data?.category ?? [] as category (category.id)}
	<h2>{category.name}</h2>
{/each}
