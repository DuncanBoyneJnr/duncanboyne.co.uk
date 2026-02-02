<script lang="ts">
	import { Play, ExternalLink, Calendar } from 'lucide-svelte';
	import type { Video } from '$lib/types';

	export let video: Video;

	let showEmbed = false;

	function formatDate(dateString: string): string {
		return new Date(dateString).toLocaleDateString('en-GB', {
			day: 'numeric',
			month: 'short',
			year: 'numeric'
		});
	}

	function getThumbnailUrl(youtubeId: string): string {
		return `https://img.youtube.com/vi/${youtubeId}/maxresdefault.jpg`;
	}

	function getYoutubeUrl(youtubeId: string): string {
		return `https://www.youtube.com/watch?v=${youtubeId}`;
	}
</script>

<article class="group">
	<div class="card overflow-hidden transition-all duration-300 group-hover:shadow-lg group-hover:border-accent/50 group-hover:-translate-y-1">
		<div class="relative aspect-video overflow-hidden">
			{#if showEmbed}
				<iframe
					src="https://www.youtube.com/embed/{video.youtube_id}?autoplay=1"
					title={video.title}
					allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"
					allowfullscreen
					class="w-full h-full"
				/>
			{:else}
				<img
					src={getThumbnailUrl(video.youtube_id)}
					alt={video.title}
					class="w-full h-full object-cover transition-transform duration-300 group-hover:scale-105"
				/>
				<button
					on:click={() => (showEmbed = true)}
					class="absolute inset-0 flex items-center justify-center bg-black/40 group-hover:bg-black/50 transition-colors"
					aria-label="Play video"
				>
					<div class="w-16 h-16 bg-accent rounded-full flex items-center justify-center transform transition-transform group-hover:scale-110 shadow-lg">
						<Play class="w-7 h-7 text-[#1F1F1F] fill-current ml-1" />
					</div>
				</button>
			{/if}
		</div>

		<div class="p-5">
			{#if video.published_at}
				<div class="flex items-center text-sm text-muted mb-2">
					<Calendar class="w-4 h-4 mr-2" />
					<time datetime={video.published_at}>{formatDate(video.published_at)}</time>
				</div>
			{/if}

			<h3 class="text-lg font-semibold text-text mb-2 line-clamp-2 group-hover:text-accent transition-colors">
				{video.title}
			</h3>

			{#if video.description}
				<p class="text-muted text-sm mb-4 line-clamp-2">
					{video.description}
				</p>
			{/if}

			<a
				href={getYoutubeUrl(video.youtube_id)}
				target="_blank"
				rel="noopener noreferrer"
				class="inline-flex items-center text-sm text-accent font-medium hover:underline"
			>
				Watch on YouTube
				<ExternalLink class="w-4 h-4 ml-1" />
			</a>
		</div>
	</div>
</article>
