<script lang="ts">
	import { Mic, ArrowRight } from 'lucide-svelte';
	import type { Talk } from '$lib/types';

	export let talk: Talk;
</script>

<article class="group cursor-pointer">
	<a href="/talks/{talk.slug}" class="block focus:outline-none focus:ring-2 focus:ring-accent focus:ring-offset-2 focus:ring-offset-bg rounded-xl">
		<div class="card overflow-hidden transition-all duration-300 group-hover:shadow-lg group-hover:border-accent/50 group-hover:-translate-y-1">
			<div class="aspect-video bg-gradient-to-br from-info/20 to-accent/20 flex items-center justify-center">
				<Mic class="w-12 h-12 text-info/40" aria-hidden="true" />
			</div>

			<div class="p-5">
				<h3 class="text-lg font-semibold text-text mb-2 group-hover:text-accent transition-colors line-clamp-2">
					{talk.title}
				</h3>

				{#if talk.excerpt}
					<p class="text-muted text-sm mb-4 line-clamp-2">
						{talk.excerpt}
					</p>
				{/if}

				<span class="inline-flex items-center text-accent font-medium text-sm group-hover:underline">
					Read more<span class="sr-only"> about {talk.title}</span>
					<ArrowRight class="w-4 h-4 ml-1 transition-transform group-hover:translate-x-1" aria-hidden="true" />
				</span>
			</div>
		</div>
	</a>
</article>
