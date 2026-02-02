<script lang="ts">
	import { Calendar, MapPin, ExternalLink, Mic, Users } from 'lucide-svelte';
	import type { Event } from '$lib/types';

	export let event: Event;
	export let isPast = false;

	function formatDate(dateString: string): string {
		return new Date(dateString).toLocaleDateString('en-US', {
			weekday: 'long',
			year: 'numeric',
			month: 'long',
			day: 'numeric'
		});
	}

	function formatTime(dateString: string): string {
		return new Date(dateString).toLocaleTimeString('en-US', {
			hour: 'numeric',
			minute: '2-digit'
		});
	}

	$: isSpeaking = event.event_type === 'Speaking';
	$: isOrganizing = event.event_type === 'Organizing';
</script>

<article class="card {isPast ? 'opacity-75' : ''}">
	<div class="p-6">
		<div class="flex items-start justify-between mb-4">
			<span class="px-3 py-1 text-xs font-medium rounded-full inline-flex items-center gap-1.5 {isSpeaking
				? 'bg-info/10 text-info'
				: isOrganizing
					? 'bg-accent/10 text-accent'
					: 'bg-border text-muted'}">
				{#if isSpeaking}
					<Mic class="w-3 h-3" />
				{:else if isOrganizing}
					<Users class="w-3 h-3" />
				{/if}
				{event.event_type || 'Event'}
			</span>
			{#if isPast}
				<span class="px-3 py-1 text-xs font-medium rounded-full bg-border text-muted">
					Past Event
				</span>
			{/if}
		</div>

		<h3 class="text-xl font-semibold text-text mb-3">
			{event.title}
		</h3>

		{#if event.description}
			<p class="text-muted mb-4">
				{event.description}
			</p>
		{/if}

		<div class="space-y-2 mb-4">
			<div class="flex items-center text-sm text-muted">
				<Calendar class="w-4 h-4 mr-2 flex-shrink-0" />
				<span>{formatDate(event.event_date)} at {formatTime(event.event_date)}</span>
			</div>
			{#if event.location}
				<div class="flex items-center text-sm text-muted">
					<MapPin class="w-4 h-4 mr-2 flex-shrink-0" />
					<span>{event.location}</span>
				</div>
			{/if}
		</div>

		{#if event.event_url}
			<a
				href={event.event_url}
				target="_blank"
				rel="noopener noreferrer"
				class="btn-primary text-sm"
			>
				{#if isPast}
					View Event
				{:else if isOrganizing}
					Register Now
				{:else}
					View Details
				{/if}
				<ExternalLink class="w-4 h-4 ml-2" />
			</a>
		{/if}
	</div>
</article>
