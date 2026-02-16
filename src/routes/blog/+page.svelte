<script lang="ts">
	import { onMount } from 'svelte';
	import BlogCard from '$lib/components/BlogCard.svelte';
	import { getPosts } from '$lib/supabase';
	import type { Post } from '$lib/types';

	let posts: Post[] = [];
	let loading = true;
	let error: string | null = null;
	let activeFilter = 'all';

	const filters = [
		{ value: 'all', label: 'All' },
		{ value: 'Power BI', label: 'Power BI' },
		{ value: 'NPPUG', label: 'NPPUG' },
		{ value: 'EoEPPS', label: 'EoEPPS' },
		{ value: 'ManchesterDataHive', label: 'Manchester Data Hive' },
		{ value: 'MentalHealth', label: 'Mental Health' },
		{ value: 'AI', label: 'AI' },
		{ value: 'Talks', label: 'Talks' },
		{ value: 'Conferences', label: 'Conferences' }
	];

	onMount(async () => {
		try {
			posts = (await getPosts()) || [];
		} catch (e) {
			error = 'Failed to load blog posts. Please try again later.';
			console.error(e);
		} finally {
			loading = false;
		}
	});

	$: filteredPosts = activeFilter === 'all'
		? posts
		: posts.filter(p => p.tags?.includes(activeFilter));
</script>

<svelte:head>
	<title>Blog - Duncan Boyne</title>
	<meta name="description" content="Read the latest articles on Power BI, data visualization, and business intelligence from Duncan Boyne." />
</svelte:head>

<section class="py-16">
	<div class="container-custom">
		<div class="text-center mb-12">
			<h1 class="text-4xl md:text-5xl font-bold text-text mb-4">Blog</h1>
			<p class="text-lg text-muted max-w-2xl mx-auto">
				Insights, tutorials, and thoughts on Power BI, data visualization, and business intelligence.
			</p>
		</div>

		{#if loading}
			<div role="status" aria-live="polite">
				<span class="sr-only">Loading blog posts...</span>
			</div>
			<div class="grid md:grid-cols-2 lg:grid-cols-3 gap-8">
				{#each [1, 2, 3, 4, 5, 6] as _}
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
			<!-- Filters -->
			<div class="flex flex-wrap gap-2 mb-8" role="tablist" aria-label="Filter by category">
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

			{#if filteredPosts.length === 0}
				<div class="text-center py-12 bg-surface rounded-xl border border-border">
					<p class="text-muted">No posts found for this category.</p>
					<p class="text-muted/70 text-sm mt-2">Try a different filter or check back later.</p>
				</div>
			{:else}
				<div class="grid md:grid-cols-2 lg:grid-cols-3 gap-8 items-stretch">
					{#each filteredPosts as post}
						<BlogCard {post} />
					{/each}
				</div>
			{/if}
		{/if}
	</div>
</section>
