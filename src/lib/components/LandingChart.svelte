<script lang="ts">
	import { createEventDispatcher, onMount } from 'svelte';
	import { fade } from 'svelte/transition';

	const dispatch = createEventDispatcher<{ enter: void }>();

	let visible = true;
	let exiting = false;
	let barsReady = false;
	let lineReady = false;
	let labelsReady = false;
	let dotsReady = false;
	let textReady = false;
	let buttonReady = false;
	let pathEl: SVGPathElement | null = null;
	let dashLength = 1800;

	const BASELINE = 415;
	const CHART_HEIGHT = 365;
	const BAR_WIDTH = 76;

	const barDefs = [
		{ label: ['Power BI', 'Consultant'], pct: 0.48, color: '#F5A623', isDad: false, x: 140 },
		{ label: ['User Group', 'Leader'],   pct: 0.33, color: '#4A7FA5', isDad: false, x: 270 },
		{ label: ['Summit', 'Founder'],      pct: 0.62, color: '#5B9BD5', isDad: false, x: 400 },
		{ label: ['Chess', 'Nerd'],          pct: 0.38, color: '#3A4870', isDad: false, x: 530 },
		{ label: ['Book', 'Worm'],           pct: 0.27, color: '#3A3558', isDad: false, x: 660 },
		{ label: ['Writer'],                 pct: 0.70, color: '#F5A623', isDad: false, x: 790 },
		{ label: ['Dad'],                    pct: 0.87, color: '#00D4F0', isDad: true,  x: 920 },
	];

	const bars = barDefs.map((b) => ({
		...b,
		height: Math.round(b.pct * CHART_HEIGHT),
		y: BASELINE - Math.round(b.pct * CHART_HEIGHT),
	}));

	const linePoints = [
		{ x: 78,  y: 413 },
		{ x: 140, y: 378 },
		{ x: 220, y: 402 },
		{ x: 310, y: 374 },
		{ x: 400, y: 352 },
		{ x: 470, y: 362 },
		{ x: 530, y: 354 },
		{ x: 620, y: 385 },
		{ x: 680, y: 382 },
		{ x: 790, y: 200 },
		{ x: 920, y: 82 },
	];

	const dotIndices = [0, 1, 3, 4, 6, 8, 9, 10];
	const dots = dotIndices.map((i) => linePoints[i]);

	function smoothPath(pts: Array<{ x: number; y: number }>) {
		if (pts.length < 2) return '';
		let d = `M ${pts[0].x},${pts[0].y}`;
		for (let i = 1; i < pts.length; i++) {
			const p0 = pts[i - 1];
			const p1 = pts[i];
			const mx = (p0.x + p1.x) / 2;
			d += ` C ${mx},${p0.y} ${mx},${p1.y} ${p1.x},${p1.y}`;
		}
		return d;
	}

	const linePath = smoothPath(linePoints);

	onMount(() => {
		if (pathEl) {
			try {
				dashLength = pathEl.getTotalLength();
			} catch (_) {
				dashLength = 1800;
			}
		}

		setTimeout(() => { barsReady = true; }, 200);
		setTimeout(() => { labelsReady = true; }, 1050);
		setTimeout(() => { lineReady = true; }, 1250);
		setTimeout(() => { dotsReady = true; }, 2500);
		setTimeout(() => { textReady = true; }, 2800);
		setTimeout(() => { buttonReady = true; }, 3200);
	});

	function drillThrough() {
		exiting = true;
		setTimeout(() => {
			visible = false;
			dispatch('enter');
		}, 750);
	}
</script>

