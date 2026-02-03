<script lang="ts">
	import { Calendar, MapPin, Users, Clock, Sparkles, ExternalLink, Linkedin } from 'lucide-svelte';

	const benefits = [
		{
			icon: Users,
			title: 'Network',
			description: 'Connect with local Power Platform professionals and enthusiasts'
		},
		{
			icon: Calendar,
			title: 'Learn',
			description: 'Attend sessions from experienced speakers and practitioners'
		},
		{
			icon: Sparkles,
			title: 'Grow',
			description: 'Develop your skills and advance your career'
		}
	];
</script>

<svelte:head>
	<title>Norfolk Power Platform User Group - Duncan Boyne</title>
	<meta name="description" content="The Norfolk Power Platform User Group - a community founded by Duncan Boyne for Power Platform enthusiasts in Norwich and the surrounding area." />
</svelte:head>

<section class="py-16">
	<div class="container-custom">
		<!-- Header -->
		<div class="max-w-4xl mx-auto text-center mb-16">
			<div class="inline-flex items-center gap-2 px-4 py-2 bg-accent/10 text-accent rounded-full text-sm font-medium mb-6">
				<Sparkles class="w-4 h-4" />
				Founded by Duncan Boyne
			</div>
			<h1 class="text-4xl md:text-5xl font-bold text-text mb-4">
				Norfolk Power Platform User Group
			</h1>
			<p class="text-xl text-muted">
				Bringing together Power Platform enthusiasts in Norwich and the surrounding area for learning, networking, and community.
			</p>
		</div>

		<!-- Meeting Info -->
		<div class="max-w-4xl mx-auto mb-16">
			<div class="card p-8 md:p-10 bg-gradient-to-br from-accent/5 to-accent2/5 border-accent/20">
				<h2 class="text-2xl font-bold text-text mb-6 text-center">When & Where We Meet</h2>
				<div class="grid md:grid-cols-3 gap-6">
					<div class="text-center">
						<div class="w-12 h-12 bg-accent/10 rounded-lg flex items-center justify-center mx-auto mb-3">
							<Clock class="w-6 h-6 text-accent" />
						</div>
						<h3 class="font-semibold text-text mb-1">First Thursday</h3>
						<p class="text-sm text-muted">Of most months (we skip January & August)</p>
					</div>
					<div class="text-center">
						<div class="w-12 h-12 bg-accent/10 rounded-lg flex items-center justify-center mx-auto mb-3">
							<MapPin class="w-6 h-6 text-accent" />
						</div>
						<h3 class="font-semibold text-text mb-1">Norwich Digital Hub</h3>
						<p class="text-sm text-muted">Townshend House, Norwich</p>
					</div>
					<div class="text-center">
						<div class="w-12 h-12 bg-accent/10 rounded-lg flex items-center justify-center mx-auto mb-3">
							<Users class="w-6 h-6 text-accent" />
						</div>
						<h3 class="font-semibold text-text mb-1">Mostly In Person</h3>
						<p class="text-sm text-muted">With 2 online-only events per year</p>
					</div>
				</div>
			</div>
		</div>

		<!-- Why I Founded It -->
		<div class="max-w-4xl mx-auto mb-16">
			<div class="card p-8 md:p-10">
				<h2 class="text-2xl font-bold text-text mb-6">Why I Founded the User Group</h2>
				<div class="space-y-4 text-muted">
					<p>
						When I started working with the Power Platform, I quickly realised how powerful it was - but also how isolating it could feel. Most of the community events and meetups were happening in London or other major cities, leaving those of us in Norfolk disconnected from the wider ecosystem.
					</p>
					<p>
						I founded the Norfolk Power Platform User Group to change that. I wanted to create a space where local professionals could come together, share knowledge, and support each other's growth - without having to travel hours to do it.
					</p>
					<p>
						What started as a small gathering has grown into a thriving community. Every month, we bring together developers, consultants, business analysts, and curious newcomers who all share one thing: a passion for what the Power Platform can do.
					</p>
				</div>
			</div>
		</div>

		<!-- Benefits -->
		<div class="max-w-4xl mx-auto mb-16">
			<h2 class="text-2xl font-bold text-text text-center mb-8">Why Join Us?</h2>
			<div class="grid md:grid-cols-3 gap-6">
				{#each benefits as { icon: Icon, title, description }}
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

		<!-- What to Expect -->
		<div class="max-w-4xl mx-auto mb-16">
			<h2 class="text-2xl font-bold text-text text-center mb-8">What to Expect</h2>
			<div class="card p-8">
				<ul class="space-y-4 text-muted">
					<li class="flex items-start gap-3">
						<span class="w-2 h-2 bg-accent rounded-full mt-2 flex-shrink-0"></span>
						<span><strong class="text-text">Presentations & Demos</strong> - Learn from community members and guest speakers sharing real-world experiences with Power BI, Power Apps, Power Automate, and more.</span>
					</li>
					<li class="flex items-start gap-3">
						<span class="w-2 h-2 bg-accent rounded-full mt-2 flex-shrink-0"></span>
						<span><strong class="text-text">Networking</strong> - Connect with other professionals in a relaxed, friendly environment. Whether you're looking for advice, collaboration, or just good conversation.</span>
					</li>
					<li class="flex items-start gap-3">
						<span class="w-2 h-2 bg-accent rounded-full mt-2 flex-shrink-0"></span>
						<span><strong class="text-text">Q&A Sessions</strong> - Bring your questions and challenges. Our community is always happy to help troubleshoot and share solutions.</span>
					</li>
					<li class="flex items-start gap-3">
						<span class="w-2 h-2 bg-accent rounded-full mt-2 flex-shrink-0"></span>
						<span><strong class="text-text">Welcoming Atmosphere</strong> - Whether you're a complete beginner or an MVP, everyone is welcome. No question is too basic, no topic too advanced.</span>
					</li>
				</ul>
			</div>
		</div>

		<!-- CTA -->
		<div class="max-w-4xl mx-auto">
			<div class="card p-8 text-center bg-gradient-to-br from-accent/5 to-accent2/5 border-accent/20">
				<Calendar class="w-12 h-12 text-accent mx-auto mb-4" />
				<h2 class="text-2xl font-bold text-text mb-2">Join Our Next Meetup</h2>
				<p class="text-muted mb-6 max-w-xl mx-auto">
					We announce our events on LinkedIn. Follow us to stay updated and register for upcoming meetups.
				</p>
				<div class="flex flex-col sm:flex-row gap-4 justify-center">
					<a
						href="/events"
						class="btn-primary"
					>
						View Upcoming Events
						<Calendar class="w-4 h-4 ml-2" />
					</a>
					<a
						href="https://www.linkedin.com/company/norfolk-power-platform-user-group/"
						target="_blank"
						rel="noopener noreferrer"
						class="btn-secondary"
					>
						<Linkedin class="w-4 h-4 mr-2" />
						Follow on LinkedIn
					</a>
				</div>
			</div>
		</div>
	</div>
</section>
