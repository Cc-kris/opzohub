<section class="opzohub-home" aria-label="opzohub homepage">
	<header class="opzohub-topbar">
		<a class="opzohub-logo" href="{config.relative_path}/">
			<span class="opzohub-logo-dot"></span>
			<span>opzohub</span>
		</a>
		<nav class="opzohub-main-nav" aria-label="Primary">
			<a class="active" href="{config.relative_path}/">首页</a>
			<a href="{config.relative_path}/categories">板块</a>
			<a href="{config.relative_path}/recent">最新</a>
			<a href="{config.relative_path}/popular">热门</a>
			<a href="{config.relative_path}/tags">标签</a>
		</nav>
		<form class="opzohub-search" action="{config.relative_path}/search" method="get">
			<i class="fa fa-search"></i>
			<input name="term" type="search" placeholder="搜索 AI、亚马逊、Codex 话题" />
		</form>
		<a class="opzohub-post-btn" href="{config.relative_path}/compose"><i class="fa fa-pen"></i><span>发布话题</span></a>
	</header>

	<section class="opzohub-hero">
		<div class="hero-copy">
			<span class="hero-kicker">AI · Amazon · Codex · Global Growth</span>
			<h1>连接正在用 AI 和自动化改变生意的人</h1>
			<p>opzohub 汇聚最新 AI 资讯、跨境电商实战、Codex 工作流和出海增长经验，让每一次讨论都变成可执行的方案。</p>
			<div class="hero-actions">
				<a class="primary" href="{config.relative_path}/register">加入社区</a>
				<a class="secondary" href="{config.relative_path}/recent">浏览最新话题</a>
			</div>
		</div>
		<div class="hero-panel">
			<div class="hero-panel-head"><span>社区实时数据</span><b>Live</b></div>
			<div class="hero-stats">
				<article><strong>{stats.topics}</strong><span>主题</span></article>
				<article><strong>{stats.posts}</strong><span>帖子</span></article>
				<article><strong>{stats.users}</strong><span>成员</span></article>
			</div>
			<div class="hero-live-list">
				{{{each featuredTopics}}}
				<a href="{featuredTopics.url}"><em>{featuredTopics.categoryName}</em><span>{featuredTopics.title}</span></a>
				{{{end}}}
			</div>
		</div>
	</section>

	<div class="opzohub-layout">
		<main class="opzohub-main-column">
			<section class="opzohub-card quick-picks">
				<div class="section-head">
					<div><span>精选板块</span><h2>从你关心的方向开始</h2></div>
					<a href="{config.relative_path}/categories">全部板块</a>
				</div>
				<div class="pick-grid">
					{{{each categories}}}
					<a class="pick-card {categories.accent}" href="{categories.url}">
						<span><i class="fa {categories.icon}"></i></span>
						<h3>{categories.name}</h3>
						<p>{categories.description}</p>
						<footer><em>{categories.topicCount} 主题</em><em>{categories.postCount} 帖子</em></footer>
					</a>
					{{{end}}}
				</div>
			</section>

			<section class="opzohub-card topic-feed">
				<div class="section-head tabs-head">
					<div><span>社区讨论</span><h2>最新话题</h2></div>
					<nav><a class="active" href="{config.relative_path}/recent">最新</a><a href="{config.relative_path}/popular">热门</a><a href="{config.relative_path}/unread">未读</a></nav>
				</div>
				<div class="post-list">
					{{{each topics}}}
					<a class="post-row {{{if topics.pinned}}}pinned{{{end}}} {{{if topics.hot}}}hot{{{end}}}" href="{topics.url}">
						<span class="tag">{topics.badge}</span>
						<h3>{topics.title}</h3>
						<p>{topics.categoryName} · {topics.username} · {topics.date}</p>
						<em>{topics.views}</em>
						<b>{topics.replies}</b>
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
				<div class="side-head"><h2>热门板块</h2><a href="{config.relative_path}/categories">全部</a></div>
				<div class="tag-cloud">
					{{{each categories}}}
					<a href="{categories.url}">{categories.name} <b>{categories.topicCount}</b></a>
					{{{end}}}
				</div>
			</section>

			<section class="opzohub-card users-card">
				<div class="side-head"><h2>活跃用户</h2><a href="{config.relative_path}/users">查看全部</a></div>
				{{{each activeUsers}}}
				<a class="user-row" href="{activeUsers.url}">
					{{{if activeUsers.picture}}}<img src="{activeUsers.picture}" alt="{activeUsers.username}" />{{{else}}}<i>{activeUsers.avatarText}</i>{{{end}}}
					<span>{activeUsers.username}</span><em>{activeUsers.reputation} 声望</em>
				</a>
				{{{end}}}
			</section>

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
