<section class="opzohub-home" aria-label="opzohub homepage">
	<header class="opzohub-topbar">
		<a class="opzohub-logo" href="{config.relative_path}/" aria-label="{brand.logoAlt}">
			{{{if brand.logo}}}
			<img src="{brand.logo}" alt="{brand.logoAlt}" />
			{{{else}}}
			<span class="opzohub-logo-dot"></span>
			<span>{brand.title}</span>
			{{{end}}}
		</a>
		<nav class="opzohub-main-nav" aria-label="Primary">
			<a class="active" href="{config.relative_path}/">首页</a>
			<a href="{config.relative_path}/recent">AI新闻</a>
			<a href="{config.relative_path}/tags">AI技巧</a>
			<a href="{config.relative_path}/categories?forumHome=1">跨境电商</a>
			<a href="{config.relative_path}/categories?forumHome=1">独立站</a>
			<a href="{config.relative_path}/categories?forumHome=1">亚马逊</a>
			<a href="{config.relative_path}/tags">资源导航</a>
			<a href="{config.relative_path}/categories?forumHome=1">社区</a>
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
				<a class="channel active" href="{config.relative_path}/recent"><i class="fa fa-bolt"></i><span>AI新闻</span><em>NEW</em></a>
				<a class="channel" href="{config.relative_path}/categories?forumHome=1"><i class="fa fa-chart-line"></i><span>行业动态</span></a>
				<a class="channel" href="{config.relative_path}/categories?forumHome=1"><i class="fa fa-building"></i><span>企业动态</span></a>
				<a class="channel" href="{config.relative_path}/categories?forumHome=1"><i class="fa fa-scale-balanced"></i><span>政策法规</span></a>
				<a class="channel" href="{config.relative_path}/tags"><i class="fa fa-wand-magic-sparkles"></i><span>AI技巧与工具</span></a>
				<a class="channel" href="{config.relative_path}/tags"><i class="fa fa-comment-dots"></i><span>Prompt技巧</span></a>
				<a class="channel" href="{config.relative_path}/categories?forumHome=1"><i class="fa fa-robot"></i><span>自动化工具</span></a>
				<a class="channel" href="{config.relative_path}/categories?forumHome=1"><i class="fa fa-diagram-project"></i><span>工作流</span></a>
				<a class="channel" href="{config.relative_path}/categories?forumHome=1"><i class="fa fa-plug"></i><span>AI插件</span></a>
			</section>

			<section class="opzohub-card channel-card commerce-card">
				{{{each homeCategories}}}
				<a class="channel" href="{homeCategories.url}"><i class="fa {homeCategories.icon}"></i><span>{homeCategories.name}</span></a>
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
				<a href="{config.relative_path}/register">立即加入</a>
			</section>

			<a class="opzohub-banner-slot {{{if banners.mainBannerImage}}}has-image{{{end}}}" href="{banners.mainBannerLink}" aria-label="首页横幅广告位">
				{{{if banners.mainBannerImage}}}<img src="{banners.mainBannerImage}" alt="首页横幅广告" />{{{else}}}<span>Banner 广告位</span><em>可接后台配置或插件投放</em>{{{end}}}
			</a>

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
			</section>

			<section class="opzohub-section latest-section">
				<div class="section-head tabs-head">
					<div><h2>最新帖子</h2><span>Latest Posts</span></div>
					<nav role="tablist"><button class="active" type="button" data-opzo-tab="replies">最新回复</button><button type="button" data-opzo-tab="newest">最新发布</button><a href="{config.relative_path}/popular">热门</a><a href="{config.relative_path}/popular">精华</a></nav>
				</div>
				<div class="post-list active" data-opzo-panel="replies">
					{{{each topics}}}
					<a class="post-row {{{if topics.pinned}}}pinned{{{end}}} {{{if topics.hot}}}hot{{{end}}}" href="{topics.url}">
						<span class="{{{if topics.pinned}}}tag{{{else}}}avatar{{{end}}}">{topics.badge}</span>
						<h3>{topics.title}</h3>
						<p>{topics.username} · {topics.date}{{{if topics.categoryName}}} · {topics.categoryName}{{{end}}}</p>
						<em>{topics.views}</em>
						<b>{topics.replies}</b>
					</a>
					{{{end}}}
				</div>
				<div class="post-list" data-opzo-panel="newest">
					{{{each newestTopics}}}
					<a class="post-row {{{if newestTopics.pinned}}}pinned{{{end}}} {{{if newestTopics.hot}}}hot{{{end}}}" href="{newestTopics.url}">
						<span class="{{{if newestTopics.pinned}}}tag{{{else}}}avatar{{{end}}}">{newestTopics.badge}</span>
						<h3>{newestTopics.title}</h3>
						<p>{newestTopics.username} · {newestTopics.date}{{{if newestTopics.categoryName}}} · {newestTopics.categoryName}{{{end}}}</p>
						<em>{newestTopics.views}</em>
						<b>{newestTopics.replies}</b>
					</a>
					{{{end}}}
				</div>
				<a class="more-posts" href="{config.relative_path}/recent">加载更多帖子</a>
			</section>
		</main>

		<aside class="opzohub-right-rail" aria-label="侧边栏">
			<section class="opzohub-card notice-card">
				<div class="side-head"><h2>社区公告</h2><a href="{config.relative_path}/recent">查看全部</a></div>
				{{{each noticeTopics}}}
				<a href="{noticeTopics.url}"><span>{noticeTopics.title}</span><em>{noticeTopics.meta}</em></a>
				{{{end}}}
			</section>

			<section class="opzohub-card tags-card">
				<div class="side-head"><h2>今日热门标签</h2><a href="{config.relative_path}/categories">换一换</a></div>
				<div class="tag-cloud">
					{{{each categories}}}
					<a href="{categories.url}">{categories.name} <b>{categories.topicCount}</b></a>
					{{{end}}}
				</div>
			</section>

			<section class="opzohub-card users-card">
				<div class="side-head"><h2>活跃用户（本周）</h2><a href="{config.relative_path}/users">查看全部</a></div>
				{{{each activeUsers}}}
				<a class="user-row" href="{activeUsers.url}">
					{{{if activeUsers.picture}}}<img src="{activeUsers.picture}" alt="{activeUsers.username}" />{{{else}}}<i>{activeUsers.avatarText}</i>{{{end}}}
					<span>{activeUsers.username}</span><em>{activeUsers.reputation}积分</em>
				</a>
				{{{end}}}
			</section>

			<a class="opzohub-side-banner {{{if banners.rightBannerImage}}}has-image{{{end}}}" href="{banners.rightBannerLink}" aria-label="侧栏广告位">
				{{{if banners.rightBannerImage}}}<img src="{banners.rightBannerImage}" alt="侧栏广告" />{{{else}}}<span>侧栏 Banner 位</span><em>预留后台/插件配置</em>{{{end}}}
			</a>

			<section class="opzohub-card resources-card">
				<div class="side-head"><h2>资源推荐</h2><a href="{config.relative_path}/recent">查看全部</a></div>
				{{{each resourceTopics}}}
				<a href="{resourceTopics.url}"><span>{resourceTopics.title}</span><em>{resourceTopics.meta}</em><b><i class="fa fa-arrow-right"></i></b></a>
				{{{end}}}
			</section>

			<section class="opzohub-card events-card">
				<div class="side-head"><h2>近期活动</h2><a href="{config.relative_path}/recent">查看全部</a></div>
				{{{each eventTopics}}}
				<article><a href="{eventTopics.url}"><span>{eventTopics.title}</span><p>{eventTopics.meta}</p><em>来自社区最新讨论</em></a></article>
				{{{end}}}
				<a class="vip-card" href="{config.relative_path}/register"><b>加入opzohub VIP</b><small>解锁专属课程、会员内容与更多社区特权</small></a>
			</section>
		</aside>
	</div>
</section>

<script>
(function () {
	const root = document.querySelector('.opzohub-home');
	if (!root) { return; }
	root.querySelectorAll('[data-opzo-tab]').forEach((button) => {
		button.addEventListener('click', () => {
			const name = button.getAttribute('data-opzo-tab');
			root.querySelectorAll('[data-opzo-tab]').forEach(item => item.classList.toggle('active', item === button));
			root.querySelectorAll('[data-opzo-panel]').forEach(panel => panel.classList.toggle('active', panel.getAttribute('data-opzo-panel') === name));
		});
	});
}());
</script>
