<script lang="ts">
	import { onMount } from 'svelte';
	import { page } from '$app/stores';
	import { ArrowLeft, Mic, BookOpen, Calendar, MapPin, ExternalLink, FileText, Globe, Linkedin } from 'lucide-svelte';
	import { marked } from 'marked';
	import { getTalkBySlug, getEventsByTalkSlug } from '$lib/supabase';
	import type { Talk, Event } from '$lib/types';

	let talk: Talk | null = null;
	let upcomingEvents: Event[] = [];
	let pastEvents: Event[] = [];
	let loading = true;
	let error: string | null = null;

	$: slug = $page.params.slug;

	function formatDate(dateString: string): string {
		return new Date(dateString).toLocaleDateString('en-GB', {
			weekday: 'short',
			day: 'numeric',
			month: 'short',
			year: 'numeric'
		});
	}

	onMount(async () => {
		try {
			const [talkData, events] = await Promise.all([
				getTalkBySlug(slug),
				getEventsByTalkSlug(slug)
			]);
			talk = talkData;
			const now = new Date().toISOString();
			upcomingEvents = (events || []).filter(e => e.event_date >= now);
			pastEvents = (events || []).filter(e => e.event_date < now);
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
			Back to Speaking
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
					Back to Speaking
				</a>
			</div>
		{:else}
			<header class="mb-8">
				<div class="inline-flex items-center gap-1.5 px-3 py-1.5 text-xs font-semibold rounded-full {talk.type === 'workshop' ? 'bg-accent text-[#1F1F1F]' : 'bg-info/15 text-info'} mb-4">
					{#if talk.type === 'workshop'}
						<BookOpen class="w-3.5 h-3.5" />
						Workshop
					{:else}
						<Mic class="w-3.5 h-3.5" />
						Talk
					{/if}
				</div>
				<h1 class="text-3xl md:text-4xl lg:text-5xl font-bold text-text mb-4">
					{talk.title}
				</h1>
				{#if talk.co_host_name}
					<div class="flex flex-wrap items-center gap-3 text-muted">
						<span class="text-sm">Co-hosted with <strong class="text-text">{talk.co_host_name}</strong></span>
						{#if talk.co_host_url}
							<a href={talk.co_host_url} target="_blank" rel="noopener noreferrer" class="inline-flex items-center gap-1 text-sm text-accent hover:underline">
								<Globe class="w-3.5 h-3.5" />
								Website
								<span class="sr-only"> (opens in new window)</span>
							</a>
						{/if}
						{#if talk.co_host_linkedin}
							<a href={talk.co_host_linkedin} target="_blank" rel="noopener noreferrer" class="inline-flex items-center gap-1 text-sm text-accent hover:underline">
								<Linkedin class="w-3.5 h-3.5" />
								LinkedIn
								<span class="sr-only"> (opens in new window)</span>
							</a>
						{/if}
					</div>
				{/if}
			</header>

			{#if talk.image}
				<div class="mb-8 rounded-xl overflow-hidden">
					<img src={talk.image} alt={talk.title} class="w-full" />
				</div>
			{/if}

			<div class="talk-content">
				{@html marked(talk.content)}
			</div>

			<!-- Upcoming Events -->
			{#if upcomingEvents.length > 0}
				<div class="mt-12 pt-8 border-t border-border">
					<h2 class="text-2xl font-bold text-text mb-6">Upcoming Events</h2>
					<div class="space-y-4">
						{#each upcomingEvents as event}
							<div class="card p-5 flex flex-col sm:flex-row sm:items-center gap-4">
								<div class="flex-1">
									<h3 class="font-semibold text-text">{event.title}</h3>
									<div class="flex flex-wrap items-center gap-4 mt-2 text-sm text-muted">
										<span class="flex items-center gap-1.5">
											<Calendar class="w-4 h-4" />
											{formatDate(event.event_date)}
										</span>
										{#if event.location}
											<span class="flex items-center gap-1.5">
												<MapPin class="w-4 h-4" />
												{event.location}
											</span>
										{/if}
									</div>
								</div>
								<div class="flex items-center gap-2">
									{#if event.slide_deck_url}
										<a
											href={event.slide_deck_url}
											target="_blank"
											rel="noopener noreferrer"
											class="inline-flex items-center px-4 py-2 border border-accent text-accent font-medium rounded-lg hover:bg-accent/10 transition-colors text-sm whitespace-nowrap"
										>
											<FileText class="w-4 h-4 mr-2" />
											Slides
											<span class="sr-only"> (opens in new window)</span>
										</a>
									{/if}
									{#if event.event_url}
										<a
											href={event.event_url}
											target="_blank"
											rel="noopener noreferrer"
											class="inline-flex items-center px-4 py-2 bg-accent text-[#1F1F1F] font-medium rounded-lg hover:bg-accent2 transition-colors text-sm whitespace-nowrap"
										>
											Register
											<span class="sr-only"> (opens in new window)</span>
											<ExternalLink class="w-4 h-4 ml-2" />
										</a>
									{/if}
								</div>
							</div>
						{/each}
					</div>
				</div>
			{/if}

			<!-- Past Events -->
			{#if pastEvents.length > 0}
				<div class="mt-12 pt-8 border-t border-border">
					<h2 class="text-2xl font-bold text-text mb-6">Previously Presented At</h2>
					<div class="space-y-4">
						{#each pastEvents as event}
							<div class="card p-5 flex flex-col sm:flex-row sm:items-center gap-4 opacity-60" aria-label="Past event">
								<div class="flex-1">
									<h3 class="font-semibold text-text">{event.title}</h3>
									<div class="flex flex-wrap items-center gap-4 mt-2 text-sm text-muted">
										<span class="flex items-center gap-1.5">
											<Calendar class="w-4 h-4" />
											{formatDate(event.event_date)}
										</span>
										{#if event.location}
											<span class="flex items-center gap-1.5">
												<MapPin class="w-4 h-4" />
												{event.location}
											</span>
										{/if}
									</div>
								</div>
								{#if event.slide_deck_url}
									<a
										href={event.slide_deck_url}
										target="_blank"
										rel="noopener noreferrer"
										class="inline-flex items-center px-4 py-2 border border-accent text-accent font-medium rounded-lg hover:bg-accent/10 transition-colors text-sm whitespace-nowrap"
									>
										<FileText class="w-4 h-4 mr-2" />
										Slides
										<span class="sr-only"> (opens in new window)</span>
									</a>
								{/if}
							</div>
						{/each}
					</div>
				</div>
			{/if}
		{/if}
	</div>
</article>

<style>
	.talk-content {
		font-size: 1.125rem;
		line-height: 1.8;
		color: var(--color-text);
	}

	.talk-content :global(a) {
		color: var(--color-accent);
		text-decoration: underline;
		text-underline-offset: 3px;
		font-weight: 500;
	}

	.talk-content :global(a:hover),
	.talk-content :global(a:focus) {
		color: var(--color-accent2);
	}

	.talk-content :global(h1),
	.talk-content :global(h2),
	.talk-content :global(h3) {
		color: var(--color-text);
		font-weight: 700;
		margin-top: 2rem;
		margin-bottom: 1rem;
	}

	.talk-content :global(h1) { font-size: 2rem; }
	.talk-content :global(h2) { font-size: 1.5rem; }
	.talk-content :global(h3) { font-size: 1.25rem; }

	.talk-content :global(p) {
		margin-bottom: 1.25rem;
	}

	.talk-content :global(strong) {
		font-weight: 700;
	}

	.talk-content :global(ul),
	.talk-content :global(ol) {
		margin-bottom: 1.25rem;
		padding-left: 1.5rem;
	}

	.talk-content :global(ul) { list-style-type: disc; }
	.talk-content :global(ol) { list-style-type: decimal; }

	.talk-content :global(li) {
		margin-bottom: 0.5rem;
	}

	.talk-content :global(hr) {
		border-color: var(--color-border);
		margin: 2rem 0;
	}

	.talk-content :global(blockquote) {
		border-left: 4px solid var(--color-accent);
		padding-left: 1rem;
		color: var(--color-muted);
		font-style: italic;
		margin-bottom: 1.25rem;
	}
</style>