{#if visible}
	<div class="landing" class:exiting>
		<div class="chart-wrapper">
			<svg
				viewBox="0 0 1000 455"
				xmlns="http://www.w3.org/2000/svg"
				class="chart-svg"
				role="img"
				aria-label="Bar chart showing Duncan Boyne's multiple roles across career milestones"
			>
				<defs>
					{#each bars as bar, i}
						<linearGradient id="landing-grad-{i}" x1="0" y1="0" x2="0" y2="1">
							<stop offset="0%" stop-color={bar.color} stop-opacity="0.90" />
							<stop offset="100%" stop-color={bar.color} stop-opacity="0.45" />
						</linearGradient>
					{/each}

					<filter id="landing-line-glow" x="-10%" y="-80%" width="120%" height="260%">
						<feGaussianBlur in="SourceGraphic" stdDeviation="3" result="blur" />
						<feMerge>
							<feMergeNode in="blur" />
							<feMergeNode in="SourceGraphic" />
						</feMerge>
					</filter>

					<filter id="landing-dot-glow" x="-150%" y="-150%" width="400%" height="400%">
						<feGaussianBlur in="SourceGraphic" stdDeviation="5" result="blur" />
						<feMerge>
							<feMergeNode in="blur" />
							<feMergeNode in="SourceGraphic" />
						</feMerge>
					</filter>

					<filter id="landing-dad-glow" x="-30%" y="-5%" width="160%" height="115%">
						<feGaussianBlur in="SourceGraphic" stdDeviation="7" result="blur" />
						<feMerge>
							<feMergeNode in="blur" />
							<feMergeNode in="SourceGraphic" />
						</feMerge>
					</filter>
				</defs>

				<!-- X-axis baseline -->
				<line
					x1="60" y1={BASELINE}
					x2="972" y2={BASELINE}
					stroke="rgba(255,255,255,0.18)"
					stroke-width="1"
				/>

				<!-- Bars -->
				{#each bars as bar, i}
					<rect
						class="landing-bar"
						class:bar-animated={barsReady}
						x={bar.x - BAR_WIDTH / 2}
						y={bar.y}
						width={BAR_WIDTH}
						height={bar.height}
						fill="url(#landing-grad-{i})"
						filter={bar.isDad ? 'url(#landing-dad-glow)' : undefined}
						style="animation-delay: {i * 90}ms"
					/>
				{/each}

				<!-- Bar labels (above bars) -->
				{#if labelsReady}
					{#each bars as bar, i}
						<g class="landing-bar-label" style="--anim-delay: {i * 65}ms">
							{#each bar.label as line, j}
								<text
									x={bar.x}
									y={bar.y - 14 - (bar.label.length - 1 - j) * 19}
									text-anchor="middle"
									fill={bar.isDad
										? '#FFFFFF'
										: bar.color === '#F5A623'
										? '#F5A623'
										: '#A0C4E8'}
									font-size="13"
									font-weight="600"
									font-family="system-ui, -apple-system, sans-serif"
									letter-spacing="0.02em"
								>{line}</text>
							{/each}
						</g>
					{/each}
				{/if}

				<!-- Line chart path -->
				<path
					bind:this={pathEl}
					d={linePath}
					fill="none"
					stroke="#00C8E8"
					stroke-width="2.4"
					stroke-linecap="round"
					filter="url(#landing-line-glow)"
					style="stroke-dasharray: {dashLength}; stroke-dashoffset: {lineReady
						? 0
						: dashLength}; transition: stroke-dashoffset 1.5s cubic-bezier(0.4, 0, 0.2, 1);"
				/>

				<!-- Dots on line -->
				{#if dotsReady}
					{#each dots as dot, i}
						<circle
							class="landing-dot"
							cx={dot.x}
							cy={dot.y}
							r="4.5"
							fill="#00C8E8"
							filter="url(#landing-dot-glow)"
							style="animation-delay: {i * 70}ms"
						/>
					{/each}
				{/if}

			</svg>
		</div>

		<div class="bottom-content">
			{#if textReady}
				<p class="tagline" transition:fade={{ duration: 600 }}>
					MULTIPLE MEASURES. ONE DATA MODEL.
				</p>
			{/if}

			{#if buttonReady}
				<button
					class="drill-btn"
					on:click={drillThrough}
					transition:fade={{ duration: 600 }}
					disabled={exiting}
				>
					DRILL THROUGH
				</button>
			{/if}
		</div>
	</div>
{/if}

<style>
	.landing {
		position: fixed;
		inset: 0;
		z-index: 200;
		background: #0B0E1C;
		display: flex;
		flex-direction: column;
		align-items: center;
		justify-content: center;
		padding: 1.5rem 1rem;
		transition: transform 0.75s cubic-bezier(0.4, 0, 0.2, 1), opacity 0.6s ease;
	}

	.landing.exiting {
		transform: translateY(-100vh);
		opacity: 0;
	}

	.chart-wrapper {
		width: 100%;
		max-width: 1020px;
	}

	.chart-svg {
		width: 100%;
		height: auto;
		display: block;
	}

	/* Bar grow animation */
	.landing-bar {
		transform-box: fill-box;
		transform-origin: bottom;
		transform: scaleY(0);
	}

	.landing-bar.bar-animated {
		animation: landingGrowBar 0.75s cubic-bezier(0.34, 1.35, 0.64, 1) forwards;
	}

	@keyframes landingGrowBar {
		from { transform: scaleY(0); }
		to   { transform: scaleY(1); }
	}

	/* Bar label fade-up */
	.landing-bar-label text {
		opacity: 0;
		animation: landingFadeUp 0.45s ease var(--anim-delay, 0ms) forwards;
	}

	/* Dot pop */
	.landing-dot {
		opacity: 0;
		animation: landingDotPop 0.35s ease forwards;
	}

	@keyframes landingFadeUp {
		from { opacity: 0; transform: translateY(5px); }
		to   { opacity: 1; transform: translateY(0); }
	}

	@keyframes landingDotPop {
		from { opacity: 0; transform: scale(0.2); }
		to   { opacity: 1; transform: scale(1); }
	}

	/* Bottom area */
	.bottom-content {
		display: flex;
		flex-direction: column;
		align-items: center;
		gap: 1.25rem;
		margin-top: 0.75rem;
	}

	.tagline {
		color: #F2C811;
		font-size: clamp(0.75rem, 2.2vw, 1.1rem);
		font-weight: 700;
		letter-spacing: 0.18em;
		text-align: center;
		font-family: system-ui, -apple-system, sans-serif;
		margin: 0;
	}

	.drill-btn {
		background: transparent;
		border: 1.5px solid #00C8E8;
		color: #ffffff;
		font-size: clamp(0.75rem, 1.8vw, 0.95rem);
		font-weight: 700;
		letter-spacing: 0.22em;
		padding: 0.85rem 2.8rem;
		cursor: pointer;
		font-family: system-ui, -apple-system, sans-serif;
		border-radius: 3px;
		transition: background 0.25s, box-shadow 0.25s, border-color 0.25s;
	}

	.drill-btn:hover:not(:disabled) {
		background: rgba(0, 200, 232, 0.08);
		box-shadow: 0 0 28px rgba(0, 200, 232, 0.35), inset 0 0 12px rgba(0, 200, 232, 0.05);
	}

	.drill-btn:active:not(:disabled) {
		background: rgba(0, 200, 232, 0.15);
	}

	.drill-btn:disabled {
		cursor: default;
		opacity: 0.7;
	}
</style>
