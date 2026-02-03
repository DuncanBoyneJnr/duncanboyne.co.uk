<script lang="ts">
	import { page } from '$app/stores';
	import { Menu, X, Home, FileText, Video, Calendar, User, Mail, Sparkles, Users } from 'lucide-svelte';
	import ThemeToggle from './ThemeToggle.svelte';

	let mobileMenuOpen = false;

	const navLinks = [
		{ href: '/', label: 'Home', icon: Home },
		{ href: '/blog', label: 'Blog', icon: FileText },
		{ href: '/videos', label: 'Videos', icon: Video },
		{ href: '/events', label: 'Events', icon: Calendar },
		{ href: '/summit', label: 'Summit', icon: Sparkles },
		{ href: '/user-group', label: 'User Group', icon: Users },
		{ href: '/about', label: 'About', icon: User },
		{ href: '/contact', label: 'Contact', icon: Mail }
	];

	function toggleMenu() {
		mobileMenuOpen = !mobileMenuOpen;
	}

	function closeMenu() {
		mobileMenuOpen = false;
	}

	$: currentPath = $page.url.pathname;
</script>

<header class="sticky top-0 z-50 bg-surface/80 backdrop-blur-md border-b border-border">
	<nav class="container-custom">
		<div class="flex items-center justify-between h-16">
			<!-- Logo -->
			<a href="/" class="text-xl font-bold text-text hover:text-accent transition-colors">
				Duncan Boyne
			</a>

			<!-- Desktop Navigation -->
			<div class="hidden md:flex items-center space-x-6">
				{#each navLinks as link}
					<a
						href={link.href}
						class="flex items-center gap-2 text-sm font-medium transition-colors px-3 py-2 rounded-lg {currentPath === link.href
							? 'text-accent bg-accent/10'
							: 'text-muted hover:text-text hover:bg-border'}"
					>
						<svelte:component this={link.icon} class="w-4 h-4" />
						{link.label}
					</a>
				{/each}
				<ThemeToggle />
			</div>

			<!-- Mobile Menu Button -->
			<div class="flex items-center md:hidden space-x-2">
				<ThemeToggle />
				<button
					on:click={toggleMenu}
					class="p-2 rounded-lg text-muted hover:text-text hover:bg-border"
					aria-label="Toggle menu"
				>
					{#if mobileMenuOpen}
						<X class="w-6 h-6" />
					{:else}
						<Menu class="w-6 h-6" />
					{/if}
				</button>
			</div>
		</div>

		<!-- Mobile Navigation -->
		{#if mobileMenuOpen}
			<div class="md:hidden py-4 border-t border-border">
				<div class="flex flex-col space-y-2">
					{#each navLinks as link}
						<a
							href={link.href}
							on:click={closeMenu}
							class="flex items-center gap-3 px-3 py-2 rounded-lg text-base font-medium transition-colors {currentPath === link.href
								? 'text-accent bg-accent/10'
								: 'text-muted hover:text-text hover:bg-border'}"
						>
							<svelte:component this={link.icon} class="w-5 h-5" />
							{link.label}
						</a>
					{/each}
				</div>
			</div>
		{/if}
	</nav>
</header>
