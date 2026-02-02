<script lang="ts">
	import { Calendar, MapPin, ExternalLink, Mic, Users } from 'lucide-svelte';
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

	$: isSpeaking = event.event_type === 'Speaking';
	$: isOrganizing = event.event_type === 'Organizing';
</script>

<article class="group">
	<div class="card overflow-hidden transition-all duration-300 group-hover:shadow-lg group-hover:border-accent/50 group-hover:-translate-y-1 {isPast ? 'opacity-60' : ''}">
		<div class="p-5">
			<!-- Badge Row -->
			<div class="flex items-center justify-between mb-4">
				<span class="inline-flex items-center gap-1.5 px-3 py-1.5 text-xs font-semibold rounded-full {isSpeaking
					? 'bg-info/15 text-info'
					: isOrganizing
						? 'bg-accent/15 text-accent'
						: 'bg-border text-muted'}">
					{#if isSpeaking}
						<Mic class="w-3.5 h-3.5" />
						Speaking
					{:else if isOrganizing}
						<Users class="w-3.5 h-3.5" />
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
				<Calendar class="w-4 h-4 mr-2" />
				<span>{formatDate(event.event_date)} · {formatTime(event.event_date)}</span>
			</div>

			<!-- Title -->
			<h3 class="text-xl font-semibold text-text mb-2 group-hover:text-accent transition-colors">
				{event.title}
			</h3>

			<!-- Description -->
			{#if event.description}
				<p class="text-muted text-sm mb-4 line-clamp-2">
					{event.description}
				</p>
			{/if}

			<!-- Location -->
			{#if event.location}
				<div class="flex items-center text-sm text-muted mb-4">
					<MapPin class="w-4 h-4 mr-2 flex-shrink-0" />
					<span class="line-clamp-1">{event.location}</span>
				</div>
			{/if}

			<!-- CTA Button -->
			{#if event.event_url}
				<a
					href={event.event_url}
					target="_blank"
					rel="noopener noreferrer"
					class="inline-flex items-center justify-center w-full px-4 py-2.5 bg-accent text-[#1F1F1F] font-medium rounded-lg hover:bg-accent2 transition-colors text-sm"
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
	</div>
</article>
