<script lang="ts">
	import { onMount } from 'svelte';

	export let posts: number = 0;
	export let events: number = 0;
	export let talks: number = 0;
	export let books: number = 0;

	const year = new Date().getFullYear();

	const metrics = [
		{ label: 'Blog Posts',        note: 'published this year',           getValue: () => posts  },
		{ label: 'Events Hosted',     note: 'organised & attended',          getValue: () => events },
		{ label: 'Talks Given',       note: 'at conferences & user groups',  getValue: () => talks  },
		{ label: 'Books Read',        note: 'finished cover to cover',       getValue: () => books  },
		{ label: 'Exported to Excel', note: 'data model returned no results', getValue: () => null   }
	];

	let displayed = [0, 0, 0, 0];
	let sectionEl: HTMLElement;

	function animateCountUp() {
		const targets = [posts, events, talks, books];
		const duration = 1500;
		const start = performance.now();

		function ease(t: number) {
			return 1 - Math.pow(1 - t, 3);
		}

		function tick(now: number) {
			const t = ease(Math.min((now - start) / duration, 1));
			displayed = targets.map((v) => Math.round(v * t));
			if (t < 1) requestAnimationFrame(tick);
		}

		requestAnimationFrame(tick);
	}

	onMount(() => {
		const observer = new IntersectionObserver(
			(entries) => {
				if (entries[0].isIntersecting) {
					animateCountUp();
					observer.disconnect();
				}
			},
			{ threshold: 0.25 }
		);

		observer.observe(sectionEl);
		return () => observer.disconnect();
	});
</script>

<section bind:this={sectionEl} class="glance-section">
	<div class="container-custom">
		<div class="glance-header">
			<span class="year-chip">{year}</span>
			<span class="glance-title">AT A GLANCE</span>
		</div>

		<div class="kpi-grid">
			{#each metrics as metric, i}
				{@const isJoke = metric.getValue() === null}
				<div class="kpi-card" class:kpi-joke={isJoke}>
					<div class="kpi-bar" />
					<div class="kpi-label">{metric.label}</div>
					<div class="kpi-value" class:kpi-value-joke={isJoke}>
						{#if isJoke}
							N/A
						{:else}
							{displayed[i].toLocaleString()}
						{/if}
					</div>
					<div class="kpi-note">{metric.note}</div>
				</div>
			{/each}
		</div>
	</div>
</section>

<style>
	.glance-section {
		background: #0d0d0d;
		padding: 3rem 0;
		border-top: 1px solid rgba(242, 200, 17, 0.12);
		border-bottom: 1px solid rgba(242, 200, 17, 0.12);
	}

	.glance-header {
		display: flex;
		align-items: baseline;
		gap: 0.6rem;
		margin-bottom: 1.75rem;
	}

	.year-chip {
		font-size: 0.7rem;
		font-weight: 700;
		letter-spacing: 0.2em;
		color: #F2C811;
		font-family: system-ui, -apple-system, sans-serif;
	}

	.glance-title {
		font-size: 0.7rem;
		font-weight: 600;
		letter-spacing: 0.2em;
		color: rgba(255, 255, 255, 0.3);
		font-family: system-ui, -apple-system, sans-serif;
	}

	.kpi-grid {
		display: grid;
		grid-template-columns: repeat(5, 1fr);
		gap: 1px;
		background: rgba(255, 255, 255, 0.05);
		border: 1px solid rgba(255, 255, 255, 0.05);
		border-radius: 4px;
		overflow: hidden;
	}

	.kpi-card {
		background: #141414;
		padding: 1.5rem 1.25rem 1.25rem;
		display: flex;
		flex-direction: column;
		gap: 0.4rem;
		position: relative;
	}

	.kpi-bar {
		position: absolute;
		top: 0;
		left: 0;
		right: 0;
		height: 3px;
		background: #F2C811;
	}

	.kpi-joke .kpi-bar {
		background: rgba(242, 200, 17, 0.2);
	}

	.kpi-label {
		font-size: 0.65rem;
		font-weight: 600;
		letter-spacing: 0.1em;
		text-transform: uppercase;
		color: rgba(255, 255, 255, 0.4);
		font-family: system-ui, -apple-system, sans-serif;
	}

	.kpi-value {
		font-size: clamp(2rem, 3vw, 2.75rem);
		font-weight: 800;
		color: #F2C811;
		line-height: 1;
		font-family: system-ui, -apple-system, sans-serif;
		font-variant-numeric: tabular-nums;
	}

	.kpi-value-joke {
		color: rgba(242, 200, 17, 0.3);
		font-size: clamp(1.5rem, 2.2vw, 2rem);
	}

	.kpi-note {
		font-size: 0.65rem;
		color: rgba(255, 255, 255, 0.25);
		font-family: system-ui, -apple-system, sans-serif;
		line-height: 1.4;
	}

	@media (max-width: 900px) {
		.kpi-grid {
			grid-template-columns: repeat(3, 1fr);
		}
	}

	@media (max-width: 560px) {
		.kpi-grid {
			grid-template-columns: repeat(2, 1fr);
		}
	}
</style>
