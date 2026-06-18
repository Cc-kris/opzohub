<section class="opzohub-home" aria-label="opzohub homepage">
	<header class="opzohub-topbar">
		<a class="opzohub-logo" href="{config.relative_path}/" aria-label="{brand.logoAlt}">
			{{{if brand.logo}}}
			<img src="{brand.logo}" alt="{brand.logoAlt}" />
			{{{else}}}
			<span class="opzohub-logo-dot"></span>
			{{{end}}}
			<span class="opzohub-site-title">{brand.title}</span>
		</a>
		<nav class="opzohub-main-nav" aria-label="Primary">
			{{{each navItems}}}
			<a class="{{{if navItems.active}}}active{{{end}}}" href="{navItems.url}">{navItems.label}</a>
			{{{end}}}
		</nav>
		<form class="opzohub-search" action="{config.relative_path}/search" method="get">
			<i class="fa fa-search"></i>
			<input name="term" type="search" placeholder="搜索帖子、话题、用户或资源" />
		</form>
		<div class="opzohub-auth">
			<a href="{config.relative_path}/login">登录</a>
			<a class="register" href="{config.relative_path}/register">注册</a>
		</div>
	</header>

	<div class="opzohub-page-grid">
		<aside class="opzohub-left-rail" aria-label="浏览版块">
			<section class="opzohub-card channel-card">
				<div class="opzohub-card-title"><span>浏览版块</span></div>
				{{{each channelItems}}}
				<a class="channel {{{if channelItems.active}}}active{{{end}}}" href="{channelItems.url}"><i class="fa {channelItems.icon}"></i><span>{channelItems.label}</span>{{{if channelItems.badge}}}<em>{channelItems.badge}</em>{{{end}}}</a>
				{{{end}}}
			</section>

			<section class="opzohub-card channel-card commerce-card">
				{{{if hasHomeCategories}}}
				{{{each homeCategories}}}
				<a class="channel" href="{homeCategories.url}"><i class="fa {homeCategories.icon}"></i><span>{homeCategories.name}</span></a>
				{{{end}}}
				{{{else}}}
				<div class="opzohub-empty mini">暂无可浏览分类，请先在后台创建分类</div>
				{{{end}}}
			</section>
		</aside>

		<main class="opzohub-main" aria-label="首页内容">
			<section class="opzohub-hero-panel {{{if banners.heroImage}}}has-banner{{{end}}}" style="{{{if banners.heroImage}}}background-image: linear-gradient(110deg, rgba(7, 18, 52, .76), rgba(23, 45, 96, .42)), url('{banners.heroImage}'){{{end}}}">
				<div>
					<p class="eyebrow">{banners.heroEyebrow}</p>
					<h1>{banners.heroTitle}</h1>
					<p>{banners.heroSubtitle}</p>
				</div>
				<a href="{banners.heroCtaLink}">{banners.heroCtaText}</a>
			</section>


			<section class="opzohub-stats" aria-label="社区统计">
				<article><span>优质内容</span><strong>{stats.posts}</strong><em>篇</em></article>
				<article><span>活跃用户</span><strong>{stats.users}</strong><em>位</em></article>
				<article><span>主题讨论</span><strong>{stats.topics}</strong><em>条</em></article>
				<article><span>今日新增</span><strong>{stats.today}</strong><em>篇</em></article>
			</section>

			<section class="opzohub-section pick-section">
				<div class="section-head">
					<div><h2>编辑精选</h2><span>Editor's Picks</span></div>
					<a href="{config.relative_path}/popular">查看全部 &gt;</a>
				</div>
				{{{if hasFeaturedTopics}}}
				<div class="pick-grid">
					{{{each featuredTopics}}}
					<a class="pick-card {featuredTopics.accent}" href="{featuredTopics.url}">
						<div class="pick-cover {{{if featuredTopics.thumbUrl}}}has-thumb{{{end}}}" style="{{{if featuredTopics.thumbUrl}}}background-image:url('{featuredTopics.thumbUrl}'){{{end}}}"></div>
						<div class="pick-body">
							<span>{featuredTopics.categoryName}</span>
							<h3>{featuredTopics.title}</h3>
							<footer><b>{featuredTopics.username}</b><em><i class="fa fa-eye"></i> {featuredTopics.views} <i class="fa fa-comment"></i> {featuredTopics.replies}</em></footer>
						</div>
					</a>
					{{{end}}}
				</div>
				{{{else}}}
				<div class="opzohub-empty">暂无编辑精选，发布内容后会自动展示热门主题</div>
				{{{end}}}
			</section>

			<section class="opzohub-section latest-section">
				<div class="section-head tabs-head">
					<div><h2>最新帖子</h2><span>Latest Posts</span></div>
					<nav role="tablist"><button class="active" type="button" data-opzo-tab="replies" data-opzo-more="{config.relative_path}/recent">最新回复</button><button type="button" data-opzo-tab="newest" data-opzo-more="{config.relative_path}/recent?sort=newest">最新发布</button><button type="button" data-opzo-tab="popular" data-opzo-more="{config.relative_path}/popular">热门</button><button type="button" data-opzo-tab="featured" data-opzo-more="{config.relative_path}/top">精华</button></nav>
				</div>
				<div class="post-list active" data-opzo-panel="replies">
					{{{if hasTopics}}}
					{{{each topics}}}
					<a class="post-row {{{if topics.pinned}}}pinned{{{end}}} {{{if topics.hot}}}hot{{{end}}}" href="{topics.url}">
						<span class="{{{if topics.pinned}}}tag{{{else}}}avatar{{{end}}}">{topics.badge}</span>
						<h3>{topics.title}</h3>
						<p>{topics.username} · {topics.date}{{{if topics.categoryName}}} · {topics.categoryName}{{{end}}}</p>
						<em>{topics.views}</em>
						<b>{topics.replies}</b>
					</a>
					{{{end}}}
					{{{else}}}<div class="opzohub-empty">暂无最新回复，发布或回复帖子后会自动出现</div>{{{end}}}
				</div>
				<div class="post-list" data-opzo-panel="newest" data-opzo-count="{newestTopics.length}">
					{{{if hasNewestTopics}}}
					{{{each newestTopics}}}
					<a class="post-row {{{if newestTopics.pinned}}}pinned{{{end}}} {{{if newestTopics.hot}}}hot{{{end}}}" href="{newestTopics.url}">
						<span class="{{{if newestTopics.pinned}}}tag{{{else}}}avatar{{{end}}}">{newestTopics.badge}</span>
						<h3>{newestTopics.title}</h3>
						<p>{newestTopics.username} · {newestTopics.date}{{{if newestTopics.categoryName}}} · {newestTopics.categoryName}{{{end}}}</p>
						<em>{newestTopics.views}</em>
						<b>{newestTopics.replies}</b>
					</a>
					{{{end}}}
					{{{else}}}<div class="opzohub-empty">暂无最新发布，创建主题后会自动出现</div>{{{end}}}
				</div>
				<div class="post-list" data-opzo-panel="popular" data-opzo-count="{popularTopics.length}">
					{{{if hasPopularTopics}}}
					{{{each popularTopics}}}
					<a class="post-row {{{if popularTopics.pinned}}}pinned{{{end}}} {{{if popularTopics.hot}}}hot{{{end}}}" href="{popularTopics.url}">
						<span class="{{{if popularTopics.pinned}}}tag{{{else}}}avatar{{{end}}}">{popularTopics.badge}</span>
						<h3>{popularTopics.title}</h3>
						<p>{popularTopics.username} · {popularTopics.date}{{{if popularTopics.categoryName}}} · {popularTopics.categoryName}{{{end}}}</p>
						<em>{popularTopics.views}</em>
						<b>{popularTopics.replies}</b>
					</a>
					{{{end}}}
					{{{else}}}<div class="opzohub-empty">暂无热门内容，有浏览和回复后会自动排序</div>{{{end}}}
				</div>
				<div class="post-list" data-opzo-panel="featured" data-opzo-count="{featuredTabTopics.length}">
					{{{if hasFeaturedTopics}}}
					{{{each featuredTabTopics}}}
					<a class="post-row {{{if featuredTabTopics.pinned}}}pinned{{{end}}} {{{if featuredTabTopics.hot}}}hot{{{end}}}" href="{featuredTabTopics.url}">
						<span class="{{{if featuredTabTopics.pinned}}}tag{{{else}}}avatar{{{end}}}">{featuredTabTopics.badge}</span>
						<h3>{featuredTabTopics.title}</h3>
						<p>{featuredTabTopics.username} · {featuredTabTopics.date}{{{if featuredTabTopics.categoryName}}} · {featuredTabTopics.categoryName}{{{end}}}</p>
						<em>{featuredTabTopics.views}</em>
						<b>{featuredTabTopics.replies}</b>
					</a>
					{{{end}}}
					{{{else}}}<div class="opzohub-empty">暂无精华内容，设置热门/高赞主题后会自动出现</div>{{{end}}}
				</div>
				<button class="more-posts" type="button" data-opzo-more-button data-opzo-feed="recent" data-opzo-api="{config.relative_path}/api/opzohub-home/more">加载更多帖子</button>
			</section>
		</main>

		<aside class="opzohub-right-rail" aria-label="侧边栏">
			<section class="opzohub-card notice-card">
				<div class="side-head"><h2>{noticeTitle}</h2><a href="{noticeUrl}">查看全部</a></div>
				{{{if hasNoticeTopics}}}
				{{{each noticeTopics}}}
				<a href="{noticeTopics.url}"><span>{noticeTopics.title}</span><em>{noticeTopics.meta}</em></a>
				{{{end}}}
				{{{else}}}<div class="opzohub-empty mini">暂无公告，发布帖子后可自动取最新内容</div>{{{end}}}
			</section>

			<section class="opzohub-card tags-card">
				<div class="side-head"><h2>今日热门标签</h2><a href="{config.relative_path}/categories">换一换</a></div>
				<div class="tag-cloud">
					{{{if hasHomeCategories}}}
				{{{each categories}}}
					<a href="{categories.url}">{categories.name} <b>{categories.topicCount}</b></a>
					{{{end}}}
				{{{else}}}<div class="opzohub-empty mini">暂无热门标签，请先创建分类</div>{{{end}}}
				</div>
			</section>

			<section class="opzohub-card users-card">
				<div class="side-head"><h2>活跃用户（本周）</h2><a href="{config.relative_path}/users">查看全部</a></div>
				{{{if hasActiveUsers}}}
				{{{each activeUsers}}}
				<a class="user-row" href="{activeUsers.url}">
					{{{if activeUsers.picture}}}<img src="{activeUsers.picture}" alt="{activeUsers.username}" />{{{else}}}<i>{activeUsers.avatarText}</i>{{{end}}}
					<span>{activeUsers.username}</span><em>{activeUsers.reputation}积分</em>
				</a>
				{{{end}}}
				{{{else}}}<div class="opzohub-empty mini">暂无活跃用户</div>{{{end}}}
			</section>


			<section class="opzohub-card resources-card">
				<div class="side-head"><h2>{resourceTitle}</h2><a href="{resourceUrl}">查看全部</a></div>
				{{{if hasResourceTopics}}}
				{{{each resourceTopics}}}
				<a href="{resourceTopics.url}"><span>{resourceTopics.title}</span><em>{resourceTopics.meta}</em><b><i class="fa fa-arrow-right"></i></b></a>
				{{{end}}}
				{{{else}}}<div class="opzohub-empty mini">暂无资源推荐，发布主题后自动展示</div>{{{end}}}
			</section>

			<section class="opzohub-card events-card">
				<div class="side-head"><h2>{eventTitle}</h2><a href="{eventUrl}">查看全部</a></div>
				{{{if hasEventTopics}}}
				{{{each eventTopics}}}
				<article><a href="{eventTopics.url}"><span>{eventTopics.title}</span><p>{eventTopics.meta}</p><em>{eventTitle}</em></a></article>
				{{{end}}}
				{{{else}}}<div class="opzohub-empty mini">暂无近期活动</div>{{{end}}}
				<a class="vip-card" href="{banners.vipLink}"><b>{banners.vipTitle}</b><small>{banners.vipDesc}</small></a>
			</section>
		</aside>
	</div>
