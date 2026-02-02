<script lang="ts">
	import { onMount } from 'svelte';
	import BlogCard from '$lib/components/BlogCard.svelte';
	import { getPosts } from '$lib/supabase';
	import type { Post } from '$lib/types';

	let posts: Post[] = [];
	let loading = true;
	let error: string | null = null;

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
		{:else if posts.length === 0}
			<div class="text-center py-12">
				<p class="text-muted mb-4">No blog posts yet.</p>
				<p class="text-muted/70">Check back soon for new content!</p>
			</div>
		{:else}
			<div class="grid md:grid-cols-2 lg:grid-cols-3 gap-8">
				{#each posts as post}
					<BlogCard {post} />
				{/each}
			</div>
		{/if}
	</div>
</section>
