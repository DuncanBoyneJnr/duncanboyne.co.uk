<script lang="ts">
	import { Mic, Users, BarChart3, Sparkles, ExternalLink } from 'lucide-svelte';

	const skills = [
		'Microsoft Power BI',
		'DAX & Power Query',
		'SQL',
		'Microsoft Power Apps',
		'Microsoft Power Automate',
		'Dataverse',
		'Dynamics 365',
		'Data Modeling',
		'ERP Integration (Sage 200)',
		'Dashboard Design'
	];

	const highlights = [
		{
			icon: BarChart3,
			title: 'Power BI Consultant',
			description: 'Currently at CPiO, turning complex data into clear, actionable insights'
		},
		{
			icon: Mic,
			title: 'International Speaker',
			description: 'Speaking at conferences and events across the UK and Europe'
		},
		{
			icon: Users,
			title: 'Community Leader',
			description: 'Founder of Norfolk Power Platform User Group'
		},
		{
			icon: Sparkles,
			title: 'Conference Founder',
			description: 'Created the East of England Power Platform Summit'
		}
	];
</script>

<svelte:head>
	<title>About - Duncan Boyne</title>
	<meta name="description" content="Learn about Duncan Boyne, Power BI Consultant at CPiO, International Speaker, and Founder of Norfolk Power Platform User Group." />
</svelte:head>

<section class="py-16">
	<div class="container-custom">
		<!-- Header -->
		<div class="max-w-4xl mx-auto text-center mb-16">
			<h1 class="text-4xl md:text-5xl font-bold text-text mb-4">About Me</h1>
			<p class="text-lg text-muted">
				The Power BI Kinda Guy
			</p>
		</div>

		<!-- Bio Section -->
		<div class="max-w-4xl mx-auto mb-16">
			<div class="flex flex-col md:flex-row gap-12 items-start">
				<!-- Profile Image -->
				<div class="flex-shrink-0 mx-auto md:mx-0">
					<div class="w-48 h-48 rounded-2xl bg-gradient-to-br from-accent to-accent2 p-1">
						<div class="w-full h-full rounded-2xl bg-surface flex items-center justify-center overflow-hidden">
							<img src="/profile.jpg" alt="Duncan Boyne" class="w-full h-full object-cover" />
						</div>
					</div>
				</div>

				<!-- Bio Content -->
				<div class="flex-1">
					<h2 class="text-2xl font-bold text-text mb-4">Hi, I'm Duncan</h2>
					<div class="space-y-4 text-muted">
						<p>
							I'm a Power BI Consultant at CPiO, helping businesses turn messy, scattered data into
							something meaningful (and dare I say it, actually enjoyable to look at).
						</p>
						<p>
							My focus? Bringing clarity through clean data models, impactful visuals, and
							well-thought-out reporting. Whether it's integrating Power BI with ERP systems like
							Sage 200 or building tailored dashboards that answer the real business questions,
							I make data work for people, not the other way around.
						</p>
						<p>
							Before joining CPiO, I led application and data initiatives at Spectrum Control,
							unifying ERP systems, building Power Platform solutions, and making sure technology
							genuinely improved day-to-day operations.
						</p>
						<p>
							I'm passionate about the Microsoft ecosystem: Power BI, Power Automate, Power Apps,
							Dataverse and the possibilities that come when they all click together.
						</p>
						<p>
							If you're into transforming complex processes into elegant, automated systems or
							just love talking data storytelling, we'll probably get along.
						</p>
					</div>
				</div>
			</div>
		</div>

		<!-- Highlights -->
		<div class="mb-16">
			<h2 class="text-2xl font-bold text-text text-center mb-8">What I Do</h2>
			<div class="grid sm:grid-cols-2 lg:grid-cols-4 gap-6">
				{#each highlights as { icon: Icon, title, description }}
					<div class="card p-6 text-center transition-all duration-300 hover:-translate-y-1 hover:border-accent/50">
						<div class="w-12 h-12 bg-accent/10 rounded-lg flex items-center justify-center mx-auto mb-4">
							<Icon class="w-6 h-6 text-accent" />
						</div>
						<h3 class="font-semibold text-text mb-2">{title}</h3>
						<p class="text-sm text-muted">{description}</p>
					</div>
				{/each}
			</div>
		</div>

		<!-- Skills -->
		<div class="max-w-4xl mx-auto mb-16">
			<h2 class="text-2xl font-bold text-text text-center mb-8">Skills & Expertise</h2>
			<div class="flex flex-wrap justify-center gap-3">
				{#each skills as skill}
					<span class="px-4 py-2 bg-surface border border-border text-muted rounded-lg text-sm font-medium hover:border-accent/50 transition-colors">
						{skill}
					</span>
				{/each}
			</div>
		</div>

		<!-- Speaking / Sessionize CTA -->
		<div class="max-w-4xl mx-auto">
			<div class="card p-8 text-center bg-gradient-to-br from-accent/5 to-accent2/5 border-accent/20">
				<Mic class="w-12 h-12 text-accent mx-auto mb-4" />
				<h2 class="text-2xl font-bold text-text mb-2">Want Me to Speak at Your Event?</h2>
				<p class="text-muted mb-6 max-w-xl mx-auto">
					I speak at conferences, user groups, and community events about Power BI,
					the Power Platform, and data storytelling. Check out my sessions and get in touch.
				</p>
				<a
					href="https://sessionize.com/duncan-boyne"
					target="_blank"
					rel="noopener noreferrer"
					class="btn-primary"
				>
					View My Sessionize Profile
					<ExternalLink class="w-4 h-4 ml-2" />
				</a>
			</div>
		</div>
	</div>
</section>
