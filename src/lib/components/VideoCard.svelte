<script lang="ts">
	import { Play, ExternalLink } from 'lucide-svelte';
	import type { Video } from '$lib/types';

	export let video: Video;

	let showEmbed = false;

	function formatDate(dateString: string): string {
		return new Date(dateString).toLocaleDateString('en-US', {
			year: 'numeric',
			month: 'long',
			day: 'numeric'
		});
	}

	function getThumbnailUrl(youtubeId: string): string {
		return `https://img.youtube.com/vi/${youtubeId}/maxresdefault.jpg`;
	}

	function getYoutubeUrl(youtubeId: string): string {
		return `https://www.youtube.com/watch?v=${youtubeId}`;
	}
</script>

<article class="card group">
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
				class="w-full h-full object-cover"
			/>
			<button
				on:click={() => (showEmbed = true)}
				class="absolute inset-0 flex items-center justify-center bg-black/30 group-hover:bg-black/40 transition-colors"
				aria-label="Play video"
			>
				<div class="w-16 h-16 bg-accent rounded-full flex items-center justify-center transform group-hover:scale-110 transition-transform">
					<Play class="w-8 h-8 text-[#1F1F1F] fill-current ml-1" />
				</div>
			</button>
		{/if}
	</div>

	<div class="p-6">
		{#if video.published_at}
			<p class="text-sm text-muted mb-2">
				{formatDate(video.published_at)}
			</p>
		{/if}

		<h3 class="text-lg font-semibold text-text mb-2 line-clamp-2">
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
</article>
