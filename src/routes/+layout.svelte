<script>
	import '../app.css';
	import Navigation from '../components/Navigation.svelte';
	import Footer from '../components/Footer.svelte';
	import { onMount, setContext } from 'svelte';
	import { user } from './store';
	export let data;

	setContext('user', user);
	onMount(async () => {
		if (data) {
			const response = await fetch('http://localhost:8000/test');
			const responseData = await response.json();
			if (responseData) {
				// @ts-ignore
				const fetchUser = await fetch(`http://localhost:8000/users/${responseData.email}`);
				if (fetchUser.status === 404) {
					const createUser = await fetch(`http://localhost:8000/users/`, {
						method: 'POST',
						headers: {
							'Content-Type': 'application/json'
						},
						body: JSON.stringify({ email: responseData.email })
					});
					const createdUserResponse = await createUser.json();
				}
				const databaseUser = await fetchUser.json();
				// @ts-ignore
				user.set({
					email: responseData.email,
					picture: responseData.picture,
					firstName: databaseUser.firstName,
					lastName: databaseUser.lastName,
					instagram: databaseUser.instagram,
					whatsapp: databaseUser.whatsapp,
					nickname: databaseUser.nickname
				});
			} else {
				console.log('no data');
			}
		}
	});
</script>

<div class="min-h-screen">
	<Navigation />
	<slot />
	<Footer />
</div>
