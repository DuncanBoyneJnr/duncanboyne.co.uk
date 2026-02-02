<script lang="ts">
	import { onMount } from 'svelte';
	import { ArrowRight } from 'lucide-svelte';
	import Hero from '$lib/components/Hero.svelte';
	import BlogCard from '$lib/components/BlogCard.svelte';
	import EventCard from '$lib/components/EventCard.svelte';
	import VideoCard from '$lib/components/VideoCard.svelte';
	import { getPosts, getEvents, getVideos } from '$lib/supabase';
	import type { Post, Event, Video } from '$lib/types';

	let posts: Post[] = [];
	let events: Event[] = [];
	let videos: Video[] = [];
	let loading = true;
	let error: string | null = null;

	onMount(async () => {
		try {
			const [postsData, eventsData, videosData] = await Promise.all([
				getPosts(3),
				getEvents(true),
				getVideos(3)
			]);
			posts = postsData || [];
			events = (eventsData || []).slice(0, 2);
			videos = videosData || [];
		} catch (e) {
			error = 'Failed to load content. Please try again later.';
			console.error(e);
		} finally {
			loading = false;
		}
	});
</script>

<svelte:head>
	<title>Duncan Boyne - Power BI Consultant</title>
	<meta name="description" content="Duncan Boyne is a Power BI Consultant helping organizations transform data into actionable insights." />
</svelte:head>

<Hero />

<!-- Latest Blog Posts -->
<section class="py-16 bg-surface">
	<div class="container-custom">
		<div class="flex items-center justify-between mb-8">
			<h2 class="section-title mb-0">Latest Posts</h2>
			<a href="/blog" class="inline-flex items-center text-accent font-medium hover:underline">
				View all
				<ArrowRight class="w-4 h-4 ml-1" />
			</a>
		</div>

		{#if loading}
			<div class="grid md:grid-cols-3 gap-6">
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
			<p class="text-center text-muted py-8">{error}</p>
		{:else if posts.length === 0}
			<p class="text-center text-muted py-8">No posts yet. Check back soon!</p>
		{:else}
			<div class="grid md:grid-cols-3 gap-6">
				{#each posts as post}
					<BlogCard {post} />
				{/each}
			</div>
		{/if}
	</div>
</section>

<!-- Upcoming Events -->
<section class="py-16 bg-bg">
	<div class="container-custom">
		<div class="flex items-center justify-between mb-8">
			<h2 class="section-title mb-0">Upcoming Events</h2>
			<a href="/events" class="inline-flex items-center text-accent font-medium hover:underline">
				View all
				<ArrowRight class="w-4 h-4 ml-1" />
			</a>
		</div>

		{#if loading}
			<div class="grid md:grid-cols-2 gap-6">
				{#each [1, 2] as _}
					<div class="card animate-pulse p-6 space-y-3">
						<div class="h-6 bg-border rounded w-1/4" />
						<div class="h-8 bg-border rounded w-3/4" />
						<div class="h-4 bg-border rounded" />
						<div class="h-4 bg-border rounded w-1/2" />
					</div>
				{/each}
			</div>
		{:else if events.length === 0}
			<p class="text-center text-muted py-8">No upcoming events at the moment. Check back soon!</p>
		{:else}
			<div class="grid md:grid-cols-2 gap-6">
				{#each events as event}
					<EventCard {event} />
				{/each}
			</div>
		{/if}
	</div>
</section>

<!-- Recent Videos -->
<section class="py-16 bg-surface">
	<div class="container-custom">
		<div class="flex items-center justify-between mb-8">
			<h2 class="section-title mb-0">Recent Videos</h2>
			<a href="/videos" class="inline-flex items-center text-accent font-medium hover:underline">
				View all
				<ArrowRight class="w-4 h-4 ml-1" />
			</a>
		</div>

		{#if loading}
			<div class="grid md:grid-cols-3 gap-6">
				{#each [1, 2, 3] as _}
					<div class="card animate-pulse">
						<div class="aspect-video bg-border" />
						<div class="p-6 space-y-3">
							<div class="h-4 bg-border rounded w-1/3" />
							<div class="h-6 bg-border rounded" />
						</div>
					</div>
				{/each}
			</div>
		{:else if videos.length === 0}
			<p class="text-center text-muted py-8">No videos yet. Check back soon!</p>
		{:else}
			<div class="grid md:grid-cols-3 gap-6">
				{#each videos as video}
					<VideoCard {video} />
				{/each}
			</div>
		{/if}
	</div>
</section>
