<script lang="ts">
	import { Github, Linkedin, Twitter, Youtube, ArrowRight } from 'lucide-svelte';

	const socialLinks = [
		{ href: 'https://github.com/duncanboyne', icon: Github, label: 'GitHub' },
		{ href: 'https://linkedin.com/in/duncanboyne', icon: Linkedin, label: 'LinkedIn' },
		{ href: 'https://twitter.com/duncanboyne', icon: Twitter, label: 'Twitter' },
		{ href: 'https://youtube.com/@duncanboyne', icon: Youtube, label: 'YouTube' }
	];
</script>

<section class="py-20 md:py-28">
	<div class="container-custom">
		<div class="flex flex-col md:flex-row items-center gap-12">
			<!-- Profile Image -->
			<div class="flex-shrink-0">
				<div class="relative">
					<div class="w-48 h-48 md:w-64 md:h-64 rounded-full bg-gradient-to-br from-accent to-accent2 p-1">
						<div class="w-full h-full rounded-full bg-surface flex items-center justify-center overflow-hidden">
							<img src="/profile.jpg" alt="Duncan Boyne" class="w-full h-full object-cover" />
						</div>
					</div>
					<div class="absolute -bottom-2 -right-2 w-12 h-12 bg-accent rounded-full border-4 border-bg flex items-center justify-center">
						<span class="text-[#1F1F1F] text-xs font-bold">PBI</span>
					</div>
				</div>
			</div>

			<!-- Content -->
			<div class="flex-1 text-center md:text-left">
				<h1 class="text-4xl md:text-5xl lg:text-6xl font-bold text-text mb-4">
					Duncan Boyne
				</h1>
				<p class="text-xl md:text-2xl text-accent font-medium mb-6">
					Power BI Consultant
				</p>
				<p class="text-lg text-muted mb-8 max-w-2xl">
					Helping organizations transform their data into actionable insights through
					Power BI dashboards, data modeling, and business intelligence solutions.
				</p>

				<!-- CTA Buttons -->
				<div class="flex flex-col sm:flex-row gap-4 justify-center md:justify-start mb-8">
					<a href="/contact" class="btn-primary">
						Get in Touch
						<ArrowRight class="w-4 h-4 ml-2" />
					</a>
					<a href="/about" class="btn-secondary">
						Learn More
					</a>
				</div>

				<!-- Social Links -->
				<div class="flex items-center justify-center md:justify-start space-x-4">
					{#each socialLinks as { href, icon: Icon, label }}
						<a
							{href}
							target="_blank"
							rel="noopener noreferrer"
							class="p-2 rounded-lg text-muted hover:text-accent hover:bg-border transition-colors"
							aria-label={label}
						>
							<Icon class="w-6 h-6" />
						</a>
					{/each}
				</div>
			</div>
		</div>
	</div>
</section>
