<script lang="ts">
	import { onMount } from 'svelte';
	import { Tv } from 'lucide-svelte';
	import AnimeCard from '$lib/components/AnimeCard.svelte';
	import { getAnime } from '$lib/supabase';
	import type { Anime } from '$lib/types';

	let animeList: Anime[] = [];
	let loading = true;
	let error: string | null = null;
	let activeFilter = 'all';
	let sortBy = 'recent';

	const filters = [
		{ value: 'all', label: 'All' },
		{ value: 'watching', label: 'Watching' },
		{ value: 'completed', label: 'Completed' },
		{ value: 'on_hold', label: 'On Hold' },
		{ value: 'dropped', label: 'Dropped' },
		{ value: 'plan_to_watch', label: 'Plan to Watch' }
	];

	const sortOptions = [
		{ value: 'recent', label: 'Recently Watched' },
		{ value: 'rating', label: 'Rating' },
		{ value: 'title', label: 'Title' }
	];

	onMount(async () => {
		try {
			animeList = (await getAnime()) || [];
		} catch (e) {
			error = 'Failed to load anime list. Please try again later.';
			console.error(e);
		} finally {
			loading = false;
		}
	});

	$: currentlyWatching = animeList.filter(a => a.status === 'watching');

	$: filteredAnime = animeList.filter(a => activeFilter === 'all' || a.status === activeFilter);

	$: sortedAnime = [...filteredAnime].sort((a, b) => {
		if (sortBy === 'recent') {
			const aDate = a.finished_at || a.started_at || a.created_at;
			const bDate = b.finished_at || b.started_at || b.created_at;
			return new Date(bDate).getTime() - new Date(aDate).getTime();
		}
		if (sortBy === 'rating') {
			return (b.rating || 0) - (a.rating || 0);
		}
		return a.title.localeCompare(b.title);
	});
</script>

<svelte:head>
	<title>Anime List - Duncan Boyne</title>
	<meta name="description" content="My anime watch list with ratings and reviews." />
</svelte:head>

<section class="py-16">
	<div class="container-custom">
		<div class="text-center mb-12">
			<h1 class="text-4xl md:text-5xl font-bold text-text mb-4">Anime List</h1>
			<p class="text-lg text-muted max-w-2xl mx-auto">
				My anime watch list, ratings, and reviews.
			</p>
		</div>

		{#if loading}
			<div class="grid md:grid-cols-2 lg:grid-cols-3 gap-8">
				{#each [1, 2, 3] as _}
					<div class="card animate-pulse">
						<div class="aspect-video bg-border" />
						<div class="p-6 space-y-3">
							<div class="h-4 bg-border rounded w-1/3" />
							<div class="h-6 bg-border rounded" />
							<div class="h-4 bg-border rounded w-2/3" />
						</div>
					</div>
				{/each}
			</div>
		{:else if error}
			<p class="text-center text-muted py-12">{error}</p>
		{:else}
			<!-- Currently Watching Highlight -->
			{#if currentlyWatching.length > 0}
				<div class="mb-12">
					<h2 class="text-2xl font-bold text-text mb-6 flex items-center gap-2">
						<Tv class="w-6 h-6 text-accent" aria-hidden="true" />
						Currently Watching
					</h2>
					<div class="grid md:grid-cols-2 lg:grid-cols-3 gap-8 items-stretch">
						{#each currentlyWatching as anime}
							<AnimeCard {anime} />
						{/each}
					</div>
				</div>
			{/if}

			<!-- Filters & Sort -->
			<div class="flex flex-col sm:flex-row items-start sm:items-center justify-between gap-4 mb-8">
				<div class="flex flex-wrap gap-2" role="tablist" aria-label="Filter by status">
					{#each filters as filter}
						<button
							on:click={() => activeFilter = filter.value}
							class="px-4 py-2 rounded-lg text-sm font-medium transition-colors focus:outline-none focus:ring-2 focus:ring-accent {activeFilter === filter.value
								? 'bg-accent text-bg'
								: 'bg-surface border border-border text-muted hover:text-text hover:border-accent/50'}"
							role="tab"
							aria-selected={activeFilter === filter.value}
						>
							{filter.label}
						</button>
					{/each}
				</div>

				<select
					bind:value={sortBy}
					class="px-3 py-2 rounded-lg text-sm bg-surface border border-border text-text focus:outline-none focus:ring-2 focus:ring-accent"
					aria-label="Sort by"
				>
					{#each sortOptions as opt}
						<option value={opt.value}>{opt.label}</option>
					{/each}
				</select>
			</div>

			<!-- Anime Grid -->
			{#if sortedAnime.length === 0}
				<div class="text-center py-12 bg-surface rounded-xl border border-border">
					<Tv class="w-12 h-12 text-accent/30 mx-auto mb-4" aria-hidden="true" />
					<p class="text-muted">No anime found for this filter.</p>
					<p class="text-muted/70 text-sm mt-2">Try a different filter or check back later.</p>
				</div>
			{:else}
				<div class="grid md:grid-cols-2 lg:grid-cols-3 gap-8 items-stretch">
					{#each sortedAnime as anime}
						<AnimeCard {anime} />
					{/each}
				</div>
			{/if}
		{/if}
	</div>
</section>
