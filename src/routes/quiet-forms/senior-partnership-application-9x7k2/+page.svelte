<script lang="ts">
	import { onMount, tick } from 'svelte';
	import { fly, fade } from 'svelte/transition';
	import { Save, RotateCcw, Send, Heart, CheckCircle2 } from 'lucide-svelte';

	type YesNo = 'yes' | 'no' | '';

	interface FormData {
		name: string;
		nickname: string;
		favouriteSnack: string;
		sassLine: string;
		assets: string[];
		relationshipMode: string;
		dogCompatibilityPlan: string;
		dogsBoardMembers: YesNo;
		dogFavouritePlan: string;
		chickenAuthority: number;
		namedChickenLegal: YesNo;
		buildingType: string;
		traits: string[];
		roastWhenNeeded: boolean;
		protectWhenNeeded: boolean;
		eyeRollSometimes: boolean;
		loveWiser: boolean;
		believeAgain: string;
		fiveYearVision: string;
		finalAnswer: string;
	}

	const draftKey = 'girlfriend-application-draft-v1';

	const defaultFormData: FormData = {
		name: '',
		nickname: '',
		favouriteSnack: '',
		sassLine: '',
		assets: [],
		relationshipMode: '',
		dogCompatibilityPlan: '',
		dogsBoardMembers: '',
		dogFavouritePlan: '',
		chickenAuthority: 5,
		namedChickenLegal: '',
		buildingType: '',
		traits: [],
		roastWhenNeeded: false,
		protectWhenNeeded: false,
		eyeRollSometimes: false,
		loveWiser: false,
		believeAgain: '',
		fiveYearVision: '',
		finalAnswer: ''
	};

	let formData: FormData = structuredClone(defaultFormData);
	let attemptedSubmit = false;
	let savedMessage = '';
	let modalOpen = false;
	let closeButton: HTMLButtonElement | null = null;

	const inventoryOptions = [
		'2 Sons (hers)',
		'2 Sons (mine)',
		'1 Dog (hers)',
		'1 Dog (mine)',
		'7 Chickens (collectively judging us)',
		'20 Years of unresolved teenage chemistry'
	];

	const traitOptions = [
		'Fiery',
		'Strong',
		'Caring',
		'Loving',
		'Possessor of elite-level sass'
	];

	const requiredChecks = {
		section2q2: () => formData.dogsBoardMembers !== '',
		section4a: () => formData.roastWhenNeeded,
		section4b: () => formData.protectWhenNeeded,
		section4c: () => formData.eyeRollSometimes,
		section4d: () => formData.loveWiser,
		section5radio: () => formData.believeAgain !== '',
		section5text: () => formData.fiveYearVision.trim().length > 0,
		section6text: () => formData.finalAnswer.trim().length > 0
	};

	function toggleArrayValue(arr: string[], value: string): string[] {
		return arr.includes(value) ? arr.filter((item) => item !== value) : [...arr, value];
	}

	function loadDraft() {
		const raw = localStorage.getItem(draftKey);
		if (!raw) return;

		try {
			const parsed = JSON.parse(raw) as Partial<FormData>;
			formData = {
				...defaultFormData,
				...parsed,
				assets: Array.isArray(parsed.assets) ? parsed.assets : [],
				traits: Array.isArray(parsed.traits) ? parsed.traits : [],
				chickenAuthority: typeof parsed.chickenAuthority === 'number' ? parsed.chickenAuthority : 5
			};
		} catch {
			localStorage.removeItem(draftKey);
		}
	}

	function saveDraft() {
		localStorage.setItem(draftKey, JSON.stringify(formData));
		savedMessage = 'Draft saved locally.';
		setTimeout(() => {
			savedMessage = '';
		}, 2500);
	}

	function resetForm() {
		formData = structuredClone(defaultFormData);
		attemptedSubmit = false;
		modalOpen = false;
		savedMessage = '';
		localStorage.removeItem(draftKey);
	}

	function fieldError(show: boolean, message: string) {
		return show ? message : '';
	}

	$: completedRequired = Object.values(requiredChecks).filter((check) => check()).length;
	$: totalRequired = Object.keys(requiredChecks).length;
	$: progressPercent = Math.round((completedRequired / totalRequired) * 100);
	$: inventorySummary = formData.assets.length > 0 ? formData.assets.join(', ') : 'None selected yet';

	onMount(() => {
		loadDraft();
	});

	async function submitApplication() {
		attemptedSubmit = true;
		if (completedRequired !== totalRequired) return;
		modalOpen = true;
		await tick();
		closeButton?.focus();
	}

	function handleModalKeydown(event: KeyboardEvent) {
		if (event.key === 'Escape') {
			modalOpen = false;
		}
	}
