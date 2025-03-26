<script>
	/** @type {import('./$types').PageData} */
	// @ts-ignore
	import { getContext, onMount } from 'svelte';

	/** @type boolean */
	$: editMode = true;
	const ctx = getContext('user');

	let updateFirstName = $ctx.firstName;
	let updateLastName = $ctx.lastName;
	let updateNickname = $ctx.nickname;
	let updateInstagram = $ctx.instagram;
	let updateWhatsApp = $ctx.whatsapp;

	/**
	 * @param {{ key: any; }} e
	 */
	function exitEditMode(e) {
		switch (e.key) {
			case 'Escape':
				editMode = true;
				break;
		}
	}

	async function updateUserData() {
		if (updateFirstName === $ctx.firstName && updateLastName === ctx.lastName) {
			return;
		}
		const request = await fetch(`http://localhost:8000/users/${$ctx.email}`, {
			method: 'PUT',
			headers: {
				'Content-Type': 'application/json'
			},
			body: JSON.stringify({
				firstName: updateFirstName,
				lastName: updateLastName,
				nickname: updateNickname,
				instagram: updateInstagram,
				whatsapp: updateWhatsApp
			})
		});
		const response = await request.json();
		$ctx.firstName = response.firstName;
		$ctx.lastName = response.lastName;
		$ctx.nickname = response.nickname;
		$ctx.instagram = response.instagram;
		$ctx.whatsapp = response.whatsapp;
		editMode = !editMode;
	}

	onMount(async () => {});
</script>

<div class="flex flex-col h-full">
	<div class="flex w-full justify-between gap-16 py-4 border-b">
        <div class="flex flex-col">
            <p class="font-bold text-gray-600">Ime</p>
            <p class="text-gray-500">Vase ime i prezime</p>
        </div>
        <div class="flex gap-4 items-center">
            <p class="font-semibold text-gray-600">Valentin Vareskic</p>
            <div>
                <button class="text-yellow-500">Promjeni</button>
            </div>
        </div>
    </div>
	<div class="flex w-full gap-24 py-4 border-b justify-between">
        <div class="flex flex-col">
            <p class="font-bold text-gray-600">Slika</p>
            <p class="text-gray-500">Slika koju cemo prikazati na vasem profilu</p>
        </div>
        <div class="flex gap-4 items-center">
					<div class="flex flex-col justify-center">
						<svg
							class="w-10"
							viewBox="0 0 24 24"
							id="Layer_1"
							data-name="Layer 1"
							xmlns="http://www.w3.org/2000/svg"
							fill="#000000"
							><g id="SVGRepo_bgCarrier" stroke-width="0"></g><g
								id="SVGRepo_tracerCarrier"
								stroke-linecap="round"
								stroke-linejoin="round"
							></g><g id="SVGRepo_iconCarrier"
								><defs
									><style>
										.cls-1 {
											fill: none;
											stroke: #6b7280;
											stroke-miterlimit: 10;
											stroke-width: 1.91px;
										}
									</style></defs
								><circle class="cls-1" cx="12" cy="7.25" r="5.73"></circle><path
									class="cls-1"
									d="M1.5,23.48l.37-2.05A10.3,10.3,0,0,1,12,13h0a10.3,10.3,0,0,1,10.13,8.45l.37,2.05"
								></path></g
							></svg
						>
					</div>
            <div>
                <button class="text-yellow-500">Promjeni</button>
            </div>
        </div>
    </div>
	<div class="flex w-full justify-between gap-16 py-4 border-b">
        <div class="flex flex-col">
            <p class="font-bold text-gray-600">Email</p>
            <p class="text-gray-500">Email koji ce te koristiti u komunikaciji</p>
        </div>
        <div class="flex gap-4 items-center">
            <p class="font-semibold text-gray-600">valentin.vareskic@gmail.com</p>
            <div>
                <button class="text-yellow-500">Promjeni</button>
            </div>
        </div>
    </div>
</div>
<svelte:window on:keydown|preventDefault={exitEditMode} />
