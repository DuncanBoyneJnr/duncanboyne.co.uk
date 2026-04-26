<script lang="ts">
	import { ChevronLeft, ChevronRight } from 'lucide-svelte';

	export let images: string[];
	export let alt: string = 'Carousel slide';

	let current = 0;

	function prev() {
		current = (current - 1 + images.length) % images.length;
	}

	function next() {
		current = (current + 1) % images.length;
	}

	function goTo(index: number) {
		current = index;
	}

	function handleKey(e: KeyboardEvent) {
		if (e.key === 'ArrowLeft') prev();
		if (e.key === 'ArrowRight') next();
	}
</script>

<div
	class="carousel relative w-full rounded-xl overflow-hidden select-none"
	role="region"
	aria-label="Image carousel"
	tabindex="0"
	on:keydown={handleKey}
>
	<div class="aspect-[16/9] bg-black">
		{#each images as src, i}
			<img
				{src}
				alt="{alt} {i + 1} of {images.length}"
				class="absolute inset-0 w-full h-full object-contain transition-opacity duration-300"
				class:opacity-100={i === current}
				class:opacity-0={i !== current}
			/>
		{/each}
	</div>

	{#if images.length > 1}
		<button
			class="absolute left-2 top-1/2 -translate-y-1/2 bg-black/50 hover:bg-black/75 text-white rounded-full p-2 transition-colors"
			on:click={prev}
			aria-label="Previous slide"
		>
			<ChevronLeft class="w-5 h-5" />
		</button>

		<button
			class="absolute right-2 top-1/2 -translate-y-1/2 bg-black/50 hover:bg-black/75 text-white rounded-full p-2 transition-colors"
			on:click={next}
			aria-label="Next slide"
		>
			<ChevronRight class="w-5 h-5" />
		</button>

		<div class="absolute bottom-3 left-1/2 -translate-x-1/2 flex gap-2">
			{#each images as _, i}
				<button
					class="w-2 h-2 rounded-full transition-colors {i === current ? 'bg-white' : 'bg-white/40'}"
					on:click={() => goTo(i)}
					aria-label="Go to slide {i + 1}"
				/>
			{/each}
		</div>
	{/if}
</div>

<style>
	.carousel { position: relative; }
	.carousel .aspect-\[16\/9\] { position: relative; }
	img { position: absolute; }
</style>
