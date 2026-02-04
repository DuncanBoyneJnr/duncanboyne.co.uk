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
			<p class="text-lg text-muted italic">
				Most dashboards don't fail because the data is wrong.<br />
				They fail because nobody wants to open them.
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
					<h2 class="text-2xl font-bold text-text mb-4">I'm Duncan, and I spend my time trying to fix that.</h2>
					<div class="space-y-4 text-muted">
						<p>
							Professionally, I work with Power BI and the Microsoft Power Platform, helping teams turn messy data, unclear requirements, and "technically correct" dashboards into things people actually use. I sit in that middle space between business and tech, translating intent into something usable, human, and honest.
						</p>
						<p class="font-semibold text-text">But that's not the whole story.</p>
						<p>
							I'm a 90s kid who still adores Pokemon, raised on a Game Boy and the original PlayStation, and I've never really stopped being a gamer. Games were probably my first lesson in systems, feedback loops, and why good design matters, even if I didn't have the language for it at the time.
						</p>
						<p>
							I'm a dad to two brilliant young humans (boys really, 11 and 8), who constantly remind me that curiosity beats confidence and that "why?" is usually the most important question in the room. Our household is completed by Bella, a wonderfully scatty three year old Border Collie who has absolutely no respect for meetings, deadlines, or personal space.
						</p>
						<p>
							When I'm not working or parenting, you'll usually find me reading fantasy, tinkering with side projects, or disappearing down a rabbit hole because something caught my interest and refused to let go. I read to escape, to learn, and occasionally to justify buying more books when the shelf is already full.
						</p>
						<p>
							I'm AuDHD and proud. It shapes how I think, how I work, and how I show up. It's the reason I can hyperfocus on a problem until it clicks, why I care deeply about accessibility and inclusion, and why I believe clarity is kindness, especially in data and design.
						</p>
						<p>
							Community is a huge part of my life. I founded the Norfolk Power Platform User Group and I founded the East of England Power Platform Summit. EoEPPS is very much my baby, built from the ground up to create a space that is welcoming, practical, and human. Community changed my career, so now I invest a lot of time and energy into building the kind of spaces I wish I'd had earlier.
						</p>
						<p>
							I write, speak, and build in public. Sometimes that's deep Power BI content, sometimes it's design, accessibility, or ethics, and sometimes it's just being honest about what didn't work and why. I'm far more interested in clarity and usefulness than polish or perfection.
						</p>
						<p>
							If you're here for Power BI, human-centred design, community, gaming analogies, fantasy references, or slightly chaotic but well-intentioned tech content, you're in the right place.
						</p>
						<p class="font-semibold text-text">
							And if nothing else, at least now you know there's a real human behind the dashboards.
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