</script>

<svelte:head>
	<title>Girlfriend Application Form - Duncan Boyne</title>
	<meta name="robots" content="noindex, nofollow, noarchive" />
	<meta name="description" content="Private application form." />
</svelte:head>

<section class="py-12 md:py-16 bg-bg">
	<div class="container-custom max-w-4xl">
		<div class="card p-6 md:p-8 mb-8 border-accent/40 bg-gradient-to-br from-accent/10 to-surface" in:fly={{ y: 14, duration: 260 }}>
			<div class="flex items-start justify-between gap-4">
				<div>
					<p class="text-sm text-muted mb-2">Private Form</p>
					<h1 class="text-3xl md:text-4xl font-bold text-text mb-2">Girlfriend Application Form</h1>
					<p class="text-lg text-text/90 mb-4">Re-Opening of a Previously Filled Position - Now Senior Level</p>
					<p class="text-muted leading-relaxed whitespace-pre-line">This isn't a random application.
This is a small countryside merger with emotional shareholders.
Two dogs. Seven chickens. Four boys. Twenty years of history.
Playful. But serious where it matters.</p>
				</div>
				<Heart class="w-8 h-8 text-accent shrink-0" aria-hidden="true" />
			</div>
		</div>

		<div class="card p-4 md:p-5 mb-8" in:fly={{ y: 14, duration: 280 }}>
			<div class="flex items-center justify-between gap-4 mb-2">
				<h2 class="text-base font-semibold text-text">Progress</h2>
				<p class="text-sm text-muted">{completedRequired}/{totalRequired} required complete</p>
			</div>
			<div class="w-full h-2.5 bg-border rounded-full overflow-hidden" role="progressbar" aria-valuemin="0" aria-valuemax="100" aria-valuenow={progressPercent} aria-label="Application completion">
				<div class="h-full bg-accent transition-all duration-300" style="width: {progressPercent}%" />
			</div>
		</div>

		<form class="space-y-6" on:submit|preventDefault={submitApplication}>
			<div class="card p-6 md:p-8" in:fly={{ y: 16, duration: 300 }}>
				<h2 class="text-2xl font-semibold text-text mb-2">Applicant Details <span class="text-sm font-normal text-muted">(optional)</span></h2>
				<div class="grid md:grid-cols-2 gap-4 mt-5">
					<div>
						<label for="name" class="block text-sm font-medium text-text mb-2">Name</label>
						<input id="name" type="text" bind:value={formData.name} class="w-full px-4 py-3 rounded-lg border border-border bg-surface text-text focus:ring-2 focus:ring-accent focus:border-transparent" />
					</div>
					<div>
						<label for="nickname" class="block text-sm font-medium text-text mb-2">Nickname</label>
						<input id="nickname" type="text" bind:value={formData.nickname} class="w-full px-4 py-3 rounded-lg border border-border bg-surface text-text focus:ring-2 focus:ring-accent focus:border-transparent" />
					</div>
					<div>
						<label for="snack" class="block text-sm font-medium text-text mb-2">Favourite snack</label>
						<input id="snack" type="text" bind:value={formData.favouriteSnack} class="w-full px-4 py-3 rounded-lg border border-border bg-surface text-text focus:ring-2 focus:ring-accent focus:border-transparent" />
					</div>
					<div>
						<label for="sass" class="block text-sm font-medium text-text mb-2">Best 'sass line' you've ever delivered</label>
						<input id="sass" type="text" bind:value={formData.sassLine} class="w-full px-4 py-3 rounded-lg border border-border bg-surface text-text focus:ring-2 focus:ring-accent focus:border-transparent" />
					</div>
				</div>
			</div>

			<div class="card p-6 md:p-8" in:fly={{ y: 18, duration: 320 }}>
				<h2 class="text-2xl font-semibold text-text mb-1">Section 1: Assets & Liabilities</h2>
				<p class="text-muted mb-5">Please confirm current inventory:</p>
				<div class="grid sm:grid-cols-2 gap-3 mb-6">
					{#each inventoryOptions as option}
						<label class="flex items-start gap-3 p-3 rounded-lg border border-border hover:border-accent/50 transition-colors cursor-pointer">
							<input
								type="checkbox"
								checked={formData.assets.includes(option)}
								on:change={() => (formData.assets = toggleArrayValue(formData.assets, option))}
								class="mt-1"
							/>
							<span>{option}</span>
						</label>
					{/each}
				</div>

				<div class="card p-4 mb-6 bg-accent/5 border-accent/25">
					<h3 class="font-semibold text-text mb-2">Total household projection</h3>
					<p class="text-muted whitespace-pre-line">4 Boys
2 Dogs
7 Chickens
2 Adults who absolutely should know better by now</p>
				</div>

				<fieldset>
					<legend class="block text-sm font-medium text-text mb-3">Are you prepared to enter into:</legend>
					<div class="space-y-2">
						{#each ['A relationship', 'A wildlife documentary', 'A mild sitcom'] as option}
							<label class="flex items-center gap-3">
								<input type="radio" name="relationshipMode" value={option} bind:group={formData.relationshipMode} />
								<span>{option}</span>
							</label>
						{/each}
					</div>
				</fieldset>
			</div>

			<div class="card p-6 md:p-8" in:fly={{ y: 20, duration: 340 }}>
				<h2 class="text-2xl font-semibold text-text mb-4">Section 2: Canine Compatibility</h2>
				<fieldset class="mb-6">
					<legend class="block text-sm font-medium text-text mb-3">If our dogs don't like each other immediately, do we:</legend>
					<div class="space-y-2">
						{#each ['Mediate responsibly', 'Panic', 'Blame the dogs', "Say 'this is just like us at 15'"] as option}
							<label class="flex items-center gap-3">
								<input type="radio" name="dogCompatibilityPlan" value={option} bind:group={formData.dogCompatibilityPlan} />
								<span>{option}</span>
							</label>
						{/each}
					</div>
				</fieldset>

				<fieldset class="mb-4" aria-describedby="s2q2-help s2q2-error">
					<legend class="block text-sm font-medium text-text mb-2">Are you willing to accept that I will absolutely talk to both dogs like they are full members of the family board? <span class="text-error" aria-hidden="true">* required</span></legend>
					<p id="s2q2-help" class="text-sm text-muted mb-2">Required yes/no</p>
					<div class="flex items-center gap-6">
						<label class="flex items-center gap-2">
							<input type="radio" name="dogsBoardMembers" value="yes" bind:group={formData.dogsBoardMembers} />
							<span>Yes</span>
						</label>
						<label class="flex items-center gap-2">
							<input type="radio" name="dogsBoardMembers" value="no" bind:group={formData.dogsBoardMembers} />
							<span>No</span>
						</label>
					</div>
					{#if attemptedSubmit && !requiredChecks.section2q2()}
						<p id="s2q2-error" class="text-sm text-error mt-2">Please choose yes or no for this required question.</p>
					{/if}
				</fieldset>

				<div>
					<label for="dogFavouritePlan" class="block text-sm font-medium text-text mb-2">If one dog chooses you as their favourite, how do we handle my emotional spiral?</label>
					<input id="dogFavouritePlan" type="text" bind:value={formData.dogFavouritePlan} class="w-full px-4 py-3 rounded-lg border border-border bg-surface text-text focus:ring-2 focus:ring-accent focus:border-transparent" />
				</div>
			</div>

			<div class="card p-6 md:p-8" in:fly={{ y: 22, duration: 360 }}>
				<h2 class="text-2xl font-semibold text-text mb-4">Section 3: Poultry & Power Dynamics</h2>
				<div class="mb-6">
					<label for="chickenAuthority" class="block text-sm font-medium text-text mb-2">On a scale of 1-10 how much authority do the chickens actually hold in your household?</label>
					<input id="chickenAuthority" type="range" min="1" max="10" step="1" bind:value={formData.chickenAuthority} class="w-full accent-accent" />
					<p class="text-sm text-muted mt-2">Chicken authority score: <span class="font-medium text-text">{formData.chickenAuthority}</span></p>
				</div>

				<fieldset class="mb-6">
					<legend class="block text-sm font-medium text-text mb-3">If I accidentally name one of them, does that mean it's legally ours?</legend>
					<div class="flex items-center gap-6">
						<label class="flex items-center gap-2">
							<input type="radio" name="namedChickenLegal" value="yes" bind:group={formData.namedChickenLegal} />
							<span>Yes</span>
						</label>
						<label class="flex items-center gap-2">
							<input type="radio" name="namedChickenLegal" value="no" bind:group={formData.namedChickenLegal} />
							<span>No</span>
						</label>
					</div>
				</fieldset>

				<fieldset>
					<legend class="block text-sm font-medium text-text mb-3">Are we building:</legend>
					<div class="space-y-2">
						{#each ['A blended family', 'A small farm', 'A dynasty'] as option}
							<label class="flex items-center gap-3">
								<input type="radio" name="buildingType" value={option} bind:group={formData.buildingType} />
								<span>{option}</span>
							</label>
						{/each}
					</div>
				</fieldset>
			</div>

			<div class="card p-6 md:p-8" in:fly={{ y: 24, duration: 380 }}>
				<h2 class="text-2xl font-semibold text-text mb-4">Section 4: Sass & Survival</h2>
				<fieldset class="mb-6">
					<legend class="block text-sm font-medium text-text mb-3">You are:</legend>
					<div class="grid sm:grid-cols-2 gap-3">
						{#each traitOptions as option}
							<label class="flex items-start gap-3 p-3 rounded-lg border border-border hover:border-accent/50 transition-colors cursor-pointer">
								<input
									type="checkbox"
									checked={formData.traits.includes(option)}
									on:change={() => (formData.traits = toggleArrayValue(formData.traits, option))}
									class="mt-1"
								/>
								<span>{option}</span>
							</label>
						{/each}
					</div>
				</fieldset>

				<fieldset>
					<legend class="block text-sm font-medium text-text mb-3">Required confirmations <span class="text-error" aria-hidden="true">* required</span></legend>
					<div class="space-y-3" aria-describedby="s4-error">
						<label class="flex items-start gap-3">
							<input type="checkbox" bind:checked={formData.roastWhenNeeded} class="mt-1" />
							<span>You will roast me when needed</span>
						</label>
						<label class="flex items-start gap-3">
							<input type="checkbox" bind:checked={formData.protectWhenNeeded} class="mt-1" />
							<span>You will protect me when needed</span>
						</label>
						<label class="flex items-start gap-3">
							<input type="checkbox" bind:checked={formData.eyeRollSometimes} class="mt-1" />
							<span>You will occasionally roll your eyes at me</span>
						</label>
						<label class="flex items-start gap-3">
							<input type="checkbox" bind:checked={formData.loveWiser} class="mt-1" />
							<span>You will love me like you did when we were young, but wiser</span>
						</label>
					</div>
					{#if attemptedSubmit && (!requiredChecks.section4a() || !requiredChecks.section4b() || !requiredChecks.section4c() || !requiredChecks.section4d())}
						<p id="s4-error" class="text-sm text-error mt-2">Please tick all four required confirmations.</p>
					{/if}
				</fieldset>
			</div>

			<div class="card p-6 md:p-8" in:fly={{ y: 26, duration: 400 }}>
				<h2 class="text-2xl font-semibold text-text mb-4">Section 5: Long-Term Vision</h2>
				<fieldset class="mb-5" aria-describedby="s5r-error">
					<legend class="block text-sm font-medium text-text mb-3">Do you believe: Two teenagers who once loved each other can meet again as adults with scars, stories, sons, dogs, and chickens and do it better this time? <span class="text-error" aria-hidden="true">* required</span></legend>
					<div class="space-y-2">
						{#each ['Yes', 'Absolutely', 'We were just early the first time'] as option}
							<label class="flex items-center gap-3">
								<input type="radio" name="believeAgain" value={option} bind:group={formData.believeAgain} />
								<span>{option}</span>
							</label>
						{/each}
					</div>
					{#if attemptedSubmit && !requiredChecks.section5radio()}
						<p id="s5r-error" class="text-sm text-error mt-2">Please choose one required option.</p>
					{/if}
				</fieldset>

				<div>
					<label for="fiveYearVision" class="block text-sm font-medium text-text mb-2">Where do you see this partnership in 5 years? <span class="text-error" aria-hidden="true">* required</span></label>
					<textarea id="fiveYearVision" rows="5" bind:value={formData.fiveYearVision} class="w-full px-4 py-3 rounded-lg border border-border bg-surface text-text focus:ring-2 focus:ring-accent focus:border-transparent resize-none" />
					{#if attemptedSubmit && !requiredChecks.section5text()}
						<p class="text-sm text-error mt-2">Please answer this required question.</p>
					{/if}
				</div>
			</div>

			<div class="card p-6 md:p-8" in:fly={{ y: 28, duration: 420 }}>
				<h2 class="text-2xl font-semibold text-text mb-4">Section 6: Final Question</h2>
				<div>
					<label for="finalAnswer" class="block text-sm font-medium text-text mb-2">After 20 years... What made you look at me again and think, 'Maybe this idiot is still mine.' <span class="text-error" aria-hidden="true">* required</span></label>
					<textarea id="finalAnswer" rows="6" bind:value={formData.finalAnswer} class="w-full px-4 py-3 rounded-lg border border-border bg-surface text-text focus:ring-2 focus:ring-accent focus:border-transparent resize-none" />
					{#if attemptedSubmit && !requiredChecks.section6text()}
						<p class="text-sm text-error mt-2">Please complete the final required answer.</p>
					{/if}
				</div>
			</div>

			<div class="card p-5 md:p-6" in:fade={{ duration: 250 }}>
				<div class="flex flex-col sm:flex-row gap-3">
					<button type="submit" class="btn-primary">
						<Send class="w-4 h-4 mr-2" aria-hidden="true" />
						Submit Application
					</button>
					<button type="button" class="btn-secondary" on:click={saveDraft}>
						<Save class="w-4 h-4 mr-2" aria-hidden="true" />
						Save Draft
					</button>
					<button type="button" class="btn-secondary" on:click={resetForm}>
						<RotateCcw class="w-4 h-4 mr-2" aria-hidden="true" />
						Reset
					</button>
				</div>
				{#if savedMessage}
					<p class="text-sm text-success mt-3">{savedMessage}</p>
				{/if}
			</div>
		</form>

		<p class="text-center text-sm text-muted mt-8">Confidential. Internal use only. Subject to vibes, dogs, and chicken approval.</p>
	</div>
</section>

{#if modalOpen}
	<div class="fixed inset-0 z-[100] bg-black/50 flex items-center justify-center p-4" on:click={() => (modalOpen = false)} on:keydown={handleModalKeydown} transition:fade>
		<div
			class="card w-full max-w-2xl p-6 md:p-8 max-h-[85vh] overflow-y-auto"
			role="dialog"
			aria-modal="true"
			aria-labelledby="application-summary-title"
			on:click|stopPropagation
			in:fly={{ y: 10, duration: 180 }}
		>
			<div class="flex items-start justify-between gap-4 mb-4">
				<div>
					<h2 id="application-summary-title" class="text-2xl font-semibold text-text">Application Summary</h2>
					<p class="text-muted">Submission captured (without sending anywhere).</p>
				</div>
				<button bind:this={closeButton} class="btn-secondary px-3 py-2" on:click={() => (modalOpen = false)} aria-label="Close summary modal">Close</button>
			</div>

			<div class="space-y-4 text-sm">
				{#if formData.name || formData.nickname || formData.favouriteSnack || formData.sassLine}
					<div>
						<h3 class="font-semibold text-text mb-1">Applicant Details</h3>
						<ul class="text-muted space-y-1">
							{#if formData.name}<li>Name: {formData.name}</li>{/if}
							{#if formData.nickname}<li>Nickname: {formData.nickname}</li>{/if}
							{#if formData.favouriteSnack}<li>Favourite snack: {formData.favouriteSnack}</li>{/if}
							{#if formData.sassLine}<li>Best sass line: {formData.sassLine}</li>{/if}
						</ul>
					</div>
				{/if}

				<div>
					<h3 class="font-semibold text-text mb-1">Section 1 Inventory</h3>
					<p class="text-muted">{inventorySummary}</p>
				</div>

				<div>
					<h3 class="font-semibold text-text mb-1">Section 2 Choices</h3>
					<p class="text-muted">Dog intro strategy: {formData.dogCompatibilityPlan || 'Not answered'}</p>
					<p class="text-muted">Dogs are family board members: {formData.dogsBoardMembers ? (formData.dogsBoardMembers === 'yes' ? 'Yes' : 'No') : 'Not answered'}</p>
					<p class="text-muted">Emotional spiral plan: {formData.dogFavouritePlan || 'Not answered'}</p>
				</div>

				<div>
					<h3 class="font-semibold text-text mb-1">Chicken Authority Score</h3>
					<p class="text-muted">{formData.chickenAuthority}/10</p>
				</div>

				<div>
					<h3 class="font-semibold text-text mb-1">Section 5 Answer</h3>
					<p class="text-muted mb-1">Belief choice: {formData.believeAgain}</p>
					<p class="text-muted whitespace-pre-line">{formData.fiveYearVision}</p>
				</div>

				<div>
					<h3 class="font-semibold text-text mb-1">Final Answer</h3>
					<p class="text-muted whitespace-pre-line">{formData.finalAnswer}</p>
				</div>
			</div>

			<div class="mt-6 p-4 rounded-lg bg-success/10 border border-success/30 flex items-start gap-3">
				<CheckCircle2 class="w-5 h-5 text-success mt-0.5" aria-hidden="true" />
				<p class="text-sm text-text">Application received by the internal review board. Early feedback: strong candidate, excellent long-term upside, potential to dominate the league table for banter and loyalty.</p>
			</div>
		</div>
	</div>
{/if}
