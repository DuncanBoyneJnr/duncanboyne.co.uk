<script lang="ts">
	import { Calendar, ArrowRight } from 'lucide-svelte';
	import type { Post } from '$lib/types';

	export let post: Post;

	function formatDate(dateString: string): string {
		return new Date(dateString).toLocaleDateString('en-US', {
			year: 'numeric',
			month: 'long',
			day: 'numeric'
		});
	}
</script>

<article class="card group">
	{#if post.featured_image}
		<div class="aspect-video overflow-hidden">
			<img
				src={post.featured_image}
				alt={post.title}
				class="w-full h-full object-cover group-hover:scale-105 transition-transform duration-300"
			/>
		</div>
	{:else}
		<div class="aspect-video bg-border flex items-center justify-center">
			<span class="text-4xl font-bold text-muted/50">DB</span>
		</div>
	{/if}

	<div class="p-6">
		<div class="flex items-center text-sm text-muted mb-3">
			<Calendar class="w-4 h-4 mr-2" />
			{#if post.published_at}
				<time datetime={post.published_at}>{formatDate(post.published_at)}</time>
			{:else}
				<span>Draft</span>
			{/if}
		</div>

		<h3 class="text-xl font-semibold text-text mb-3 group-hover:text-accent transition-colors">
			<a href="/blog/{post.slug}" class="hover:underline">
				{post.title}
			</a>
		</h3>

		{#if post.excerpt}
			<p class="text-muted mb-4 line-clamp-3">
				{post.excerpt}
			</p>
		{/if}

		<a
			href="/blog/{post.slug}"
			class="inline-flex items-center text-accent font-medium hover:underline"
		>
			Read more
			<ArrowRight class="w-4 h-4 ml-1" />
		</a>
	</div>
</article>
