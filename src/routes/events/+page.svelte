<script lang="ts">
	import { onMount } from 'svelte';
	import EventCard from '$lib/components/EventCard.svelte';
	import { getEvents } from '$lib/supabase';
	import type { Event } from '$lib/types';

	let upcomingEvents: Event[] = [];
	let pastEvents: Event[] = [];
	let loading = true;
	let error: string | null = null;

	onMount(async () => {
		try {
			const [upcoming, past] = await Promise.all([
				getEvents(true),
				getEvents(false)
			]);
			upcomingEvents = upcoming || [];
			pastEvents = past || [];
		} catch (e) {
			error = 'Failed to load events. Please try again later.';
			console.error(e);
		} finally {
			loading = false;
		}
	});
</script>

<svelte:head>
	<title>Events - Duncan Boyne</title>
	<meta name="description" content="Upcoming speaking engagements, workshops, and webinars by Duncan Boyne." />
</svelte:head>

<section class="py-16">
	<div class="container-custom">
		<div class="text-center mb-12">
			<h1 class="text-4xl md:text-5xl font-bold text-text mb-4">Events</h1>
			<p class="text-lg text-muted max-w-2xl mx-auto">
				Speaking engagements, workshops, webinars, and community events.
			</p>
		</div>

		{#if loading}
			<div class="space-y-8">
				<div>
					<h2 class="text-2xl font-bold text-text mb-6">Upcoming Events</h2>
					<div class="grid md:grid-cols-2 gap-6 grid-equal-height">
						{#each [1, 2] as _}
							<div class="card animate-pulse p-6 space-y-3">
								<div class="h-6 bg-border rounded w-1/4" />
								<div class="h-8 bg-border rounded w-3/4" />
								<div class="h-4 bg-border rounded" />
								<div class="h-4 bg-border rounded w-1/2" />
							</div>
						{/each}
					</div>
				</div>
			</div>
		{:else if error}
			<p class="text-center text-muted py-12">{error}</p>
		{:else}
			<!-- Upcoming Events -->
			<div class="mb-16">
				<h2 class="text-2xl font-bold text-text mb-6">Upcoming Events</h2>
				{#if upcomingEvents.length === 0}
					<div class="text-center py-8 bg-surface rounded-xl border border-border">
						<p class="text-muted">No upcoming events at the moment.</p>
						<p class="text-muted/70 text-sm mt-2">Check back soon for new events!</p>
					</div>
				{:else}
					<div class="grid md:grid-cols-2 gap-6 grid-equal-height">
						{#each upcomingEvents as event}
							<EventCard {event} />
						{/each}
					</div>
				{/if}
			</div>

			<!-- Past Events -->
			{#if pastEvents.length > 0}
				<div>
					<h2 class="text-2xl font-bold text-text mb-6">Past Events</h2>
					<div class="grid md:grid-cols-2 gap-6 grid-equal-height">
						{#each pastEvents as event}
							<EventCard {event} isPast={true} />
						{/each}
					</div>
				</div>
			{/if}
		{/if}
	</div>
</section>
