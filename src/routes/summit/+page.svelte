<script lang="ts">
	import { Calendar, MapPin, Users, Target, Sparkles, ExternalLink, Linkedin } from 'lucide-svelte';

	const audiences = [
		'Business Leaders',
		'Career Switchers',
		'Students',
		'End Users',
		'Citizen Developers',
		'Technical Professionals'
	];

	const highlights = [
		{
			icon: Calendar,
			title: '2-Day Event',
			description: '1st - 2nd May 2026'
		},
		{
			icon: MapPin,
			title: 'Norwich',
			description: 'East of England, UK'
		},
		{
			icon: Users,
			title: 'Free Admission',
			description: 'Community-focused event'
		},
		{
			icon: Target,
			title: 'All Skill Levels',
			description: 'From beginners to pros'
		}
	];
</script>

<svelte:head>
	<title>East of England Power Platform Summit - Duncan Boyne</title>
	<meta name="description" content="The East of England Power Platform Summit - a free, community-focused conference founded by Duncan Boyne, bringing together Power Platform enthusiasts in Norwich." />
</svelte:head>

<section class="py-16">
	<div class="container-custom">
		<!-- Header -->
		<div class="max-w-4xl mx-auto text-center mb-16">
			<div class="inline-flex items-center gap-2 px-4 py-2 bg-accent/10 text-accent rounded-full text-sm font-medium mb-6">
				<Sparkles class="w-4 h-4" aria-hidden="true" />
				Founded by Duncan Boyne
			</div>
			<h1 class="text-4xl md:text-5xl font-bold text-text mb-4">
				East of England Power Platform Summit
			</h1>
			<p class="text-xl text-muted">
				A groundbreaking community-focused event bringing together Power Platform enthusiasts, professionals, and newcomers alike.
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

		<!-- Why I Founded It -->
		<div class="max-w-4xl mx-auto mb-16">
			<div class="card p-8 md:p-10">
				<h2 class="text-2xl font-bold text-text mb-6">Why I Founded the Summit</h2>
				<div class="space-y-4 text-muted">
					<p>
						The East of England has an incredible community of Power Platform professionals, but we've never had a dedicated event to bring everyone together. I wanted to change that.
					</p>
					<p>
						After running the Norfolk Power Platform User Group and seeing the enthusiasm and talent in our region, I knew it was time to create something bigger. Something that could unite professionals, inspire newcomers, and showcase what our community can achieve.
					</p>
					<p>
						The East of England Power Platform Summit isn't just a conference - it's a statement that you don't need to travel to London or Manchester to access world-class Power Platform content. We're bringing it to Norwich.
					</p>
				</div>
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
				Whether you're just discovering the Power Platform or you're a seasoned pro, there's something for everyone at EOEPPS.
			</p>
		</div>

		<!-- What We're Trying to Achieve -->
		<div class="max-w-4xl mx-auto mb-16">
			<h2 class="text-2xl font-bold text-text text-center mb-8">Our Mission</h2>
			<div class="grid md:grid-cols-3 gap-6">
				<div class="card p-6 text-center">
					<h3 class="font-semibold text-text mb-2">Unite the Community</h3>
					<p class="text-sm text-muted">Bring together Power Platform enthusiasts from across the East of England and beyond.</p>
				</div>
				<div class="card p-6 text-center">
					<h3 class="font-semibold text-text mb-2">Share Knowledge</h3>
					<p class="text-sm text-muted">Provide high-quality sessions from experienced speakers and practitioners.</p>
				</div>
				<div class="card p-6 text-center">
					<h3 class="font-semibold text-text mb-2">Inspire Growth</h3>
					<p class="text-sm text-muted">Help attendees advance their careers and skills in the Power Platform ecosystem.</p>
				</div>
			</div>
		</div>

		<!-- CTA -->
		<div class="max-w-4xl mx-auto">
			<div class="card p-8 text-center bg-gradient-to-br from-accent/5 to-accent2/5 border-accent/20">
				<Sparkles class="w-12 h-12 text-accent mx-auto mb-4" aria-hidden="true" />
				<h2 class="text-2xl font-bold text-text mb-2">Join Us in May 2026</h2>
				<p class="text-muted mb-6 max-w-xl mx-auto">
					Registration will open soon. Visit the official website for the latest updates and announcements.
				</p>
				<div class="flex flex-col sm:flex-row gap-4 justify-center">
					<a
						href="https://www.eoepps.co.uk"
						target="_blank"
						rel="noopener noreferrer"
						class="btn-primary"
					>
						Visit Official Website
						<ExternalLink class="w-4 h-4 ml-2" aria-hidden="true" />
					</a>
					<a
						href="https://www.linkedin.com/company/eoepps/"
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
