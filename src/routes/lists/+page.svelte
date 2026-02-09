<script lang="ts">
	import { BookOpen, Tv, Gamepad2, ArrowRight } from 'lucide-svelte';

	const sections = [
		{
			title: 'Reading',
			description: 'Books I\'ve read, am reading, or want to read — with reviews.',
			href: '/reading',
			icon: BookOpen
		},
		{
			title: 'Anime',
			description: 'My anime watch list, ratings, and reviews.',
			href: '/anime',
			icon: Tv
		},
		{
			title: 'Gaming',
			description: 'Gaming achievements, peak ratings, and milestones.',
			href: '/gaming',
			icon: Gamepad2
		}
	];
</script>

<svelte:head>
	<title>Lists & Reviews - Duncan Boyne</title>
	<meta name="description" content="Reading list, anime watch list, and gaming achievements from Duncan Boyne." />
</svelte:head>

<section class="py-16">
	<div class="container-custom">
		<div class="text-center mb-12">
			<h1 class="text-4xl md:text-5xl font-bold text-text mb-4">Lists & Reviews</h1>
			<p class="text-lg text-muted max-w-2xl mx-auto">
				What I'm reading, watching, and playing — with reviews and ratings.
			</p>
		</div>

		<div class="grid md:grid-cols-3 gap-8">
			{#each sections as section}
				<a
					href={section.href}
					class="group block h-full focus:outline-none focus:ring-2 focus:ring-accent focus:ring-offset-2 focus:ring-offset-bg rounded-xl"
				>
					<div class="card h-full flex flex-col overflow-hidden transition-all duration-300 group-hover:shadow-lg group-hover:border-accent/50 group-hover:-translate-y-1">
						<div class="aspect-video bg-gradient-to-br from-accent/20 to-accent2/20 flex items-center justify-center">
							<svelte:component this={section.icon} class="w-16 h-16 text-accent/40 transition-transform duration-300 group-hover:scale-110" />
						</div>
						<div class="p-6 flex flex-col flex-1">
							<h2 class="text-xl font-semibold text-text mb-2 group-hover:text-accent transition-colors">
								{section.title}
							</h2>
							<p class="text-muted text-sm mb-4">
								{section.description}
							</p>
							<span class="inline-flex items-center text-accent font-medium text-sm group-hover:underline mt-auto">
								Browse
								<ArrowRight class="w-4 h-4 ml-1 transition-transform group-hover:translate-x-1" aria-hidden="true" />
							</span>
						</div>
					</div>
				</a>
			{/each}
		</div>
	</div>
</section>
