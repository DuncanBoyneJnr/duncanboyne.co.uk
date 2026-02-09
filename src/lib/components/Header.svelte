<script lang="ts">
	import { page } from '$app/stores';
	import { Menu, X, Home, FileText, Video, Calendar, Mic, User, Mail, Sparkles, Users, Database, BookOpen, Tv, Gamepad2, ChevronDown } from 'lucide-svelte';
	import ThemeToggle from './ThemeToggle.svelte';

	let mobileMenuOpen = false;
	let communityOpen = false;
	let aboutOpen = false;

	interface NavLink {
		href: string;
		label: string;
		icon: any;
	}

	interface NavDropdown {
		label: string;
		icon: any;
		children: NavLink[];
	}

	type NavItem = NavLink | NavDropdown;

	function isDropdown(item: NavItem): item is NavDropdown {
		return 'children' in item;
	}

	const navItems: NavItem[] = [
		{ href: '/', label: 'Home', icon: Home },
		{ href: '/blog', label: 'Blog', icon: FileText },
		{ href: '/videos', label: 'Videos', icon: Video },
		{ href: '/events', label: 'Events', icon: Calendar },
		{ href: '/talks', label: 'Talks', icon: Mic },
		{
			label: 'Community',
			icon: Users,
			children: [
				{ href: '/summit', label: 'EoEPPS', icon: Sparkles },
				{ href: '/mcr-data-hive', label: 'DataHive', icon: Database },
				{ href: '/user-group', label: 'NPPUG', icon: Users }
			]
		},
		{
			label: 'About',
			icon: User,
			children: [
				{ href: '/about', label: 'About Me', icon: User },
				{ href: '/reading', label: 'Reading', icon: BookOpen },
				{ href: '/anime', label: 'Anime', icon: Tv },
				{ href: '/gaming', label: 'Gaming', icon: Gamepad2 }
			]
		},
		{ href: '/contact', label: 'Contact', icon: Mail }
	];

	function toggleMenu() {
		mobileMenuOpen = !mobileMenuOpen;
	}

	function closeMenu() {
		mobileMenuOpen = false;
		communityOpen = false;
		aboutOpen = false;
	}

	function toggleDropdown(name: string) {
		if (name === 'community') {
			communityOpen = !communityOpen;
			aboutOpen = false;
		} else if (name === 'about') {
			aboutOpen = !aboutOpen;
			communityOpen = false;
		}
	}

	function closeDropdowns() {
		communityOpen = false;
		aboutOpen = false;
	}

	function isChildActive(children: NavLink[], path: string): boolean {
		return children.some(c => c.href === path);
	}

	$: currentPath = $page.url.pathname;
</script>

<svelte:window on:click={closeDropdowns} />

