<script lang="ts">
	import { onMount } from 'svelte';
	import TalkCard from '$lib/components/TalkCard.svelte';
	import { getTalks } from '$lib/supabase';
	import type { Talk } from '$lib/types';

	let talks: Talk[] = [];
	let loading = true;
	let error: string | null = null;

	onMount(async () => {
		try {
			talks = (await getTalks()) || [];
		} catch (e) {
			error = 'Failed to load talks. Please try again later.';
			console.error(e);
		} finally {
			loading = false;
		}
	});
</script>

<svelte:head>
	<title>Talks - Duncan Boyne</title>
	<meta name="description" content="Conference talks and presentations by Duncan Boyne on Power BI, data visualization, and business intelligence." />
</svelte:head>

<section class="py-16">
	<div class="container-custom">
		<div class="text-center mb-12">
			<h1 class="text-4xl md:text-5xl font-bold text-text mb-4">Talks</h1>
			<p class="text-lg text-muted max-w-2xl mx-auto">
				Conference talks and presentations on Power BI, data visualization, and dashboard design.
			</p>
		</div>

		{#if loading}
			<div class="grid md:grid-cols-2 lg:grid-cols-3 gap-8">
				{#each [1, 2, 3] as _}
					<div class="card animate-pulse">
						<div class="aspect-video bg-border" />
						<div class="p-6 space-y-3">
							<div class="h-6 bg-border rounded" />
							<div class="h-4 bg-border rounded w-2/3" />
						</div>
					</div>
				{/each}
			</div>
		{:else if error}
			<p class="text-center text-muted py-12">{error}</p>
		{:else if talks.length === 0}
			<div class="text-center py-12">
				<p class="text-muted mb-4">No talks yet.</p>
				<p class="text-muted/70">Check back soon for new content!</p>
			</div>
		{:else}
			<div class="grid md:grid-cols-2 lg:grid-cols-3 gap-8">
				{#each talks as talk}
					<TalkCard {talk} />
				{/each}
			</div>
		{/if}
	</div>
</section>
