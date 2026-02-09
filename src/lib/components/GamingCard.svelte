<script lang="ts">
	import { Trophy, Gamepad2 } from 'lucide-svelte';
	import type { GamingAchievement } from '$lib/types';

	export let achievement: GamingAchievement;
</script>

<article class="group h-full">
	<div class="card h-full flex flex-col overflow-hidden transition-all duration-300 group-hover:shadow-lg group-hover:border-accent/50 group-hover:-translate-y-1">
		{#if achievement.image}
			<div class="aspect-video overflow-hidden bg-gradient-to-br from-accent/20 to-accent2/20 flex items-center justify-center">
				<img
					src={achievement.image}
					alt="{achievement.title} - {achievement.game}"
					class="w-full h-full object-cover"
				/>
			</div>
		{:else}
			<div class="aspect-video bg-gradient-to-br from-accent/20 to-accent2/20 flex items-center justify-center">
				<Gamepad2 class="w-12 h-12 text-accent/30" aria-hidden="true" />
			</div>
		{/if}

		<div class="p-5 flex flex-col flex-1">
			<div class="flex items-center gap-2 mb-3">
				<Trophy class="w-4 h-4 text-accent" aria-hidden="true" />
				<span class="text-xs font-medium text-accent uppercase tracking-wide">{achievement.achievement_type}</span>
			</div>

			<h3 class="text-lg font-semibold text-text mb-1">
				{achievement.title}
			</h3>

			<p class="text-sm text-muted mb-3">{achievement.game}</p>

			<div class="flex items-center gap-3 mb-3">
				<span class="text-2xl font-bold text-accent">{achievement.value}</span>
				{#if achievement.season}
					<span class="text-xs font-medium px-2 py-1 rounded-full bg-accent/10 text-accent">
						{achievement.season}
					</span>
				{/if}
			</div>

			{#if achievement.tags && achievement.tags.length > 0}
				<div class="flex flex-wrap gap-1 mb-3">
					{#each achievement.tags as tag}
						<span class="text-xs px-2 py-0.5 rounded-full bg-border text-muted">{tag}</span>
					{/each}
				</div>
			{/if}

			{#if achievement.notes}
				<p class="text-muted text-sm mt-auto">
					{achievement.notes}
				</p>
			{/if}
		</div>
	</div>
</article>