</section>

<script>
(function () {
	const root = document.querySelector('.opzohub-home');
	if (!root) { return; }
	const moreButton = root.querySelector('[data-opzo-more-button]');
	function activePanel() {
		return root.querySelector('[data-opzo-panel].active');
	}
	function renderTopic(topic) {
		const a = document.createElement('a');
		a.className = 'post-row' + (topic.pinned ? ' pinned' : '') + (topic.hot ? ' hot' : '');
		a.href = topic.url || '#';
		const badge = document.createElement('span');
		badge.className = topic.pinned ? 'tag' : 'avatar';
		badge.textContent = topic.badge || (topic.username || '?').slice(0, 1).toUpperCase();
		const title = document.createElement('h3');
		title.textContent = topic.title || '未命名主题';
		const meta = document.createElement('p');
		meta.textContent = [topic.username, topic.date, topic.categoryName].filter(Boolean).join(' · ');
		const views = document.createElement('em');
		views.textContent = topic.views || '0';
		const replies = document.createElement('b');
		replies.textContent = topic.replies || '0';
		a.append(badge, title, meta, views, replies);
		return a;
	}
	function setMoreState(text, disabled) {
		if (!moreButton) { return; }
		moreButton.textContent = text;
		moreButton.disabled = !!disabled;
		moreButton.classList.toggle('is-disabled', !!disabled);
	}
	root.querySelectorAll('[data-opzo-tab]').forEach((button) => {
		button.addEventListener('click', () => {
			const name = button.getAttribute('data-opzo-tab');
			root.querySelectorAll('[data-opzo-tab]').forEach(item => item.classList.toggle('active', item === button));
			root.querySelectorAll('[data-opzo-panel]').forEach(panel => panel.classList.toggle('active', panel.getAttribute('data-opzo-panel') === name));
			if (moreButton) {
				moreButton.setAttribute('data-opzo-feed', name);
				setMoreState(moreButton.getAttribute('data-opzo-ended') === name ? '已经到底了' : '加载更多帖子', moreButton.getAttribute('data-opzo-ended') === name);
			}
		});
	});
	if (moreButton) {
		moreButton.addEventListener('click', async () => {
			const panel = activePanel();
			if (!panel || moreButton.disabled) { return; }
			const feed = moreButton.getAttribute('data-opzo-feed') || 'recent';
			const start = parseInt(panel.getAttribute('data-opzo-count') || panel.querySelectorAll('.post-row').length, 10) || 0;
			const api = moreButton.getAttribute('data-opzo-api');
			setMoreState('加载中…', true);
			try {
				const res = await fetch(api + '?feed=' + encodeURIComponent(feed) + '&start=' + start + '&limit=10', { credentials: 'same-origin' });
				if (!res.ok) { throw new Error('HTTP ' + res.status); }
				const data = await res.json();
				(data.topics || []).forEach(topic => panel.appendChild(renderTopic(topic)));
				const nextStart = data.nextStart || (start + (data.topics || []).length);
				panel.setAttribute('data-opzo-count', nextStart);
				if (!data.hasMore || !(data.topics || []).length) {
					moreButton.setAttribute('data-opzo-ended', feed);
					setMoreState('已经到底了', true);
				} else {
					setMoreState('加载更多帖子', false);
				}
			} catch (err) {
				setMoreState('加载失败，点击重试', false);
			}
		});
	}
}());
</script>
