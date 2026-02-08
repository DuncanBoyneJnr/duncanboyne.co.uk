<script lang="ts">
	import { Calendar, MapPin, Users, Target, Sparkles, ExternalLink, Linkedin, Database, Cpu } from 'lucide-svelte';

	const audiences = [
		'Data Engineers',
		'BI Analysts',
		'Data Scientists',
		'AI Practitioners',
		'Career Switchers',
		'Students & Newcomers'
	];

	const highlights = [
		{
			icon: Calendar,
			title: 'Community Day',
			description: 'Saturday 14th November 2026'
		},
		{
			icon: MapPin,
			title: 'Manchester',
			description: 'Copthorne Hotel, Salford Quays'
		},
		{
			icon: Users,
			title: 'Free Admission',
			description: 'Volunteer-led community event'
		},
		{
			icon: Target,
			title: 'Two Tracks',
			description: 'Practical, real-world sessions'
		}
	];

	const topics = [
		'Microsoft Fabric',
		'Power BI',
		'Azure SQL',
		'AI & Copilot',
		'Data Engineering',
		'Analytics',
		'Architecture Patterns',
		'Career Development'
	];
</script>

<svelte:head>
	<title>Manchester Data Hive - Duncan Boyne</title>
	<meta name="description" content="Manchester Data Hive - a free, volunteer-led community day for data and AI professionals, co-founded by Duncan Boyne. Learn. Collaborate. Elevate." />
</svelte:head>

