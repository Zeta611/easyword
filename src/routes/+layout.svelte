<script lang="ts">
	import '../app.css';

	let { children } = $props();
</script>

<nav>
	<a href="/">Home</a>
	<a href="/why">배경/원칙</a>
	<a href="/new-jargon">용어제안</a>
	<a href="/tips">용어팁</a>
	<a href="/trans">자동번역</a>
	<a href="/colophon">제작기</a>
	<a href="https://github.com/Zeta611/easyword">제작참여</a>
	<a href="/profile">내 정보</a>
</nav>

{@render children()}