<header class="sticky top-0 z-50 bg-surface/80 backdrop-blur-md border-b border-border">
	<nav class="container-custom">
		<div class="flex items-center justify-between h-16">
			<!-- Desktop Navigation -->
			<div class="hidden md:flex items-center space-x-4">
				{#each navItems as item}
					{#if isDropdown(item)}
						<div class="relative">
							<button
								on:click|stopPropagation={() => toggleDropdown(item.label.toLowerCase())}
								class="flex items-center gap-1.5 text-sm font-medium transition-colors px-3 py-2 rounded-lg focus:outline-none focus:ring-2 focus:ring-accent {isChildActive(item.children, currentPath)
									? 'text-accent bg-accent/10'
									: 'text-muted hover:text-text hover:bg-border'}"
								aria-expanded={item.label === 'Community' ? communityOpen : aboutOpen}
								aria-haspopup="true"
							>
								<svelte:component this={item.icon} class="w-4 h-4" />
								{item.label}
								<ChevronDown class="w-3 h-3 transition-transform {(item.label === 'Community' ? communityOpen : aboutOpen) ? 'rotate-180' : ''}" aria-hidden="true" />
							</button>

							{#if (item.label === 'Community' && communityOpen) || (item.label === 'About' && aboutOpen)}
								<div
									class="absolute top-full left-0 mt-1 w-48 bg-surface border border-border rounded-xl shadow-lg py-2 z-50"
									on:click|stopPropagation
								>
									{#each item.children as child}
										<a
											href={child.href}
											on:click={closeDropdowns}
											class="flex items-center gap-3 px-4 py-2 text-sm font-medium transition-colors focus:outline-none focus:ring-2 focus:ring-inset focus:ring-accent {currentPath === child.href
												? 'text-accent bg-accent/10'
												: 'text-muted hover:text-text hover:bg-border'}"
										>
											<svelte:component this={child.icon} class="w-4 h-4" />
											{child.label}
										</a>
									{/each}
								</div>
							{/if}
						</div>
					{:else}
						<a
							href={item.href}
							class="flex items-center gap-2 text-sm font-medium transition-colors px-3 py-2 rounded-lg focus:outline-none focus:ring-2 focus:ring-accent {currentPath === item.href
								? 'text-accent bg-accent/10'
								: 'text-muted hover:text-text hover:bg-border'}"
						>
							<svelte:component this={item.icon} class="w-4 h-4" />
							{item.label}
						</a>
					{/if}
				{/each}
				<ThemeToggle />
			</div>

			<!-- Mobile Menu Button -->
			<div class="flex items-center md:hidden space-x-2">
				<ThemeToggle />
				<button
					on:click={toggleMenu}
					class="p-2 rounded-lg text-muted hover:text-text hover:bg-border focus:outline-none focus:ring-2 focus:ring-accent"
					aria-label="Toggle menu"
					aria-expanded={mobileMenuOpen}
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
				<div class="flex flex-col space-y-1">
					{#each navItems as item}
						{#if isDropdown(item)}
							<button
								on:click={() => toggleDropdown(item.label.toLowerCase())}
								class="flex items-center justify-between w-full px-3 py-2 rounded-lg text-base font-medium transition-colors focus:outline-none focus:ring-2 focus:ring-accent {isChildActive(item.children, currentPath)
									? 'text-accent bg-accent/10'
									: 'text-muted hover:text-text hover:bg-border'}"
								aria-expanded={item.label === 'Community' ? communityOpen : aboutOpen}
							>
								<span class="flex items-center gap-3">
									<svelte:component this={item.icon} class="w-5 h-5" />
									{item.label}
								</span>
								<ChevronDown class="w-4 h-4 transition-transform {(item.label === 'Community' ? communityOpen : aboutOpen) ? 'rotate-180' : ''}" aria-hidden="true" />
							</button>

							{#if (item.label === 'Community' && communityOpen) || (item.label === 'About' && aboutOpen)}
								<div class="ml-6 flex flex-col space-y-1">
									{#each item.children as child}
										<a
											href={child.href}
											on:click={closeMenu}
											class="flex items-center gap-3 px-3 py-2 rounded-lg text-base font-medium transition-colors focus:outline-none focus:ring-2 focus:ring-accent {currentPath === child.href
												? 'text-accent bg-accent/10'
												: 'text-muted hover:text-text hover:bg-border'}"
										>
											<svelte:component this={child.icon} class="w-5 h-5" />
											{child.label}
										</a>
									{/each}
								</div>
							{/if}
						{:else}
							<a
								href={item.href}
								on:click={closeMenu}
								class="flex items-center gap-3 px-3 py-2 rounded-lg text-base font-medium transition-colors focus:outline-none focus:ring-2 focus:ring-accent {currentPath === item.href
									? 'text-accent bg-accent/10'
									: 'text-muted hover:text-text hover:bg-border'}"
							>
								<svelte:component this={item.icon} class="w-5 h-5" />
								{item.label}
							</a>
						{/if}
					{/each}
				</div>
			</div>
		{/if}
	</nav>
</header>
