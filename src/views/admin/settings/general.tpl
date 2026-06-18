<div class="acp-page-container">
	<!-- IMPORT admin/partials/settings/header.tpl -->

	<div class="row settings m-0">
		<div id="spy-container" class="col-12 col-md-8 px-0 mb-4" tabindex="0">
			<div id="site-settings" class="mb-4">
				<h5 class="fw-bold tracking-tight settings-header">[[admin/settings/general:site-settings]]
				</h5>
				<form>
					<div class="mb-3">
						<label class="form-label" for="site-title">[[admin/settings/general:title]]</label>
						<input id="site-title" class="form-control" type="text" placeholder="[[admin/settings/general:title.name]]" data-field="title" />
					</div>

					<div class="form-check form-switch mb-3">
						<input type="checkbox" class="form-check-input" id="showSiteTitle" data-field="showSiteTitle" name="showSiteTitle" />
						<label for="showSiteTitle" class="form-check-label">[[admin/settings/general:title.show-in-header]]</label>
					</div>

					<div class="mb-3">
						<label class="form-label" for="title:short">[[admin/settings/general:title.short]]</label>
						<input id="title:short" type="text" class="form-control" data-field="title:short" />
						<p class="form-text">[[admin/settings/general:title.short-placeholder]]</p>
					</div>

					<div class="mb-3">
						<label class="form-label" for="title:url">[[admin/settings/general:title.url]]</label>
						<input id ="title:url" type="text" class="form-control" data-field="title:url" />
						<p class="form-text">
							[[admin/settings/general:title.url-help]]
						</p>
					</div>

					<div class="mb-3">
						<label class="form-label" for="browserTitle">[[admin/settings/general:browser-title]]</label>
						<input id="browserTitle" class="form-control" type="text" data-field="browserTitle" />
						<p class="form-text">
							[[admin/settings/general:browser-title-help]]
						</p>
					</div>
					<div class="mb-3">
						<label class="form-label" for="titleLayout">[[admin/settings/general:title-layout]]</label>
						<input id="titleLayout" class="form-control" type="text" data-field="titleLayout" />
						<p class="form-text">
							[[admin/settings/general:title-layout-help]]
						</p>
					</div>
					<div class="mb-3">
						<label class="form-label" for="description">[[admin/settings/general:description]]</label>
						<input id="description" type="text" class="form-control" data-field="description" />
						<p class="form-text">
							[[admin/settings/general:description.placeholder]]
						</p>
					</div>
					<div class="mb-3">
						<label class="form-label" for="keywords">[[admin/settings/general:keywords]]</label>
						<input id="keywords" type="text" class="form-control" data-field="keywords" data-field-type="tagsinput" />
						<p class="form-text">[[admin/settings/general:keywords-placeholder]]</p>
					</div>

					<div class="mb-3">
						<div class="mb-2">
							<label class="form-label" for="language">[[admin/settings/general:default-language]]</label>
							<select id="language" data-field="defaultLang" class="form-select">
								{{{ each languages }}}
								<option value="{./code}" {{{ if ./selected }}}selected{{{ end }}}>{./name} ({./code})</option>
								{{{ end }}}
							</select>
						</div>
						<p class="form-text">
							[[admin/settings/general:default-language-help]]
						</p>

						<div class="">
							<div class="form-check form-switch">
								<input id="autoDetectLang" class="form-check-input" type="checkbox" data-field="autoDetectLang" {{{ if autoDetectLang }}}checked{{{ end }}}/>
								<label for="autoDetectLang" class="form-check-label">[[admin/settings/general:auto-detect]]</label>
							</div>
						</div>
					</div>
				</form>
			</div>

			<hr/>

			<div id="logo-and-icons" class="mb-4">
				<h5 class="fw-bold tracking-tight settings-header">[[admin/settings/general:logo-and-icons]]</h5>
				<div class="mb-3">
					<label class="form-label" for="logoUrl">[[admin/settings/general:logo.image]]</label>
					<div class="d-flex gap-1">
						<input id="logoUrl" type="text" class="form-control" placeholder="[[admin/settings/general:logo.image-placeholder]]" data-field="brand:logo" />

						<input data-action="upload" data-target="logoUrl" data-route="{config.relative_path}/api/admin/uploadlogo" type="button" class="btn btn-light" value="[[admin/settings/general:logo.upload]]" />
						<button data-action="removeLogo" type="button" class="btn btn-light"><i class="fa fa-trash text-danger"></i></button>
					</div>
				</div>

				<div class="mb-3">
					<label class="form-label" for="brand:logo:url">[[admin/settings/general:logo.url]]</label>
					<input id ="brand:logo:url" type="text" class="form-control" data-field="brand:logo:url" />
					<p class="form-text">
						[[admin/settings/general:logo.url-help]]
					</p>
				</div>

				<div class="mb-3">
					<label class="form-label" for="brand:logo:alt">[[admin/settings/general:logo.alt-text]]</label>
					<input id ="brand:logo:alt" type="text" class="form-control" data-field="brand:logo:alt" />
					<p class="form-text">[[admin/settings/general:log.alt-text-placeholder]]</p>
				</div>

				<div class="mb-3">
					<label class="form-label" for="og_image">og:image</label>
					<div class="d-flex gap-1">
						<input id="og_image" type="text" class="form-control" placeholder="" data-field="og:image" />

						<input data-action="upload" data-target="og_image" data-route="{config.relative_path}/api/admin/uploadOgImage" type="button" class="btn btn-light" value="[[admin/settings/general:logo.upload]]" />
						<button data-action="removeOgImage" type="button" class="btn btn-light"><i class="fa fa-trash text-danger"></i></button>
					</div>
				</div>

				<div class="mb-3">
					<label class="form-label" for="faviconUrl">[[admin/settings/general:favicon]]</label>
					<div class="d-flex gap-1">
						<input id="faviconUrl" type="text" class="form-control" placeholder="favicon.ico" data-field="brand:favicon" />

						<input data-action="upload" data-target="faviconUrl" data-route="{config.relative_path}/api/admin/uploadfavicon" data-help="0" type="button" class="btn btn-light" value="[[admin/settings/general:favicon.upload]]" />
						<button data-action="removeFavicon" type="button" class="btn btn-light"><i class="fa fa-trash text-danger"></i></button>
					</div>
				</div>

				<div class="mb-3">
					<label class="form-label" for="touchIconUrl">[[admin/settings/general:touch-icon]]</label>
					<div class="d-flex gap-1">
						<input id="touchIconUrl" type="text" class="form-control" data-field="brand:touchIcon" />
						<input data-action="upload" data-target="touchIconUrl" data-route="{config.relative_path}/api/admin/uploadTouchIcon" type="button" class="btn btn-light" value="[[admin/settings/general:touch-icon.upload]]" />
						<button data-action="removeTouchIcon" type="button" class="btn btn-light"><i class="fa fa-trash text-danger"></i></button>
					</div>
					<p class="form-text">
						[[admin/settings/general:touch-icon.help]]
					</p>
				</div>

				<div class="mb-3">
					<label class="form-label" for="maskableIconUrl">[[admin/settings/general:maskable-icon]]</label>
					<div class="d-flex gap-1">
						<input id="maskableIconUrl" type="text" class="form-control" data-field="brand:maskableIcon" />

						<input data-action="upload" data-target="maskableIconUrl" data-route="{config.relative_path}/api/admin/uploadMaskableIcon" type="button" class="btn btn-light" value="[[admin/settings/general:touch-icon.upload]]" />
						<button data-action="removeMaskableIcon" type="button" class="btn btn-light"><i class="fa fa-trash text-danger"></i></button>
					</div>
					<p class="form-text">
						[[admin/settings/general:maskable-icon.help]]
					</p>
				</div>

				<div class="mb-3">
					<label class="form-label" for="screenshotUrl">[[admin/settings/general:screenshot]]</label>
					<div class="d-flex gap-1">
						<input id="screenshotUrl" type="text" class="form-control" data-field="brand:screenshot" />

						<input data-action="upload" data-target="screenshotUrl" data-route="{config.relative_path}/api/admin/uploadScreenshot" type="button" class="btn btn-light" value="[[admin/settings/general:touch-icon.upload]]" />
						<button data-action="removeMaskableIcon" type="button" class="btn btn-light"><i class="fa fa-trash text-danger"></i></button>
					</div>
					<p class="form-text">
						[[admin/settings/general:screenshot.help]]
					</p>
				</div>
			</div>

			<hr/>

			<div id="home-page" class="mb-4">
				<h5 class="fw-bold tracking-tight settings-header">[[admin/settings/general:home-page]]</h5>

				<div class="">
					<p>
						[[admin/settings/general:home-page-description]]
					</p>
					<form class="row">
						<div class="col-sm-12">
							<div class="mb-3">
								<label class="form-label" for="homePageRoute">[[admin/settings/general:home-page-route]]</label>
								<select id="homePageRoute" class="form-select" data-field="homePageRoute">
									{{{ each routes }}}
									<option value="{./route}">{./name}</option>
									{{{ end }}}
								</select>
							</div>
							<div id="homePageCustom" class="mb-3" style="display: none;">
								<label class="form-label" for="homePageCustomInput">[[admin/settings/general:custom-route]]</label>
								<input id="homePageCustomInput" type="text" class="form-control" data-field="homePageCustom"/>
								<p class="form-text">[[user:custom-route-help]]</p>
							</div>

							<div class="form-check form-switch mb-3">
								<input class="form-check-input" type="checkbox" id="allowUserHomePage" data-field="allowUserHomePage">
								<label for="allowUserHomePage" class="form-check-label">[[admin/settings/general:allow-user-home-pages]]</label>
							</div>
							<div>
								<label class="form-label" for="homePageTitle">[[admin/settings/general:home-page-title]]</label>
								<input id="homePageTitle" class="form-control" type="text" data-field="homePageTitle">
							</div>
						</div>
					</form>
				</div>
			</div>


			<hr/>

			<div id="opzohub-home-settings" class="mb-4">
				<h5 class="fw-bold tracking-tight settings-header">OpzoHub 首页</h5>
				<p class="form-text">配置 OpzoHub 首页品牌文案、导航、频道和 Banner。列表字段每行一个，格式为：标题|链接|图标class|角标（角标可留空）。</p>

				<div class="row">
					<div class="col-sm-6 mb-3">
						<label class="form-label" for="opzohubHomeTitle">首页品牌标题</label>
						<input id="opzohubHomeTitle" type="text" class="form-control" data-field="opzohub:home:title" placeholder="OpzoHub" />
					</div>
					<div class="col-sm-6 mb-3">
						<label class="form-label" for="opzohubHomeLogo">首页 Logo URL</label>
						<input id="opzohubHomeLogo" type="text" class="form-control" data-field="opzohub:home:logo" placeholder="/assets/uploads/logo.png" />
					</div>
				</div>

				<div class="mb-3">
					<label class="form-label" for="opzohubHomeDescription">首页描述</label>
					<textarea id="opzohubHomeDescription" class="form-control" rows="2" data-field="opzohub:home:description" placeholder="社区首页描述，会作为 SEO 描述默认值"></textarea>
				</div>

				<div class="row">
					<div class="col-sm-6 mb-3">
						<label class="form-label" for="opzohubHomeSeoTitle">SEO 标题</label>
						<input id="opzohubHomeSeoTitle" type="text" class="form-control" data-field="opzohub:home:seo:title" placeholder="留空则自动使用品牌标题 + 首页描述" />
					</div>
					<div class="col-sm-6 mb-3">
						<label class="form-label" for="opzohubHomeSeoDescription">SEO 描述</label>
						<input id="opzohubHomeSeoDescription" type="text" class="form-control" data-field="opzohub:home:seo:description" placeholder="留空则使用首页描述" />
					</div>
				</div>

				<div class="row">
					<div class="col-sm-6 mb-3">
						<label class="form-label" for="opzohubHomeNav">顶部导航</label>
						<textarea id="opzohubHomeNav" class="form-control" rows="7" data-field="opzohub:home:nav" placeholder="首页|/|fa-house|\n最新|/recent|fa-bolt|NEW"></textarea>
					</div>
					<div class="col-sm-6 mb-3">
						<label class="form-label" for="opzohubHomeChannels">左侧频道</label>
						<textarea id="opzohubHomeChannels" class="form-control" rows="7" data-field="opzohub:home:channels" placeholder="最新讨论|/recent|fa-bolt|NEW\n热门主题|/popular|fa-chart-line|"></textarea>
					</div>
				</div>

				<div class="row">
					<div class="col-sm-6 mb-3">
						<label class="form-label" for="opzohubHomeHeroTitle">Hero 标题</label>
						<input id="opzohubHomeHeroTitle" type="text" class="form-control" data-field="opzohub:home:hero:title" placeholder="AI赋能增长 · 跨境创造未来" />
					</div>
					<div class="col-sm-6 mb-3">
						<label class="form-label" for="opzohubHomeHeroEyebrow">Hero 眉标</label>
						<input id="opzohubHomeHeroEyebrow" type="text" class="form-control" data-field="opzohub:home:hero:eyebrow" placeholder="AI · CROSS-BORDER · INDEPENDENT SITE" />
					</div>
				</div>

				<div class="row">
					<div class="col-sm-4 mb-3">
						<label class="form-label" for="opzohubHomeHeroImage">Hero 背景图</label>
						<input id="opzohubHomeHeroImage" type="text" class="form-control" data-field="opzohub:home:hero:image" placeholder="https://..." />
					</div>
					<div class="col-sm-4 mb-3">
						<label class="form-label" for="opzohubHomeHeroCtaText">Hero 按钮文案</label>
						<input id="opzohubHomeHeroCtaText" type="text" class="form-control" data-field="opzohub:home:hero:cta:text" placeholder="立即加入" />
					</div>
					<div class="col-sm-4 mb-3">
						<label class="form-label" for="opzohubHomeHeroCtaLink">Hero 按钮链接</label>
						<input id="opzohubHomeHeroCtaLink" type="text" class="form-control" data-field="opzohub:home:hero:cta:link" placeholder="/register" />
					</div>
				</div>

				<div class="row">
					<div class="col-sm-6 mb-3">
						<label class="form-label" for="opzohubHomeBannerTop">顶部 Banner 图片 URL</label>
						<input id="opzohubHomeBannerTop" type="text" class="form-control" data-field="opzohub:home:banner:main:image" placeholder="https://..." />
					</div>
					<div class="col-sm-6 mb-3">
						<label class="form-label" for="opzohubHomeBannerTopLink">顶部 Banner 链接</label>
						<input id="opzohubHomeBannerTopLink" type="text" class="form-control" data-field="opzohub:home:banner:main:link" placeholder="/topic/..." />
					</div>
				</div>

				<div class="row">
					<div class="col-sm-6 mb-3">
						<label class="form-label" for="opzohubHomeBannerSide">侧栏 Banner 图片 URL</label>
						<input id="opzohubHomeBannerSide" type="text" class="form-control" data-field="opzohub:home:banner:right:image" placeholder="https://..." />
					</div>
					<div class="col-sm-6 mb-3">
						<label class="form-label" for="opzohubHomeBannerSideLink">侧栏 Banner 链接</label>
						<input id="opzohubHomeBannerSideLink" type="text" class="form-control" data-field="opzohub:home:banner:right:link" placeholder="/topic/..." />
					</div>
				</div>

				<div class="row">
					<div class="col-sm-4 mb-3">
						<label class="form-label" for="opzohubHomeNoticeTitle">公告标题 / 分类</label>
						<input id="opzohubHomeNoticeTitle" type="text" class="form-control mb-2" data-field="opzohub:home:notice:title" placeholder="公告" />
						<input id="opzohubHomeNoticeCids" type="text" class="form-control mb-2" data-field="opzohub:home:notice:cids" placeholder="CID：1,2" />
						<input id="opzohubHomeNoticeTags" type="text" class="form-control mb-2" data-field="opzohub:home:notice:tags" placeholder="标签：公告,通知" />
						<select id="opzohubHomeNoticeSort" class="form-select mb-2" data-field="opzohub:home:notice:sort">
							<option value="recent">最新回复</option>
							<option value="create">最新发布</option>
							<option value="posts">最多回复</option>
							<option value="votes">最多点赞</option>
						</select>
						<p class="form-text">分类和标签都留空时使用最新回复主题。</p>
					</div>
					<div class="col-sm-4 mb-3">
						<label class="form-label" for="opzohubHomeResourceTitle">资源标题 / 分类</label>
						<input id="opzohubHomeResourceTitle" type="text" class="form-control mb-2" data-field="opzohub:home:resource:title" placeholder="资源推荐" />
						<input id="opzohubHomeResourceCids" type="text" class="form-control mb-2" data-field="opzohub:home:resource:cids" placeholder="CID：3,4" />
						<input id="opzohubHomeResourceTags" type="text" class="form-control mb-2" data-field="opzohub:home:resource:tags" placeholder="标签：资源,工具" />
						<select id="opzohubHomeResourceSort" class="form-select mb-2" data-field="opzohub:home:resource:sort">
							<option value="votes">最多点赞</option>
							<option value="posts">最多回复</option>
							<option value="recent">最新回复</option>
							<option value="create">最新发布</option>
						</select>
						<input id="opzohubHomeResourceTerm" type="text" class="form-control" data-field="opzohub:home:resource:term" placeholder="范围：daily / weekly / monthly / alltime" />
					</div>
					<div class="col-sm-4 mb-3">
						<label class="form-label" for="opzohubHomeEventTitle">活动标题 / 分类</label>
						<input id="opzohubHomeEventTitle" type="text" class="form-control mb-2" data-field="opzohub:home:event:title" placeholder="近期活动" />
						<input id="opzohubHomeEventCids" type="text" class="form-control mb-2" data-field="opzohub:home:event:cids" placeholder="CID：5" />
						<input id="opzohubHomeEventTags" type="text" class="form-control mb-2" data-field="opzohub:home:event:tags" placeholder="标签：活动,直播" />
						<select id="opzohubHomeEventSort" class="form-select" data-field="opzohub:home:event:sort">
							<option value="create">最新发布</option>
							<option value="recent">最新回复</option>
							<option value="posts">最多回复</option>
							<option value="votes">最多点赞</option>
						</select>
					</div>
				</div>

				<div class="row">
					<div class="col-sm-4 mb-3">
						<label class="form-label" for="opzohubHomeVipTitle">VIP 卡片标题</label>
						<input id="opzohubHomeVipTitle" type="text" class="form-control" data-field="opzohub:home:vip:title" placeholder="加入opzohub VIP" />
					</div>
					<div class="col-sm-4 mb-3">
						<label class="form-label" for="opzohubHomeVipDesc">VIP 卡片描述</label>
						<input id="opzohubHomeVipDesc" type="text" class="form-control" data-field="opzohub:home:vip:desc" placeholder="解锁专属课程、会员内容与更多社区特权" />
					</div>
					<div class="col-sm-4 mb-3">
						<label class="form-label" for="opzohubHomeVipLink">VIP 卡片链接</label>
						<input id="opzohubHomeVipLink" type="text" class="form-control" data-field="opzohub:home:vip:link" placeholder="/register" />
					</div>
				</div>
			</div>

			<hr/>

			<div id="search-settings" class="mb-4">
				<h5 class="fw-bold tracking-tight settings-header">[[admin/settings/general:search]]</h5>

				<div class="mb-3 d-flex justify-content-between align-items-center">
					<label class="form-label" for="searchDefaultIn">[[admin/settings/general:search-default-in]]</label>
					<select id="searchDefaultIn" class="form-select w-auto" data-field="searchDefaultIn">
						<option value="titlesposts">[[search:in-titles-posts]]</option>
						<option value="titles">[[search:in-titles]]</option>
						<option value="posts">[[search:in-posts]]</option>
						<option value="categories">[[search:in-categories]]</option>
						<option value="users">[[search:in-users]]</option>
						<option value="tags">[[search:in-tags]]</option>
					</select>
				</div>
				<div class="mb-3 d-flex justify-content-between align-items-center">
					<label class="form-label" for="searchDefaultInQuick">[[admin/settings/general:search-default-in-quick]]</label>
					<select id="searchDefaultInQuick" class="form-select w-auto" data-field="searchDefaultInQuick">
						<option value="titlesposts">[[search:in-titles-posts]]</option>
						<option value="titles">[[search:in-titles]]</option>
						<option value="posts">[[search:in-posts]]</option>
					</select>
				</div>
				<div class="mb-3 d-flex justify-content-between align-items-center">
					<label class="form-label" for="post-sort-by">[[admin/settings/general:search-default-sort-by]]</label>
					<select id="post-sort-by" class="form-select w-auto" data-field="searchDefaultSortBy">
						<option value="relevance">[[search:relevance]]</option>
						<option value="timestamp">[[search:post-time]]</option>
						<option value="votes">[[search:votes]]</option>
						<option value="topic.lastposttime">[[search:last-reply-time]]</option>
						<option value="topic.title">[[search:topic-title]]</option>
						<option value="topic.postcount">[[search:number-of-replies]]</option>
						<option value="topic.viewcount">[[search:number-of-views]]</option>
						<option value="topic.votes">[[search:topic-votes]]</option>
						<option value="topic.timestamp">[[search:topic-start-date]]</option>
						<option value="user.username">[[search:username]]</option>
						<option value="category.name">[[search:category]]</option>
					</select>
				</div>
				<div class="mb-3 d-flex justify-content-between align-items-center">
					<label class="form-label" for="userSearchResultsPerPage">[[admin/settings/user:user-search-results-per-page]]</label>
					<input id="userSearchResultsPerPage" type="text" class="form-control" value="24" data-field="userSearchResultsPerPage" style="max-width: 64px;">
				</div>
			</div>

			<hr/>

			<div id="outgoing-links" class="mb-4">
				<h5 class="fw-bold tracking-tight settings-header">[[admin/settings/general:outgoing-links]]</h5>

				<form>
					<div class="form-check form-switch mb-3">
						<input type="checkbox" class="form-check-input" id="useOutgoingLinksPage" data-field="useOutgoingLinksPage">
						<label for="useOutgoingLinksPage" class="form-check-label">[[admin/settings/general:outgoing-links.warning-page]]</label>
					</div>

					<div class="mb-3">
						<label class="form-label" for="outgoingLinks:whitelist">[[admin/settings/general:outgoing-links.whitelist]]</label>
						<input id="outgoingLinks:whitelist" type="text" class="form-control" data-field="outgoingLinks:whitelist" data-field-type="tagsinput" />
					</div>
				</form>

			</div>

			<hr/>

			<div id="site-colors" class="mb-4">
				<h5 class="fw-bold tracking-tight settings-header">[[admin/settings/general:site-colors]]</h5>

				<div class="mb-3">
					<label class="form-label" for="themeColor">[[admin/settings/general:theme-color]]</label>
					<input id="themeColor" type="text" class="form-control" placeholder="#ffffff" data-field="themeColor" />
				</div>
				<div class="mb-3">
					<label class="form-label" for="backgroundColor">[[admin/settings/general:background-color]]</label>
					<input id="backgroundColor" type="text" class="form-control" placeholder="#ffffff" data-field="backgroundColor" />
					<p class="form-text">
						[[admin/settings/general:background-color-help]]
					</p>
				</div>
			</div>

			<hr/>

			<div id="topic-tools" class="mb-4">
				<h5 class="fw-bold tracking-tight settings-header">[[admin/settings/general:topic-tools]]</h5>

				<div class="mb-3">
					<label class="form-label" for="undoTimeout">[[admin/settings/general:undo-timeout]]</label>
					<input id="undoTimeout" type="text" class="form-control" data-field="undoTimeout" />
					<p class="form-text">
						[[admin/settings/general:undo-timeout-help]]
					</p>
				</div>
			</div>

			<hr/>

			<div id="post-sharing" class="mb-4">
				<h5 class="fw-bold tracking-tight settings-header">[[admin/settings/general:post-sharing]]</h5>
				<div class="mb-3">
					<div class="form-group" id="postSharingNetworks">
						{{{ each postSharing }}}
						<div class="form-check form-switch mb-3">
							<input type="checkbox" class="form-check-input" id="{./id}" data-field="post-sharing-{./id}" name="{./id}" {{{ if ./activated }}}checked{{{ end }}} />
							<label for="{./id}" class="form-check-label">
								<i class="fa-fw {./class}"></i> {./name}
							</label>
						</div>
						{{{ end }}}
						<p class="form-text">[[admin/settings/general:info-plugins-additional]]</p>
					</div>
				</div>
			</div>
		</div>

		<!-- IMPORT admin/partials/settings/toc.tpl -->
	</div>
</div>