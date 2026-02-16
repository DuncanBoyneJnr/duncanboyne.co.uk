<script lang="ts">
	import { Github, Linkedin, Youtube, Mail } from 'lucide-svelte';

	const currentYear = new Date().getFullYear();

	const socialLinks = [
		{ href: 'https://github.com/DuncanBoyneJnr', icon: Github, label: 'GitHub' },
		{ href: 'https://linkedin.com/in/duncanboyne', icon: Linkedin, label: 'LinkedIn' },
		{ href: 'https://youtube.com/@PowerBIKindaGuy', icon: Youtube, label: 'YouTube' },
		{ href: 'mailto:duncanboyne@hotmail.co.uk', icon: Mail, label: 'Email' }
	];
</script>

<footer class="bg-surface border-t border-border">
	<div class="container-custom py-12">
		<div class="flex flex-col md:flex-row justify-between items-center space-y-6 md:space-y-0">
			<!-- Brand -->
			<div class="text-center md:text-left">
				<p class="text-lg font-semibold text-text">Duncan Boyne</p>
				<p class="text-sm text-muted">Power BI Consultant</p>
			</div>

			<!-- Social Links -->
			<div class="flex items-center space-x-4">
				{#each socialLinks as { href, icon: Icon, label }}
					<a
						{href}
						target="_blank"
						rel="noopener noreferrer"
						class="p-2 rounded-lg text-muted hover:text-accent hover:bg-border transition-colors"
						aria-label={label}
					>
						<Icon class="w-5 h-5" />
						<span class="sr-only"> (opens in new window)</span>
					</a>
				{/each}
			</div>

			<!-- Copyright -->
			<p class="text-sm text-muted">
				&copy; {currentYear} Duncan Boyne. All rights reserved.
			</p>
		</div>
	</div>
</footer>
