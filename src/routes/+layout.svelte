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
</svelte:head>

<div class="min-h-screen flex flex-col">
	<Header />
	<main class="flex-1">
		<slot />
	</main>
	<Footer />
</div>
