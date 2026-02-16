<script lang="ts">
	import { Mail, Github, Linkedin, Youtube, Send, Mic, ExternalLink } from 'lucide-svelte';

	let formData = {
		name: '',
		email: '',
		subject: '',
		message: ''
	};
	let submitting = false;
	let submitted = false;
	let error: string | null = null;

	async function handleSubmit() {
		submitting = true;
		error = null;

		try {
			const response = await fetch('https://formspree.io/f/YOUR_FORMSPREE_ID', {
				method: 'POST',
				headers: {
					'Content-Type': 'application/json'
				},
				body: JSON.stringify(formData)
			});

			if (response.ok) {
				submitted = true;
				formData = { name: '', email: '', subject: '', message: '' };
			} else {
				throw new Error('Form submission failed');
			}
		} catch (e) {
			error = 'Failed to send message. Please try again or email directly.';
		} finally {
			submitting = false;
		}
	}

	const socialLinks = [
		{ href: 'https://github.com/DuncanBoyneJnr', icon: Github, label: 'GitHub', username: '@DuncanBoyneJnr' },
		{ href: 'https://linkedin.com/in/duncanboyne', icon: Linkedin, label: 'LinkedIn', username: 'in/duncanboyne' },
		{ href: 'https://youtube.com/@PowerBIKindaGuy', icon: Youtube, label: 'YouTube', username: '@PowerBIKindaGuy' },
		{ href: 'https://youtube.com/@PowerPlatformClinic', icon: Youtube, label: 'YouTube', username: '@PowerPlatformClinic' }
	];
</script>

<svelte:head>
	<title>Contact - Duncan Boyne</title>
	<meta name="description" content="Get in touch with Duncan Boyne for Power BI consulting, speaking engagements, or collaboration opportunities." />
</svelte:head>

<section class="py-16">
	<div class="container-custom">
		<div class="text-center mb-12">
			<h1 class="text-4xl md:text-5xl font-bold text-text mb-4">Get in Touch</h1>
			<p class="text-lg text-muted max-w-2xl mx-auto">
				Have a question? Want to discuss Power BI solutions? I'd love to hear from you.
			</p>
		</div>

		<div class="max-w-5xl mx-auto">
			<div class="grid md:grid-cols-2 gap-12">
				<!-- Contact Form -->
				<div>
					<h2 class="text-xl font-semibold text-text mb-6">Send a Message</h2>

					{#if submitted}
						<div class="bg-success/10 border border-success/20 rounded-xl p-6 text-center">
							<div class="w-12 h-12 bg-success/20 rounded-full flex items-center justify-center mx-auto mb-4">
								<Send class="w-6 h-6 text-success" aria-hidden="true" />
							</div>
							<h3 class="text-lg font-semibold text-text mb-2">Message Sent!</h3>
							<p class="text-muted">Thank you for reaching out. I'll get back to you soon.</p>
						</div>
					{:else}
						<form on:submit|preventDefault={handleSubmit} class="space-y-6">
							<div>
								<label for="name" class="block text-sm font-medium text-text mb-2">
									Name
								</label>
								<input
									type="text"
									id="name"
									bind:value={formData.name}
									required
									class="w-full px-4 py-3 rounded-lg border border-border bg-surface text-text focus:ring-2 focus:ring-accent focus:border-transparent transition-colors"
									placeholder="Your name"
								/>
							</div>

							<div>
								<label for="email" class="block text-sm font-medium text-text mb-2">
									Email
								</label>
								<input
									type="email"
									id="email"
									bind:value={formData.email}
									required
									class="w-full px-4 py-3 rounded-lg border border-border bg-surface text-text focus:ring-2 focus:ring-accent focus:border-transparent transition-colors"
									placeholder="your@email.com"
								/>
							</div>

							<div>
								<label for="subject" class="block text-sm font-medium text-text mb-2">
									Subject
								</label>
								<input
									type="text"
									id="subject"
									bind:value={formData.subject}
									required
									class="w-full px-4 py-3 rounded-lg border border-border bg-surface text-text focus:ring-2 focus:ring-accent focus:border-transparent transition-colors"
									placeholder="What's this about?"
								/>
							</div>

							<div>
								<label for="message" class="block text-sm font-medium text-text mb-2">
									Message
								</label>
								<textarea
									id="message"
									bind:value={formData.message}
									required
									rows="5"
									class="w-full px-4 py-3 rounded-lg border border-border bg-surface text-text focus:ring-2 focus:ring-accent focus:border-transparent transition-colors resize-none"
									placeholder="Tell me what's on your mind..."
								></textarea>
							</div>

							{#if error}
								<p class="text-error text-sm">{error}</p>
							{/if}

							<button
								type="submit"
								disabled={submitting}
								class="btn-primary w-full disabled:opacity-50 disabled:cursor-not-allowed"
							>
								{#if submitting}
									Sending...
								{:else}
									Send Message
									<Send class="w-4 h-4 ml-2" aria-hidden="true" />
								{/if}
							</button>
						</form>
					{/if}
				</div>

				<!-- Contact Info -->
				<div>
					<h2 class="text-xl font-semibold text-text mb-6">Other Ways to Connect</h2>

					<div class="space-y-6">
						<!-- Email -->
						<div class="card p-6 transition-all duration-300 hover:-translate-y-1 hover:border-accent/50">
							<div class="flex items-start space-x-4">
								<div class="w-10 h-10 bg-accent/10 rounded-lg flex items-center justify-center flex-shrink-0">
									<Mail class="w-5 h-5 text-accent" aria-hidden="true" />
								</div>
								<div>
									<h3 class="font-medium text-text mb-1">Email</h3>
									<a href="mailto:duncanboyne@hotmail.co.uk" class="text-accent hover:underline">
										duncanboyne@hotmail.co.uk
									</a>
								</div>
							</div>
						</div>

						<!-- Sessionize -->
						<div class="card p-6 transition-all duration-300 hover:-translate-y-1 hover:border-accent/50">
							<div class="flex items-start space-x-4">
								<div class="w-10 h-10 bg-accent/10 rounded-lg flex items-center justify-center flex-shrink-0">
									<Mic class="w-5 h-5 text-accent" aria-hidden="true" />
								</div>
								<div>
									<h3 class="font-medium text-text mb-1">Speaking Enquiries</h3>
									<a
										href="https://sessionize.com/duncan-boyne"
										target="_blank"
										rel="noopener noreferrer"
										class="inline-flex items-center text-accent hover:underline"
									>
										View my Sessionize profile
										<ExternalLink class="w-4 h-4 ml-1" aria-hidden="true" />
									</a>
								</div>
							</div>
						</div>

						<!-- Social Links -->
						<div class="card p-6">
							<h3 class="font-medium text-text mb-4">Social Media</h3>
							<div class="space-y-3">
								{#each socialLinks as { href, icon: Icon, label, username }}
									<a
										{href}
										target="_blank"
										rel="noopener noreferrer"
										class="flex items-center space-x-3 text-muted hover:text-accent transition-colors"
									>
										<Icon class="w-5 h-5" aria-hidden="true" />
										<span>{label}</span>
										<span class="text-sm text-muted/70">{username}</span>
									</a>
								{/each}
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</section>
