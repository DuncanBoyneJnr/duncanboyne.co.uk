<script lang="ts">
	import { onMount } from 'svelte';
	import { Gamepad2 } from 'lucide-svelte';
	import GamingCard from '$lib/components/GamingCard.svelte';
	import { getGamingAchievements } from '$lib/supabase';
	import type { GamingAchievement } from '$lib/types';

	let achievements: GamingAchievement[] = [];
	let loading = true;
	let error: string | null = null;

	onMount(async () => {
		try {
			achievements = (await getGamingAchievements()) || [];
		} catch (e) {
			error = 'Failed to load gaming achievements. Please try again later.';
			console.error(e);
		} finally {
			loading = false;
		}
	});
</script>

<svelte:head>
	<title>Gaming Achievements - Duncan Boyne</title>
	<meta name="description" content="Gaming achievements, peak ratings, and milestones from Duncan Boyne." />
</svelte:head>

<section class="py-16">
	<div class="container-custom">
		<div class="text-center mb-12">
			<h1 class="text-4xl md:text-5xl font-bold text-text mb-4">Gaming Achievements</h1>
			<p class="text-lg text-muted max-w-2xl mx-auto">
				Peak ratings, ranks, and milestones from the games I play.
			</p>
		</div>

		{#if loading}
			<div class="grid md:grid-cols-2 lg:grid-cols-3 gap-8">
				{#each [1, 2, 3] as _}
					<div class="card animate-pulse">
						<div class="aspect-video bg-border" />
						<div class="p-6 space-y-3">
							<div class="h-4 bg-border rounded w-1/3" />
							<div class="h-6 bg-border rounded" />
							<div class="h-4 bg-border rounded w-2/3" />
						</div>
					</div>
				{/each}
			</div>
		{:else if error}
			<p class="text-center text-muted py-12">{error}</p>
		{:else if achievements.length === 0}
			<div class="text-center py-12 bg-surface rounded-xl border border-border">
				<Gamepad2 class="w-12 h-12 text-accent/30 mx-auto mb-4" aria-hidden="true" />
				<p class="text-muted">No gaming achievements yet.</p>
				<p class="text-muted/70 text-sm mt-2">Check back soon!</p>
			</div>
		{:else}
			<div class="grid md:grid-cols-2 lg:grid-cols-3 gap-8 items-stretch">
				{#each achievements as achievement}
					<GamingCard {achievement} />
				{/each}
			</div>
		{/if}
	</div>
</section>
