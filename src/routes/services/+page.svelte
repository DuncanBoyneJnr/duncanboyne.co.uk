<script lang="ts">
	import { BarChart3, Zap, Database, ArrowRight, CheckCircle, ExternalLink, X } from 'lucide-svelte';
	import { fly, fade } from 'svelte/transition';
	import { cubicOut } from 'svelte/easing';

	const services = [
		{
			number: '01',
			icon: BarChart3,
			title: 'Power BI & Data Visualisation',
			tagline: 'Reports people actually open.',
			description:
				'Most dashboards tell you something happened. Good ones tell you what to do about it. I build reports and dashboards that are clear, fast, and built around the decisions your team actually needs to make.',
			detail:
				'I work across the full stack — data modelling, DAX, Power Query, and visual design — and I know how to pull data from the systems your business already runs on.',
			bullets: [
				'Financial reporting: P&L, cash flow, variance analysis',
				'Manufacturing & operations KPIs',
				'ERP integration: Dynamics 365, Epicor, InFor, Sage',
				'Data modelling, DAX, Power Query',
				'Report design with accessibility in mind'
			]
		},
		{
			number: '02',
			icon: Zap,
			title: 'Automation',
			tagline: 'Kill the spreadsheet shuffle.',
			description:
				"If your team is copying data between systems, chasing approvals over email, or running the same manual process every Monday morning — that's time and money on the floor.",
			detail:
				'I build Power Automate flows and connected workflows that reduce manual effort, surface errors earlier, and free your people up for work that actually requires a human.',
			bullets: [
				'Power Automate flows and approvals',
				'Connecting ERP, CRM, and reporting systems',
				'Reducing copy-paste and manual data entry',
				'Alerting and exception handling',
				'Power Apps for lightweight data capture'
			]
		},
		{
			number: '03',
			icon: Database,
			title: 'AI Readiness',
			tagline: 'Get your foundations right before AI gets involved.',
			description:
				"AI is only as good as the data underneath it. Before you invest in AI tooling, you need data that's clean, connected, governed, and trustworthy. Most organisations aren't there yet — and that's not a criticism, it's just where most organisations are.",
			detail:
				'I help teams understand where their data quality gaps are, how their data flows, and what needs to be in place before AI adds value rather than amplifying existing problems.',
			bullets: [
				'Data quality and governance assessment',
				'Understanding your current data landscape',
				'Identifying gaps before AI investment',
				'Practical, honest roadmaps — not vendor pitch decks',
				'Finance and manufacturing data contexts'
			]
		}
	];

	const industries = ['Financial Services', 'Manufacturing', 'Distribution & Logistics', 'Professional Services', 'SME & Mid-Market'];
	const erp = ['Dynamics 365', 'Epicor', 'InFor', 'Sage'];

	let active: typeof services[number] | null = null;

	function open(service: typeof services[number]) {
		active = service;
		document.body.style.overflow = 'hidden';
	}

	function close() {
		active = null;
		document.body.style.overflow = '';
	}

	function handleKeydown(e: KeyboardEvent) {
		if (e.key === 'Escape') close();
	}

	// Scroll-triggered reveal for tiles
	function revealTile(node: HTMLElement, delay = 0) {
		node.style.opacity = '0';
		node.style.transform = 'scale(1.04) translateY(20px)';
		const observer = new IntersectionObserver(([entry]) => {
			if (entry.isIntersecting) {
				setTimeout(() => {
					node.style.transition = 'opacity 0.6s ease, transform 0.6s cubic-bezier(0.22, 1, 0.36, 1)';
					node.style.opacity = '1';
					node.style.transform = 'scale(1) translateY(0)';
				}, delay);
				observer.disconnect();
			}
		}, { threshold: 0.1 });
		observer.observe(node);
		return { destroy() { observer.disconnect(); } };
	}
</script>

<svelte:head>
	<title>Services - Duncan Boyne</title>
	<meta name="description" content="Power BI, automation, and AI readiness consulting from Duncan Boyne. Specialising in financial and manufacturing sectors." />
</svelte:head>

<svelte:window on:keydown={handleKeydown} />

