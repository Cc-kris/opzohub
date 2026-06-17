<section class="opzohub-home" aria-label="opzohub homepage">
	<div class="opzohub-shell">
		<header class="opzohub-nav">
			<a class="opzohub-brand" href="{config.relative_path}/">
				<span class="opzohub-mark">O</span>
				<span>opzohub</span>
			</a>
			<nav class="opzohub-links" aria-label="Primary">
				<a href="{config.relative_path}/categories?forumHome=1">论坛</a>
				<a href="{config.relative_path}/recent">最新</a>
				<a href="{config.relative_path}/popular">热门</a>
				<a href="{config.relative_path}/tags">标签</a>
			</nav>
			<div class="opzohub-actions">
				<a class="opzohub-link-btn" href="{config.relative_path}/login">登录</a>
				<a class="opzohub-cta" href="{config.relative_path}/register">加入社区</a>
			</div>
		</header>

		<section class="opzohub-hero">
			<div class="opzohub-hero-copy">
				<p class="opzohub-eyebrow">AI · Amazon · Codex · Growth</p>
				<h1>面向 AI 时代的跨境与自动化知识社区</h1>
				<p class="opzohub-subtitle">opzohub 汇聚 AI 资讯、亚马逊运营、Codex 自动化和出海增长实战，让每一次讨论都沉淀为可复用的方法。</p>
				<div class="opzohub-hero-actions">
					<a class="opzohub-primary" href="{config.relative_path}/categories?forumHome=1">浏览全部话题</a>
					<a class="opzohub-secondary" href="{config.relative_path}/recent">查看最新动态</a>
				</div>
			</div>
			<div class="opzohub-hero-card" aria-hidden="true">
				<div class="opzohub-card-top"><span></span><span></span><span></span></div>
				<div class="opzohub-metric"><b>AI Radar</b><em>模型与工具更新</em></div>
				<div class="opzohub-metric"><b>Amazon Ops</b><em>选品 / 广告 / Listing</em></div>
				<div class="opzohub-metric"><b>Codex Lab</b><em>Agent 工作流复盘</em></div>
			</div>
		</section>

		<section class="opzohub-feature-grid">
			{{{ each features }}}
			<article class="opzohub-feature-card">
				<i class="fa {./icon}"></i>
				<h2>{./title}</h2>
				<p>{./text}</p>
			</article>
			{{{ end }}}
		</section>

		<section class="opzohub-board">
			<div class="opzohub-board-head">
				<p class="opzohub-eyebrow">Community Highlights</p>
				<h2>今日值得加入讨论的方向</h2>
			</div>
			<div class="opzohub-spotlights">
				{{{ each spotlights }}}
				<article class="opzohub-spotlight">
					<span>{./label}</span>
					<h3>{./title}</h3>
					<p>{./text}</p>
				</article>
				{{{ end }}}
			</div>
		</section>

		<footer class="opzohub-footer">
			<span>opzohub</span>
			<p>连接 AI 工具、跨境运营者与自动化实践者。</p>
			<a href="{config.relative_path}/categories?forumHome=1">进入论坛 →</a>
		</footer>
	</div>
</section>
