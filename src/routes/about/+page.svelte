<script lang="ts">
	import { Award, BookOpen, Users, BarChart3 } from 'lucide-svelte';

	const skills = [
		'Power BI Desktop & Service',
		'DAX (Data Analysis Expressions)',
		'Power Query (M Language)',
		'Data Modeling',
		'SQL Server',
		'Azure Synapse Analytics',
		'Azure Data Factory',
		'Python for Data Analysis',
		'Excel & Power Pivot',
		'Data Visualization Best Practices'
	];

	const certifications = [
		{
			name: 'Microsoft Certified: Power BI Data Analyst Associate',
			issuer: 'Microsoft',
			year: '2023'
		},
		{
			name: 'Microsoft Certified: Azure Data Fundamentals',
			issuer: 'Microsoft',
			year: '2022'
		}
	];

	const highlights = [
		{
			icon: BarChart3,
			title: '100+ Dashboards',
			description: 'Created over 100 production dashboards for clients across various industries'
		},
		{
			icon: Users,
			title: '50+ Clients',
			description: 'Helped organizations of all sizes leverage their data effectively'
		},
		{
			icon: BookOpen,
			title: 'Continuous Learning',
			description: 'Always staying up-to-date with the latest Power BI features and best practices'
		},
		{
			icon: Award,
			title: 'Industry Recognition',
			description: 'Speaker at conferences and contributor to the Power BI community'
		}
	];
</script>

<svelte:head>
	<title>About - Duncan Boyne</title>
	<meta name="description" content="Learn about Duncan Boyne, a Power BI Consultant with expertise in data visualization, DAX, and business intelligence solutions." />
</svelte:head>

<section class="py-16">
	<div class="container-custom">
		<!-- Header -->
		<div class="max-w-4xl mx-auto text-center mb-16">
			<h1 class="text-4xl md:text-5xl font-bold text-text mb-4">About Me</h1>
			<p class="text-lg text-muted">
				Passionate about turning complex data into clear, actionable insights.
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
							I'm a Power BI Consultant with a passion for helping organizations make sense of their data.
							With years of experience in business intelligence and data visualization, I specialize in
							creating dashboards and reports that drive decision-making.
						</p>
						<p>
							My approach combines technical expertise with a deep understanding of business needs.
							I believe that the best data solutions are those that are not only technically sound
							but also intuitive and actionable for end users.
						</p>
						<p>
							When I'm not building Power BI solutions, you'll find me sharing knowledge through
							blog posts, videos, and speaking at community events. I'm committed to helping others
							master Power BI and unlock the potential of their data.
						</p>
					</div>
				</div>
			</div>
		</div>

		<!-- Highlights -->
		<div class="mb-16">
			<h2 class="text-2xl font-bold text-text text-center mb-8">Highlights</h2>
			<div class="grid sm:grid-cols-2 lg:grid-cols-4 gap-6">
				{#each highlights as { icon: Icon, title, description }}
					<div class="card p-6 text-center">
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
					<span class="px-4 py-2 bg-surface border border-border text-muted rounded-lg text-sm font-medium">
						{skill}
					</span>
				{/each}
			</div>
		</div>

		<!-- Certifications -->
		<div class="max-w-4xl mx-auto">
			<h2 class="text-2xl font-bold text-text text-center mb-8">Certifications</h2>
			<div class="grid md:grid-cols-2 gap-6">
				{#each certifications as cert}
					<div class="card p-6">
						<div class="flex items-start space-x-4">
							<div class="w-12 h-12 bg-info/10 rounded-lg flex items-center justify-center flex-shrink-0">
								<Award class="w-6 h-6 text-info" />
							</div>
							<div>
								<h3 class="font-semibold text-text mb-1">{cert.name}</h3>
								<p class="text-sm text-muted">{cert.issuer} &bull; {cert.year}</p>
							</div>
						</div>
					</div>
				{/each}
			</div>
		</div>
	</div>
</section>
