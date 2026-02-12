<script lang="ts">
	import { onMount } from 'svelte';
	import { BookOpen } from 'lucide-svelte';
	import BookCard from '$lib/components/BookCard.svelte';
	import { getBooks } from '$lib/supabase';
	import type { Book } from '$lib/types';

	let books: Book[] = [];
	let loading = true;
	let error: string | null = null;
	let activeFilter = 'all';
	let sortBy = 'recent';

	const filters = [
		{ value: 'all', label: 'All' },
		{ value: 'reading', label: 'Reading' },
		{ value: 'want_to_read', label: 'Want to Read' },
		{ value: 'completed', label: 'Completed' }
	];

	const sortOptions = [
		{ value: 'recent', label: 'Recently Finished' },
		{ value: 'rating', label: 'Rating' },
		{ value: 'title', label: 'Title' }
	];

	onMount(async () => {
		try {
			books = (await getBooks()) || [];
		} catch (e) {
			error = 'Failed to load reading list. Please try again later.';
			console.error(e);
		} finally {
			loading = false;
		}
	});

	$: currentlyReading = books.filter(b => b.status === 'reading');

	$: filteredBooks = books.filter(b => activeFilter === 'all' || b.status === activeFilter);

	$: sortedBooks = [...filteredBooks].sort((a, b) => {
		if (sortBy === 'recent') {
			if (a.finished_at && !b.finished_at) return -1;
			if (!a.finished_at && b.finished_at) return 1;
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
	<title>Reading List - Duncan Boyne</title>
	<meta name="description" content="Books I've read, am reading, and want to read — with reviews and ratings." />
</svelte:head>

<section class="py-16">
	<div class="container-custom">
		<div class="text-center mb-12">
			<h1 class="text-4xl md:text-5xl font-bold text-text mb-4">Reading List</h1>
			<p class="text-lg text-muted max-w-2xl mx-auto">
				Books I've read, am reading, and want to read — with reviews and ratings.
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
			<!-- Currently Reading Highlight -->
			{#if currentlyReading.length > 0 && (activeFilter === 'all' || activeFilter === 'reading')}
				<div class="mb-12">
					<h2 class="text-2xl font-bold text-text mb-6 flex items-center gap-2">
						<BookOpen class="w-6 h-6 text-accent" aria-hidden="true" />
						Currently Reading
					</h2>
					<div class="grid md:grid-cols-2 lg:grid-cols-3 gap-8 items-stretch">
						{#each currentlyReading as book}
							<BookCard {book} />
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

			<!-- Book Grid -->
			{#if sortedBooks.length === 0}
				<div class="text-center py-12 bg-surface rounded-xl border border-border">
					<BookOpen class="w-12 h-12 text-accent/30 mx-auto mb-4" aria-hidden="true" />
					<p class="text-muted">No books found for this filter.</p>
					<p class="text-muted/70 text-sm mt-2">Try a different filter or check back later.</p>
				</div>
			{:else}
				<div class="grid md:grid-cols-2 lg:grid-cols-3 gap-8 items-stretch">
					{#each sortedBooks as book}
						<BookCard {book} />
					{/each}
				</div>
			{/if}
		{/if}
	</div>
</section>
