<script lang="ts">
	import { onMount } from 'svelte';

	// Update these numbers to match your actual figures
	const stats = [
		{ value: 6,  suffix: '+', label: 'Years in Power BI' },
		{ value: 25, suffix: '+', label: 'Talks Delivered' },
		{ value: 2,  suffix: '',  label: 'Events Founded' },
		{ value: 4,  suffix: '',  label: 'ERP Systems' }
	];

	let displayed = stats.map(() => 0);
	let started = false;
	let container: HTMLElement;

	function animateCounters() {
		if (started) return;
		started = true;
		stats.forEach((stat, i) => {
			const duration = 1200;
			const steps = 40;
			const increment = stat.value / steps;
			let current = 0;
			let step = 0;
			const interval = setInterval(() => {
				step++;
				current = Math.min(Math.round(increment * step), stat.value);
				displayed[i] = current;
				if (step >= steps) clearInterval(interval);
			}, duration / steps);
		});
	}

	onMount(() => {
		const observer = new IntersectionObserver(
			(entries) => {
				if (entries[0].isIntersecting) {
					animateCounters();
					observer.disconnect();
				}
			},
			{ threshold: 0.3 }
		);
		observer.observe(container);
		return () => observer.disconnect();
	});
</script>

<div bind:this={container} class="py-10 bg-surface border-y border-border">
	<div class="container-custom">
		<div class="grid grid-cols-2 md:grid-cols-4 gap-6 md:gap-0 md:divide-x divide-border">
			{#each stats as stat, i}
				<div class="text-center px-6">
					<div class="text-3xl md:text-4xl font-black text-accent tabular-nums">
						{displayed[i]}{stat.suffix}
					</div>
					<div class="text-sm text-muted mt-1 font-medium">{stat.label}</div>
				</div>
			{/each}
		</div>
	</div>
</div>
