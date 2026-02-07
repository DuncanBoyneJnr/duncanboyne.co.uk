<script lang="ts">
	import '../app.css';
	import { onMount } from 'svelte';
	import { goto } from '$app/navigation';
	import Header from '$lib/components/Header.svelte';
	import Footer from '$lib/components/Footer.svelte';

	// Handle GitHub Pages 404 redirect for SPA routing
	onMount(() => {
		const redirectPath = sessionStorage.getItem('redirectPath');
		if (redirectPath && redirectPath !== '/') {
			sessionStorage.removeItem('redirectPath');
			goto(redirectPath);
		}
	});
</script>

<svelte:head>
	<title>Duncan Boyne - Power BI Consultant</title>
	<script defer src="https://cloud.umami.is/script.js" data-website-id="17dd8826-5bf3-43d7-b785-b78f205d2845"></script>
</svelte:head>

<div class="min-h-screen flex flex-col">
	<a href="#main" class="sr-only focus:not-sr-only focus:fixed focus:top-4 focus:left-4 focus:z-[100] focus:px-4 focus:py-2 focus:bg-accent focus:text-[#1F1F1F] focus:font-medium focus:rounded-lg">
		Skip to main content
	</a>
	<Header />
	<main id="main" class="flex-1">
		<slot />
	</main>
	<Footer />
</div>
