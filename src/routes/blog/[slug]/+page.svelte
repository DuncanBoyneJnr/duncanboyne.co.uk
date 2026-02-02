<script lang="ts">
	import { onMount } from 'svelte';
	import { page } from '$app/stores';
	import { ArrowLeft, Calendar, Clock } from 'lucide-svelte';
	import { getPostBySlug } from '$lib/supabase';
	import type { Post } from '$lib/types';

	let post: Post | null = null;
	let loading = true;
	let error: string | null = null;

	$: slug = $page.params.slug;

	onMount(async () => {
		try {
			post = await getPostBySlug(slug);
		} catch (e) {
			error = 'Failed to load this blog post. It may not exist.';
			console.error(e);
		} finally {
			loading = false;
		}
	});

	function formatDate(dateString: string): string {
		return new Date(dateString).toLocaleDateString('en-US', {
			year: 'numeric',
			month: 'long',
			day: 'numeric'
		});
	}

	function estimateReadingTime(content: string): number {
		const wordsPerMinute = 200;
		const words = content.split(/\s+/).length;
		return Math.ceil(words / wordsPerMinute);
	}
</script>

<svelte:head>
	{#if post}
		<title>{post.title} - Duncan Boyne</title>
		<meta name="description" content={post.excerpt || ''} />
	{:else}
		<title>Blog Post - Duncan Boyne</title>
	{/if}
</svelte:head>

<article class="py-16">
	<div class="container-custom max-w-4xl">
		<a
			href="/blog"
			class="inline-flex items-center text-muted hover:text-accent mb-8"
		>
			<ArrowLeft class="w-4 h-4 mr-2" />
			Back to Blog
		</a>

		{#if loading}
			<div class="animate-pulse space-y-4">
				<div class="h-8 bg-border rounded w-3/4" />
				<div class="flex space-x-4">
					<div class="h-4 bg-border rounded w-32" />
					<div class="h-4 bg-border rounded w-24" />
				</div>
				<div class="aspect-video bg-border rounded-xl" />
				<div class="space-y-2">
					{#each [1, 2, 3, 4, 5] as _}
						<div class="h-4 bg-border rounded" />
					{/each}
				</div>
			</div>
		{:else if error || !post}
			<div class="text-center py-12">
				<h1 class="text-2xl font-bold text-text mb-4">Post Not Found</h1>
				<p class="text-muted mb-8">{error || 'This blog post could not be found.'}</p>
				<a href="/blog" class="btn-primary">
					<ArrowLeft class="w-4 h-4 mr-2" />
					Back to Blog
				</a>
			</div>
		{:else}
			<header class="mb-8">
				<h1 class="text-3xl md:text-4xl lg:text-5xl font-bold text-text mb-4">
					{post.title}
				</h1>

				<div class="flex flex-wrap items-center gap-4 text-muted">
					{#if post.published_at}
						<div class="flex items-center">
							<Calendar class="w-4 h-4 mr-2" />
							<time datetime={post.published_at}>{formatDate(post.published_at)}</time>
						</div>
					{/if}
					<div class="flex items-center">
						<Clock class="w-4 h-4 mr-2" />
						<span>{estimateReadingTime(post.content)} min read</span>
					</div>
				</div>
			</header>

			{#if post.featured_image}
				<div class="mb-8">
					<img
						src={post.featured_image}
						alt={post.title}
						class="w-full rounded-xl shadow-lg"
					/>
				</div>
			{/if}

			<div class="prose prose-lg max-w-none text-text prose-headings:text-text prose-a:text-accent">
				<div class="whitespace-pre-wrap">
					{post.content}
				</div>
			</div>
		{/if}
	</div>
</article>
