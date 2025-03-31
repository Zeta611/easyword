<script lang="ts">
	import '../app.css';
	import { NavigationMenu } from 'bits-ui';
	import { cn } from '$lib/utils';

	let { children } = $props();

	const navItems = [
		{ href: '/', title: 'Home' },
		{ href: '/why', title: '배경/원칙' },
		{ href: '/new-jargon', title: '용어제안' },
		{ href: '/tips', title: '용어팁' },
		{ href: '/trans', title: '자동번역' },
		{ href: '/colophon', title: '제작기' },
		{ href: 'https://github.com/Zeta611/easyword', title: '제작참여' },
		{ href: '/profile', title: '내 정보' }
	];

	type NavItemProps = {
		className?: string;
		title: string;
		href: string;
	};
</script>

{#snippet NavItem({ className, title, href }: NavItemProps)}
	<NavigationMenu.Item>
		<NavigationMenu.Link
			class={cn(
				'group hover:text-accent-foreground focus:bg-muted focus:text-accent-foreground data-[state=open]:shadow-mini dark:hover:bg-muted dark:data-[state=open]:bg-muted inline-flex h-8 w-max items-center justify-center rounded-[7px] bg-transparent px-4 py-2 text-sm font-medium transition-colors hover:bg-white focus:outline-none disabled:pointer-events-none disabled:opacity-50 data-[state=open]:bg-white',
				className
			)}
			{href}
		>
			<div class="text-sm leading-none font-medium">{title}</div>
		</NavigationMenu.Link>
	</NavigationMenu.Item>
{/snippet}

<NavigationMenu.Root class="relative z-10 flex w-full justify-center">
	<NavigationMenu.List class="group flex items-center justify-center p-1">
		{#each navItems as item (item.title)}
			{@render NavItem(item)}
		{/each}
	</NavigationMenu.List>
</NavigationMenu.Root>

<div>{@render children()}</div>
