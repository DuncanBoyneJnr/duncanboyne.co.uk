<script lang="ts">
	import { page } from '$app/stores';
	import { Menu, X } from 'lucide-svelte';
	import ThemeToggle from './ThemeToggle.svelte';

	let mobileMenuOpen = false;

	const navLinks = [
		{ href: '/', label: 'Home' },
		{ href: '/blog', label: 'Blog' },
		{ href: '/videos', label: 'Videos' },
		{ href: '/events', label: 'Events' },
		{ href: '/about', label: 'About' },
		{ href: '/contact', label: 'Contact' }
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
			<a href="/" class="text-xl font-bold text-text hover:text-accent">
				Duncan Boyne
			</a>

			<!-- Desktop Navigation -->
			<div class="hidden md:flex items-center space-x-8">
				{#each navLinks as link}
					<a
						href={link.href}
						class="text-sm font-medium transition-colors {currentPath === link.href
							? 'text-accent'
							: 'text-muted hover:text-text'}"
					>
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
				<div class="flex flex-col space-y-4">
					{#each navLinks as link}
						<a
							href={link.href}
							on:click={closeMenu}
							class="text-base font-medium transition-colors {currentPath === link.href
								? 'text-accent'
								: 'text-muted hover:text-text'}"
						>
							{link.label}
						</a>
					{/each}
				</div>
			</div>
		{/if}
	</nav>
</header>
