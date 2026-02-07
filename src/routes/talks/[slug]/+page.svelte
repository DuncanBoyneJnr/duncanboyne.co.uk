<script lang="ts">
	import { onMount } from 'svelte';
	import { page } from '$app/stores';
	import { ArrowLeft, Mic } from 'lucide-svelte';
	import { getTalkBySlug } from '$lib/supabase';
	import type { Talk } from '$lib/types';

	let talk: Talk | null = null;
	let loading = true;
	let error: string | null = null;

	$: slug = $page.params.slug;

	onMount(async () => {
		try {
			talk = await getTalkBySlug(slug);
		} catch (e) {
			error = 'Failed to load this talk. It may not exist.';
			console.error(e);
		} finally {
			loading = false;
		}
	});
</script>

<svelte:head>
	{#if talk}
		<title>{talk.title} - Duncan Boyne</title>
		<meta name="description" content={talk.excerpt || ''} />
	{:else}
		<title>Talk - Duncan Boyne</title>
	{/if}
</svelte:head>

<article class="py-16">
	<div class="container-custom max-w-4xl">
		<a
			href="/talks"
			class="inline-flex items-center text-muted hover:text-accent mb-8"
		>
			<ArrowLeft class="w-4 h-4 mr-2" />
			Back to Talks
		</a>

		{#if loading}
			<div class="animate-pulse space-y-4">
				<div class="h-8 bg-border rounded w-3/4" />
				<div class="space-y-2">
					{#each [1, 2, 3, 4, 5] as _}
						<div class="h-4 bg-border rounded" />
					{/each}
				</div>
			</div>
		{:else if error || !talk}
			<div class="text-center py-12">
				<h1 class="text-2xl font-bold text-text mb-4">Talk Not Found</h1>
				<p class="text-muted mb-8">{error || 'This talk could not be found.'}</p>
				<a href="/talks" class="btn-primary">
					<ArrowLeft class="w-4 h-4 mr-2" />
					Back to Talks
				</a>
			</div>
		{:else}
			<header class="mb-8">
				<div class="inline-flex items-center gap-1.5 px-3 py-1.5 text-xs font-semibold rounded-full bg-info/15 text-info mb-4">
					<Mic class="w-3.5 h-3.5" />
					Talk
				</div>
				<h1 class="text-3xl md:text-4xl lg:text-5xl font-bold text-text mb-4">
					{talk.title}
				</h1>
			</header>

			<div class="prose prose-lg max-w-none text-text prose-headings:text-text prose-a:text-accent">
				<div class="whitespace-pre-wrap">
					{talk.content}
				</div>
			</div>
		{/if}
	</div>
</article>
