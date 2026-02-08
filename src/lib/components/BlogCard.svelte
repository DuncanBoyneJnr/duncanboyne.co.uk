<script lang="ts">
	import { Calendar, ArrowRight } from 'lucide-svelte';
	import type { Post } from '$lib/types';

	export let post: Post;

	const tagImages: Record<string, string> = {
		'#EoEPPS': '/eoepps-logo.png',
		'#NPPUG': '/nppug-logo.png',
		'#MCRDataHive': '/mcr-data-hive.png'
	};

	function getTagImage(content: string): string | null {
		for (const [tag, image] of Object.entries(tagImages)) {
			if (content.includes(tag)) return image;
		}
		return null;
	}

	$: cardImage = post.featured_image || (post.content ? getTagImage(post.content) : null);

	function formatDate(dateString: string): string {
		return new Date(dateString).toLocaleDateString('en-GB', {
			day: 'numeric',
			month: 'short',
			year: 'numeric'
		});
	}
</script>

<article class="group cursor-pointer">
	<a href="/blog/{post.slug}" class="block focus:outline-none focus:ring-2 focus:ring-accent focus:ring-offset-2 focus:ring-offset-bg rounded-xl">
		<div class="card overflow-hidden transition-all duration-300 group-hover:shadow-lg group-hover:border-accent/50 group-hover:-translate-y-1">
			{#if cardImage}
				<div class="aspect-video overflow-hidden bg-gradient-to-br from-accent/20 to-accent2/20 flex items-center justify-center">
					<img
						src={cardImage}
						alt={post.title}
						class="{post.featured_image ? 'w-full h-full object-cover transition-transform duration-300 group-hover:scale-105' : 'w-auto h-3/4 object-contain'}"
					/>
				</div>
			{:else}
				<div class="aspect-video bg-gradient-to-br from-accent/20 to-accent2/20 flex items-center justify-center">
					<span class="text-4xl font-bold text-accent/30">DB</span>
				</div>
			{/if}

			<div class="p-5">
				{#if post.published_at}
					<div class="flex items-center text-sm text-muted mb-3">
						<Calendar class="w-4 h-4 mr-2" aria-hidden="true" />
						<time datetime={post.published_at}>{formatDate(post.published_at)}</time>
					</div>
				{/if}

				<h3 class="text-lg font-semibold text-text mb-2 group-hover:text-accent transition-colors line-clamp-2">
					{post.title}
				</h3>

				{#if post.excerpt}
					<p class="text-muted text-sm mb-4 line-clamp-2">
						{post.excerpt}
					</p>
				{/if}

				<span class="inline-flex items-center text-accent font-medium text-sm group-hover:underline">
					Read more
					<ArrowRight class="w-4 h-4 ml-1 transition-transform group-hover:translate-x-1" aria-hidden="true" />
				</span>
			</div>
		</div>
	</a>
</article>