<!-- Expanded service panel -->
{#if active}
	<!-- Backdrop -->
	<div
		class="panel-backdrop"
		on:click={close}
		on:keydown={(e) => e.key === 'Enter' && close()}
		role="button"
		tabindex="-1"
		aria-label="Close panel"
		transition:fade={{ duration: 300 }}
	></div>

	<!-- Panel -->
	<div
		class="panel"
		role="dialog"
		aria-modal="true"
		aria-label={active.title}
		transition:fly={{ y: '100%', duration: 500, easing: cubicOut }}
	>
		<!-- Panel header -->
		<div class="panel-header">
			<div class="flex items-center gap-4">
				<div class="w-12 h-12 bg-accent/10 rounded-xl flex items-center justify-center flex-shrink-0">
					<svelte:component this={active.icon} class="w-6 h-6 text-accent" aria-hidden="true" />
				</div>
				<div>
					<p class="text-accent font-bold text-sm tracking-widest">{active.number}</p>
					<h2 class="text-xl md:text-2xl font-bold text-text">{active.title}</h2>
				</div>
			</div>
			<button
				on:click={close}
				class="p-2 rounded-lg text-muted hover:text-text hover:bg-border transition-colors focus:outline-none focus:ring-2 focus:ring-accent"
				aria-label="Close"
			>
				<X class="w-6 h-6" />
			</button>
		</div>

		<!-- Panel content -->
		<div class="panel-body">
			<p class="text-lg md:text-xl font-medium text-accent mb-2">{active.tagline}</p>
			<p class="text-muted leading-relaxed mb-4">{active.description}</p>
			<p class="text-muted leading-relaxed mb-8">{active.detail}</p>

			<ul class="grid sm:grid-cols-2 gap-3 mb-10">
				{#each active.bullets as bullet}
					<li class="flex items-start gap-3 text-sm text-muted">
						<CheckCircle class="w-4 h-4 text-accent flex-shrink-0 mt-0.5" aria-hidden="true" />
						{bullet}
					</li>
				{/each}
			</ul>

			<div class="flex flex-col sm:flex-row gap-4">
				<a href="/contact" class="btn-primary" on:click={close}>
					Get in Touch
					<ArrowRight class="w-4 h-4 ml-2" aria-hidden="true" />
				</a>
				<button on:click={close} class="btn-secondary">Back to Services</button>
			</div>
		</div>
	</div>
{/if}

<!-- Page header -->
<section class="py-16 md:py-24">
	<div class="container-custom">
		<div class="max-w-3xl">
			<p class="text-accent font-medium text-sm uppercase tracking-widest mb-4">Work With Me</p>
			<h1 class="text-4xl md:text-6xl font-black text-text leading-tight mb-6">
				Data that works.<br />
				<span class="text-accent">For the people using it.</span>
			</h1>
			<p class="text-lg md:text-xl text-muted max-w-2xl leading-relaxed">
				I'm a Power BI consultant with deep experience in financial and manufacturing environments.
				Whether you need better reporting, less manual work, or a clear picture of where your data
				stands before AI enters the picture — I can help.
			</p>
		</div>
	</div>
</section>

<!-- Service tiles -->
<section class="py-4 pb-20 bg-surface">
	<div class="container-custom">
		<div class="grid md:grid-cols-3 gap-6">
			{#each services as service, i}
				<button
					class="tile text-left"
					on:click={() => open(service)}
					use:revealTile={i * 120}
					aria-label="Explore {service.title}"
				>
					<span class="tile-number">{service.number}</span>

					<div class="tile-icon">
						<svelte:component this={service.icon} class="w-7 h-7 text-accent" aria-hidden="true" />
					</div>

					<h2 class="tile-title">{service.title}</h2>
					<p class="tile-tagline">{service.tagline}</p>

					<span class="tile-cta">
						Explore
						<ArrowRight class="w-4 h-4 ml-1 transition-transform group-hover:translate-x-1" aria-hidden="true" />
					</span>
				</button>
			{/each}
		</div>
	</div>
</section>

<!-- Industry & ERP -->
<section class="py-16 bg-bg">
	<div class="container-custom">
		<div class="max-w-4xl mx-auto">
			<div class="grid md:grid-cols-2 gap-12">
				<div>
					<h2 class="text-xl font-bold text-text mb-4">Industries</h2>
					<div class="flex flex-wrap gap-2">
						{#each industries as industry}
							<span class="px-3 py-1.5 bg-surface border border-border text-muted rounded-lg text-sm font-medium">{industry}</span>
						{/each}
					</div>
				</div>
				<div>
					<h2 class="text-xl font-bold text-text mb-4">ERP Systems</h2>
					<div class="flex flex-wrap gap-2">
						{#each erp as system}
							<span class="px-3 py-1.5 bg-surface border border-border text-muted rounded-lg text-sm font-medium">{system}</span>
						{/each}
					</div>
					<p class="text-sm text-muted mt-4">Experience pulling, transforming, and reporting on data from these systems using Power BI and Power Query.</p>
				</div>
			</div>
		</div>
	</div>
</section>

<!-- CTA -->
<section class="py-16 bg-surface">
	<div class="container-custom">
		<div class="max-w-3xl mx-auto card p-10 text-center bg-gradient-to-br from-accent/5 to-accent2/5 border-accent/20">
			<h2 class="text-2xl md:text-3xl font-bold text-text mb-4">Not sure if I'm the right fit?</h2>
			<p class="text-muted mb-8 max-w-xl mx-auto leading-relaxed">
				Drop me a message. I'm happy to have an honest conversation about what you're trying to solve,
				whether or not it ends up being something I can help with.
			</p>
			<div class="flex flex-col sm:flex-row gap-4 justify-center">
				<a href="/contact" class="btn-primary">
					Start a Conversation
					<ArrowRight class="w-4 h-4 ml-2" aria-hidden="true" />
				</a>
				<a href="https://linkedin.com/in/duncanboyne" target="_blank" rel="noopener noreferrer" class="btn-secondary">
					Connect on LinkedIn
					<ExternalLink class="w-4 h-4 ml-2" aria-hidden="true" />
					<span class="sr-only"> (opens in new window)</span>
				</a>
			</div>
		</div>
	</div>
</section>

<style>
	/* Tiles */
	.tile {
		position: relative;
		display: flex;
		flex-direction: column;
		background: var(--color-surface);
		border: 1px solid var(--color-border);
		border-radius: 1rem;
		padding: 2.5rem 2rem;
		cursor: pointer;
		overflow: hidden;
		transition: border-color 0.25s ease, box-shadow 0.25s ease, transform 0.25s ease;
		min-height: 320px;
	}

	.tile:hover {
		border-color: color-mix(in srgb, var(--color-accent) 50%, transparent);
		box-shadow: 0 8px 32px color-mix(in srgb, var(--color-accent) 12%, transparent);
		transform: translateY(-4px);
	}

	.tile:focus-visible {
		outline: 2px solid var(--color-accent);
		outline-offset: 2px;
	}

	/* Large background number */
	.tile-number {
		position: absolute;
		top: -0.5rem;
		right: 1rem;
		font-size: 7rem;
		font-weight: 900;
		line-height: 1;
		color: var(--color-accent);
		opacity: 0.06;
		pointer-events: none;
		user-select: none;
		font-variant-numeric: tabular-nums;
		transition: opacity 0.25s ease;
	}

	.tile:hover .tile-number {
		opacity: 0.1;
	}

	.tile-icon {
		width: 3rem;
		height: 3rem;
		background: color-mix(in srgb, var(--color-accent) 10%, transparent);
		border-radius: 0.75rem;
		display: flex;
		align-items: center;
		justify-content: center;
		margin-bottom: 1.5rem;
	}

	.tile-title {
		font-size: 1.2rem;
		font-weight: 700;
		color: var(--color-text);
		margin-bottom: 0.5rem;
		line-height: 1.3;
	}

	.tile-tagline {
		font-size: 0.9rem;
		color: var(--color-muted);
		line-height: 1.5;
		flex: 1;
	}

	.tile-cta {
		display: inline-flex;
		align-items: center;
		margin-top: 1.5rem;
		font-size: 0.875rem;
		font-weight: 600;
		color: var(--color-accent);
		gap: 0.25rem;
		transition: gap 0.2s ease;
	}

	.tile:hover .tile-cta {
		gap: 0.5rem;
	}

	/* Backdrop */
	.panel-backdrop {
		position: fixed;
		inset: 0;
		background: rgba(0, 0, 0, 0.5);
		backdrop-filter: blur(4px);
		z-index: 100;
	}

	/* Expanding panel — slides up from the bottom */
	.panel {
		position: fixed;
		bottom: 0;
		left: 0;
		right: 0;
		z-index: 101;
		background: var(--color-surface);
		border-top: 1px solid var(--color-border);
		border-radius: 1.5rem 1.5rem 0 0;
		max-height: 90dvh;
		display: flex;
		flex-direction: column;
		overflow: hidden;
	}

	.panel-header {
		display: flex;
		align-items: center;
		justify-content: space-between;
		padding: 1.5rem 2rem;
		border-bottom: 1px solid var(--color-border);
		flex-shrink: 0;
	}

	.panel-body {
		padding: 2rem 2rem 3rem;
		overflow-y: auto;
		flex: 1;
		max-width: 56rem;
		width: 100%;
		margin: 0 auto;
	}

	@media (min-width: 768px) {
		.panel {
			left: 50%;
			right: auto;
			transform: translateX(-50%);
			width: min(860px, 95vw);
			border-radius: 1.5rem 1.5rem 0 0;
		}
	}
</style>
