<script lang="ts">
	import { onMount, tick } from 'svelte';
	import { Calendar, MapPin, ExternalLink, Mic, Users, ArrowRight, FileText } from 'lucide-svelte';
	import type { Event } from '$lib/types';

	export let event: Event;
	export let isPast = false;

	function formatDate(dateString: string): string {
		return new Date(dateString).toLocaleDateString('en-GB', {
			weekday: 'short',
			day: 'numeric',
			month: 'short',
			year: 'numeric'
		});
	}

	function formatTime(dateString: string): string {
		return new Date(dateString).toLocaleTimeString('en-GB', {
			hour: '2-digit',
			minute: '2-digit'
		});
	}

	let expanded = false;
	let isTruncated = false;
	let descriptionEl: HTMLParagraphElement;

	$: isSpeaking = event.event_type === 'Speaking';
	$: isOrganizing = event.event_type === 'Organizing';

	onMount(async () => {
		await tick();
		if (descriptionEl) {
			isTruncated = descriptionEl.scrollHeight > descriptionEl.clientHeight;
		}
	});
</script>

<article class="group h-full">
	<div class="card h-full flex flex-col overflow-hidden transition-all duration-300 group-hover:shadow-lg group-hover:border-accent/50 group-hover:-translate-y-1 {isPast ? 'opacity-75' : ''}">
		<div class="p-5 flex flex-col flex-1">
			<!-- Badge Row -->
			<div class="flex items-center justify-between mb-4">
				<span class="inline-flex items-center gap-1.5 px-3 py-1.5 text-xs font-semibold rounded-full {isSpeaking
					? 'bg-info/15 text-info'
					: isOrganizing
						? 'bg-accent/15 text-accent'
						: 'bg-border text-muted'}">
					{#if isSpeaking}
						<Mic class="w-3.5 h-3.5" aria-hidden="true" />
						Speaking
					{:else if isOrganizing}
						<Users class="w-3.5 h-3.5" aria-hidden="true" />
						Organizing
					{:else}
						Event
					{/if}
				</span>
				{#if isPast}
					<span class="px-2 py-1 text-xs font-medium rounded bg-border text-muted">
						Past
					</span>
				{/if}
			</div>

			<!-- Date & Time -->
			<div class="flex items-center text-sm text-accent font-medium mb-2">
				<Calendar class="w-4 h-4 mr-2" aria-hidden="true" />
				<span>{formatDate(event.event_date)} · {formatTime(event.event_date)}</span>
			</div>

			<!-- Title -->
			<h3 class="text-xl font-semibold text-text mb-2 group-hover:text-accent transition-colors">
				{event.title}
			</h3>

			<!-- Description -->
			{#if event.description}
				{#if isTruncated || expanded}
					<button
						class="text-left w-full mb-4 cursor-pointer focus:outline-none focus:ring-2 focus:ring-accent rounded"
						on:click|stopPropagation={() => expanded = !expanded}
						aria-expanded={expanded}
					>
						<p class="text-muted text-sm {expanded ? '' : 'line-clamp-2'}">
							{event.description}
						</p>
						<span class="text-accent text-xs font-medium mt-1 inline-block hover:underline">
							{expanded ? 'Show less' : 'Read more'}
						</span>
					</button>
				{:else}
					<p bind:this={descriptionEl} class="text-muted text-sm mb-4 line-clamp-2">
						{event.description}
					</p>
				{/if}
			{/if}

			<!-- Talk Link -->
			{#if isSpeaking && event.talk_slug}
				<a
					href="/talks/{event.talk_slug}"
					class="inline-flex items-center text-sm text-accent font-medium hover:underline mb-4 focus:outline-none focus:ring-2 focus:ring-accent rounded"
				>
					View full talk details
					<ArrowRight class="w-4 h-4 ml-1" aria-hidden="true" />
				</a>
			{/if}

			<!-- Slide Deck -->
			{#if event.slide_deck_url}
				<a
					href={event.slide_deck_url}
					target="_blank"
					rel="noopener noreferrer"
					class="inline-flex items-center text-sm text-accent font-medium hover:underline mb-4 focus:outline-none focus:ring-2 focus:ring-accent rounded"
				>
					<FileText class="w-4 h-4 mr-1" aria-hidden="true" />
					View Slide Deck
					<ExternalLink class="w-3 h-3 ml-1" aria-hidden="true" />
				</a>
			{/if}

			<!-- Location -->
			{#if event.location}
				<div class="flex items-center text-sm text-muted mb-4">
					<MapPin class="w-4 h-4 mr-2 flex-shrink-0" aria-hidden="true" />
					<span class="line-clamp-1">{event.location}</span>
				</div>
			{/if}

			<!-- CTA Button -->
			{#if event.event_url}
				<a
					href={event.event_url}
					target="_blank"
					rel="noopener noreferrer"
					class="inline-flex items-center justify-center w-full px-4 py-2.5 bg-accent text-[#1F1F1F] font-medium rounded-lg hover:bg-accent2 transition-colors text-sm mt-auto"
				>
					{#if isPast}
						View Event
					{:else if isOrganizing}
						Register Now
					{:else}
						View Details
					{/if}
					<ExternalLink class="w-4 h-4 ml-2" aria-hidden="true" />
				</a>
			{/if}
		</div>
	</div>
</article>
