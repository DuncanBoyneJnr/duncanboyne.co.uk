<script lang="ts">
	import { onMount } from 'svelte';
	import { page } from '$app/stores';
	import { ArrowLeft, Mic, Calendar, MapPin, ExternalLink } from 'lucide-svelte';
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
								{#if event.event_url}
									<a
										href={event.event_url}
										target="_blank"
										rel="noopener noreferrer"
										class="inline-flex items-center px-4 py-2 bg-accent text-[#1F1F1F] font-medium rounded-lg hover:bg-accent2 transition-colors text-sm whitespace-nowrap"
									>
										Register
										<ExternalLink class="w-4 h-4 ml-2" />
									</a>
								{/if}
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
							<div class="card p-5 flex flex-col sm:flex-row sm:items-center gap-4 opacity-60">
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
							</div>
						{/each}
					</div>
				</div>
			{/if}
		{/if}
	</div>
</article>