<section class="py-16">
	<div class="container-custom">
		<!-- Header -->
		<div class="max-w-4xl mx-auto text-center mb-16">
			<div class="inline-flex items-center gap-2 px-4 py-2 bg-accent/10 text-accent rounded-full text-sm font-medium mb-6">
				<Sparkles class="w-4 h-4" aria-hidden="true" />
				Co-Founded by Duncan Boyne
			</div>
			<img src="/mcr-data-hive.png" alt="Manchester Data Hive" class="w-48 h-auto mx-auto mb-6" />
			<h1 class="text-4xl md:text-5xl font-bold text-text mb-4">
				Manchester Data Hive
			</h1>
			<p class="text-xl text-muted mb-2">
				Learn. Collaborate. Elevate.
			</p>
			<p class="text-lg text-muted">
				A volunteer-led community day uniting professionals passionate about Microsoft's Data & AI ecosystem.
			</p>
		</div>

		<!-- Event Highlights -->
		<div class="grid sm:grid-cols-2 lg:grid-cols-4 gap-6 mb-16">
			{#each highlights as { icon: Icon, title, description }}
				<div class="card p-6 text-center">
					<div class="w-12 h-12 bg-accent/10 rounded-lg flex items-center justify-center mx-auto mb-4">
						<Icon class="w-6 h-6 text-accent" aria-hidden="true" />
					</div>
					<h3 class="font-semibold text-text mb-1">{title}</h3>
					<p class="text-sm text-muted">{description}</p>
				</div>
			{/each}
		</div>

		<!-- Why I Co-Founded It -->
		<div class="max-w-4xl mx-auto mb-16">
			<div class="card p-8 md:p-10">
				<h2 class="text-2xl font-bold text-text mb-6">Why I Co-Founded the Hive</h2>
				<div class="space-y-4 text-muted">
					<p>
						Manchester has an incredible data community, but there wasn't a dedicated, free event bringing together professionals across the full Microsoft Data & AI stack. I wanted to help change that.
					</p>
					<p>
						After seeing the energy and talent in the region, it was clear that Manchester deserved a community day where data engineers, BI analysts, data scientists, and AI practitioners could come together to share knowledge and grow.
					</p>
					<p>
						Manchester Data Hive is about making world-class data content accessible to everyone - whether you're a seasoned professional or just starting your journey into data and AI.
					</p>
				</div>
			</div>
		</div>

		<!-- What We Cover -->
		<div class="max-w-4xl mx-auto mb-16">
			<h2 class="text-2xl font-bold text-text text-center mb-8">What We Cover</h2>
			<div class="flex flex-wrap justify-center gap-3">
				{#each topics as topic}
					<span class="px-4 py-2 bg-surface border border-border text-muted rounded-lg text-sm font-medium">
						{topic}
					</span>
				{/each}
			</div>
		</div>

		<!-- Who It's For -->
		<div class="max-w-4xl mx-auto mb-16">
			<h2 class="text-2xl font-bold text-text text-center mb-8">Who Is This For?</h2>
			<div class="flex flex-wrap justify-center gap-3">
				{#each audiences as audience}
					<span class="px-4 py-2 bg-surface border border-border text-muted rounded-lg text-sm font-medium">
						{audience}
					</span>
				{/each}
			</div>
			<p class="text-center text-muted mt-6 max-w-2xl mx-auto">
				Whether you're a seasoned data engineer, a BI analyst looking to level up, or just curious about what AI means for your career - this event is for you.
			</p>
		</div>

		<!-- Our Mission -->
		<div class="max-w-4xl mx-auto mb-16">
			<h2 class="text-2xl font-bold text-text text-center mb-8">Our Mission</h2>
			<div class="grid md:grid-cols-3 gap-6">
				<div class="card p-6 text-center">
					<div class="w-12 h-12 bg-accent/10 rounded-lg flex items-center justify-center mx-auto mb-4">
						<Database class="w-6 h-6 text-accent" aria-hidden="true" />
					</div>
					<h3 class="font-semibold text-text mb-2">Learn</h3>
					<p class="text-sm text-muted">Practical, real-world sessions from regional practitioners covering tooling and architectural patterns.</p>
				</div>
				<div class="card p-6 text-center">
					<div class="w-12 h-12 bg-accent/10 rounded-lg flex items-center justify-center mx-auto mb-4">
						<Users class="w-6 h-6 text-accent" aria-hidden="true" />
					</div>
					<h3 class="font-semibold text-text mb-2">Collaborate</h3>
					<p class="text-sm text-muted">Network with fellow professionals, hiring managers, and community leaders across the data ecosystem.</p>
				</div>
				<div class="card p-6 text-center">
					<div class="w-12 h-12 bg-accent/10 rounded-lg flex items-center justify-center mx-auto mb-4">
						<Cpu class="w-6 h-6 text-accent" aria-hidden="true" />
					</div>
					<h3 class="font-semibold text-text mb-2">Elevate</h3>
					<p class="text-sm text-muted">Walk away with practical takeaways you can apply immediately and connections that accelerate your career.</p>
				</div>
			</div>
		</div>

		<!-- CTA -->
		<div class="max-w-4xl mx-auto">
			<div class="card p-8 text-center bg-gradient-to-br from-accent/5 to-accent2/5 border-accent/20">
				<Sparkles class="w-12 h-12 text-accent mx-auto mb-4" aria-hidden="true" />
				<h2 class="text-2xl font-bold text-text mb-2">Join Us in November 2026</h2>
				<p class="text-muted mb-6 max-w-xl mx-auto">
					Visit the official website for the latest updates, session announcements, and registration details.
				</p>
				<div class="flex flex-col sm:flex-row gap-4 justify-center">
					<a
						href="https://www.manchesterdatahive.co.uk"
						target="_blank"
						rel="noopener noreferrer"
						class="btn-primary"
					>
						Visit Official Website
						<ExternalLink class="w-4 h-4 ml-2" aria-hidden="true" />
					</a>
					<a
						href="https://www.linkedin.com/company/manchester-data-hive/"
						target="_blank"
						rel="noopener noreferrer"
						class="btn-secondary"
					>
						<Linkedin class="w-4 h-4 mr-2" aria-hidden="true" />
						Follow on LinkedIn
					</a>
				</div>
			</div>
		</div>
	</div>
</section>
