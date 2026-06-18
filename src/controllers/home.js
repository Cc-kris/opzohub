'use strict';

const plugins = require('../plugins');
const meta = require('../meta');
const user = require('../user');
const categories = require('../categories');
const topics = require('../topics');
const db = require('../database');
const helpers = require('./helpers');

const OPZOHUB_HOME_ROUTE = 'opzohub-home';

function adminHomePageRoute() {
	return ((meta.config.homePageRoute === 'custom' ? meta.config.homePageCustom : meta.config.homePageRoute) || 'categories').replace(/^\//, '');
}

async function getUserHomeRoute(uid) {
	const settings = await user.getSettings(uid);
	let route = adminHomePageRoute();

	if (settings.homePageRoute !== 'undefined' && settings.homePageRoute !== 'none') {
		route = (settings.homePageRoute || route).replace(/^\/+/, '');
	}

	return route;
}

async function rewrite(req, res, next) {
	if (req.path !== '/' && req.path !== '/api/' && req.path !== '/api') {
		return next();
	}
	let route = OPZOHUB_HOME_ROUTE;
	if (req.query && req.query.forumHome) {
		route = adminHomePageRoute();
		if (meta.config.allowUserHomePage) {
			route = await getUserHomeRoute(req.uid, next);
		}
	}

	let parsedUrl;
	try {
		parsedUrl = new URL(route, 'http://localhost.com');
	} catch (err) {
		return next(err);
	}

	const pathname = parsedUrl.pathname.replace(/^\/+/, '');
	const hook = `action:homepage.get:${pathname}`;
	if (!plugins.hooks.hasListeners(hook)) {
		req.url = req.path + (!req.path.endsWith('/') ? '/' : '') + pathname;
	} else {
		res.locals.homePageRoute = pathname;
	}
	req.query = Object.assign(Object.fromEntries(parsedUrl.searchParams), req.query);

	next();
}

exports.rewrite = rewrite;

function pluginHook(req, res, next) {
	const hook = `action:homepage.get:${res.locals.homePageRoute}`;

	plugins.hooks.fire(hook, {
		req: req,
		res: res,
		next: next,
	});
}

exports.pluginHook = pluginHook;

function compactNumber(value) {
	const number = parseInt(value, 10) || 0;
	if (number >= 10000) {
		return `${(number / 10000).toFixed(number >= 100000 ? 0 : 1)}w`;
	}
	if (number >= 1000) {
		return `${(number / 1000).toFixed(number >= 10000 ? 0 : 1)}k`;
	}
	return String(number);
}

function categoryAccent(index) {
	return ['blue', 'purple', 'pink', 'orange', 'green'][index % 5];
}

function topicBadge(topic, index) {
	if (topic && topic.pinned) {
		return '置顶';
	}
	if (index < 2) {
		return '热';
	}
	return String(index + 1).padStart(2, '0');
}

function avatarText(username) {
	return String(username || 'U').trim().slice(0, 2).toUpperCase();
}

function formatDate(value) {
	const timestamp = parseInt(value, 10);
	if (!timestamp) {
		return '刚刚';
	}
	const delta = Date.now() - timestamp;
	const day = 86400000;
	if (delta < 3600000) {
		return `${Math.max(1, Math.floor(delta / 60000))}分钟前`;
	}
	if (delta < day) {
		return `${Math.floor(delta / 3600000)}小时前`;
	}
	if (delta < day * 30) {
		return `${Math.floor(delta / day)}天前`;
	}
	const date = new Date(timestamp);
	return `${date.getMonth() + 1}-${date.getDate()}`;
}

function configValue(...keys) {
	const found = keys.map(key => meta.config[key]).find(value => value !== undefined && value !== null && String(value).trim());
	return found ? String(found).trim() : '';
}


function parseConfigList(key, fallback) {
	const value = configValue(key);
	const source = value ? value.split('\n').map(line => line.trim()).filter(Boolean) : fallback;
	return source.map((line) => {
		if (typeof line === 'object') {
			return line;
		}
		const parts = line.split('|').map(part => part.trim());
		return {
			label: parts[0] || '',
			href: parts[1] || '/',
			icon: parts[2] || 'fa-circle',
			badge: parts[3] || '',
		};
	}).filter(item => item.label);
}

function localUrl(href) {
	const value = String(href || '/').trim();
	if (/^(https?:)?\/\//i.test(value) || value.startsWith('mailto:')) {
		return value;
	}
	return `${meta.config.relative_path || ''}${value.startsWith('/') ? value : `/${value}`}`;
}

function getHomeNav() {
	return parseConfigList('opzohub:home:nav', [
		{ label: '首页', href: '/', icon: 'fa-house' },
		{ label: '最新', href: '/recent', icon: 'fa-bolt' },
		{ label: '分类', href: '/categories?forumHome=1', icon: 'fa-layer-group' },
		{ label: '标签', href: '/tags', icon: 'fa-tags' },
		{ label: '用户', href: '/users', icon: 'fa-users' },
	]).map((item, index) => ({
		label: item.label,
		url: localUrl(item.href),
		icon: item.icon,
		badge: item.badge,
		active: index === 0,
	}));
}

function getHomeChannels() {
	return parseConfigList('opzohub:home:channels', [
		{ label: '最新讨论', href: '/recent', icon: 'fa-bolt', badge: 'NEW' },
		{ label: '热门主题', href: '/popular', icon: 'fa-chart-line' },
		{ label: '精华内容', href: '/top', icon: 'fa-star' },
		{ label: '全部分类', href: '/categories?forumHome=1', icon: 'fa-layer-group' },
		{ label: '标签索引', href: '/tags', icon: 'fa-tags' },
	]).map((item, index) => ({
		label: item.label,
		url: localUrl(item.href),
		icon: item.icon,
		badge: item.badge,
		active: index === 0,
	}));
}

function listHasItems(list) {
	return Array.isArray(list) && list.length > 0;
}

function parseNumberList(value) {
	return String(value || '')
		.split(/[\n,，|]+/)
		.map(item => parseInt(item.trim(), 10))
		.filter(Number.isFinite);
}

function parseTextList(value) {
	return String(value || '')
		.split(/[\n,，|]+/)
		.map(item => item.trim())
		.filter(Boolean);
}

function getSectionConfig(section, defaults = {}) {
	return {
		title: configValue(`opzohub:home:${section}:title`) || defaults.title,
		cids: parseNumberList(configValue(`opzohub:home:${section}:cids`)),
		tags: parseTextList(configValue(`opzohub:home:${section}:tags`)),
		sort: configValue(`opzohub:home:${section}:sort`) || defaults.sort || 'recent',
		term: configValue(`opzohub:home:${section}:term`) || defaults.term || 'alltime',
	};
}

function getBrand() {
	return {
		title: configValue('opzohub:home:title', 'siteTitle', 'title') || 'opzohub',
		logo: configValue('opzohub:home:logo', 'brand:logo', 'brand:logo:url', 'logo'),
		logoAlt: configValue('opzohub:home:title', 'brand:logo:alt', 'siteTitle', 'title') || 'opzohub',
	};
}

function getHomeSeo(brand) {
	const description = configValue('opzohub:home:seo:description', 'opzohub:home:description') || 'opzohub 社区首页';
	return {
		title: configValue('opzohub:home:seo:title') || `${brand.title} - ${description}`,
		description: description,
	};
}

function getHomeBanners() {
	return {
		heroTitle: configValue('opzohub:home:hero:title') || 'AI赋能增长 · 跨境创造未来',
		heroSubtitle: configValue('opzohub:home:hero:subtitle', 'opzohub:home:description') || '聚焦AI、跨境电商与独立站的实战经验分享平台',
		heroEyebrow: configValue('opzohub:home:hero:eyebrow') || 'AI · CROSS-BORDER · INDEPENDENT SITE',
		heroImage: configValue('opzohub:home:hero:image'),
		heroCtaText: configValue('opzohub:home:hero:cta:text') || '立即加入',
		heroCtaLink: localUrl(configValue('opzohub:home:hero:cta:link') || '/register'),
		mainBannerImage: configValue('opzohub:home:banner:main:image', 'opzohub:home:banner:top'),
		mainBannerLink: localUrl(configValue('opzohub:home:banner:main:link', 'opzohub:home:banner:top:link') || '#'),
		mainBannerTitle: configValue('opzohub:home:banner:main:title') || 'Banner 广告位',
		mainBannerDesc: configValue('opzohub:home:banner:main:desc') || '可接后台配置或插件投放',
		rightBannerImage: configValue('opzohub:home:banner:right:image', 'opzohub:home:banner:side'),
		rightBannerLink: localUrl(configValue('opzohub:home:banner:right:link', 'opzohub:home:banner:side:link') || '#'),
		rightBannerTitle: configValue('opzohub:home:banner:right:title') || '侧栏 Banner 位',
		rightBannerDesc: configValue('opzohub:home:banner:right:desc') || '预留后台/插件配置',
		vipTitle: configValue('opzohub:home:vip:title') || '加入opzohub VIP',
		vipDesc: configValue('opzohub:home:vip:desc') || '解锁专属课程、会员内容与更多社区特权',
		vipLink: localUrl(configValue('opzohub:home:vip:link') || '/register'),
	};
}

function cleanCategoryName(name) {
	const value = String(name || '').trim();
	if (!value) {
		return '社区';
	}
	if (/^\[\[category:uncategorized\]\]$/i.test(value)) {
		return '未分类';
	}
	return value.replace(/^\[\[category:/i, '').replace(/\]\]$/, '') || '社区';
}

async function getHomeCategories(uid) {
	const list = await categories.getCategoriesByPrivilege('categories:cid', uid, 'find');
	return (list || [])
		.filter(Boolean)
		.filter(category => !category.disabled)
		.filter(category => cleanCategoryName(category.name) !== '未分类' && category.slug !== '../world' && category.link !== '/world')
		.slice(0, 5)
		.map((category, index) => ({
			cid: category.cid,
			name: cleanCategoryName(category.name),
			description: category.description || cleanCategoryName(category.name),
			icon: category.icon || 'fa-comments',
			url: category.link || `${meta.config.relative_path || ''}/category/${category.slug}`,
			topicCount: compactNumber(category.topic_count || category.topicCount),
			postCount: compactNumber(category.post_count || category.postCount),
			accent: categoryAccent(index),
		}));
}

async function getTopicList(uid, sort = 'recent', stop = 9, options = {}) {
	const params = {
		uid: uid,
		start: 0,
		stop: Math.max(stop, 0),
		sort: sort,
		term: options.term || 'alltime',
		query: {},
	};
	if (options.cids && options.cids.length) {
		params.cids = options.cids;
	}
	if (options.tags && options.tags.length) {
		params.tags = options.tags;
	}
	const data = await topics.getSortedTopics(params);
	let topicList = (data.topics || []).filter(Boolean).slice(0, stop + 1);
	if (options.orderBy === 'created') {
		topicList = topicList.sort((a, b) => (parseInt(b.timestamp || 0, 10) || 0) - (parseInt(a.timestamp || 0, 10) || 0));
	}
	return normalizeTopicList(topicList, stop);
}

async function getSectionTopics(uid, section, stop, fallbackTopics, defaults = {}) {
	const sectionConfig = getSectionConfig(section, defaults);
	const sectionUrl = getSectionUrl(sectionConfig);
	if (sectionConfig.cids.length || sectionConfig.tags.length) {
		const sectionTopics = await getTopicList(uid, sectionConfig.sort, stop, {
			cids: sectionConfig.cids,
			tags: sectionConfig.tags,
			term: sectionConfig.term,
		});
		return {
			title: sectionConfig.title,
			url: sectionUrl,
			topics: pickTopics(sectionTopics, 0, stop + 1),
		};
	}
	return {
		title: sectionConfig.title,
		url: sectionUrl,
		topics: pickTopics(fallbackTopics || [], 0, stop + 1),
	};
}

function getSectionUrl(sectionConfig) {
	const relativePath = meta.config.relative_path || '';
	if (sectionConfig.cids.length === 1 && !sectionConfig.tags.length) {
		return `${relativePath}/category/${sectionConfig.cids[0]}`;
	}
	if (sectionConfig.tags.length === 1 && !sectionConfig.cids.length) {
		return `${relativePath}/tags/${encodeURIComponent(sectionConfig.tags[0])}`;
	}
	return `${relativePath}/recent`;
}

function normalizeTopicList(topicList, stop = 9) {
	return (topicList || []).filter(Boolean).slice(0, stop + 1).map((topic, index) => {
		// 尝试从thumbs数组取封面图
		let thumbUrl = '';
		if (Array.isArray(topic.thumbs) && topic.thumbs.length > 0) {
			thumbUrl = topic.thumbs[0].url || topic.thumbs[0].thumb || '';
		} else if (topic.teaser && topic.teaser.content) {
			const m = String(topic.teaser.content).match(/<img[^>]+src=["']([^"']+)["']/i);
			if (m) thumbUrl = m[1];
		}
		return {
			tid: topic.tid,
			title: topic.title,
			url: `${meta.config.relative_path || ''}/topic/${topic.slug || topic.tid}`,
			categoryName: cleanCategoryName(topic.category ? topic.category.name : ''),
			categorySlug: topic.category ? (topic.category.slug || topic.category.name || '') : '',
			username: topic.user ? topic.user.username : '',
			views: compactNumber(topic.viewcount),
			replies: compactNumber(Math.max(0, (parseInt(topic.postcount, 10) || 1) - 1)),
			badge: topicBadge(topic, index),
			pinned: !!topic.pinned,
			hot: !topic.pinned && index < 2,
			accent: categoryAccent(index),
			timestamp: topic.lastposttime || topic.timestamp,
			date: formatDate(topic.lastposttime || topic.timestamp),
			thumbUrl: thumbUrl,
		};
	});
}

async function getActiveUsers() {
	const uids = await user.getUidsFromSet('users:reputation', 0, 4);
	const users = await user.getUsersFields(uids, ['uid', 'username', 'userslug', 'picture', 'reputation', 'postcount']);
	return (users || []).filter(Boolean).map(account => ({
		uid: account.uid,
		username: account.username,
		userslug: account.userslug,
		picture: account.picture,
		avatarText: avatarText(account.username),
		reputation: compactNumber(account.reputation),
		url: `${meta.config.relative_path || ''}/user/${account.userslug}`,
	}));
}

function pickTopics(topicList, start, length) {
	return topicList.slice(start, start + length).map(topic => ({
		title: topic.title,
		url: topic.url,
		accent: topic.accent,
		thumbUrl: topic.thumbUrl || '',
		categoryName: topic.categoryName || '社区',
		meta: `${topic.categoryName || '社区'} · ${topic.date}`,
	}));
}

function mergeTopicFallbacks(...lists) {
	const seen = new Set();
	const merged = [];
	(lists || []).forEach((list) => {
		(list || []).forEach((topic) => {
			const key = topic && (topic.tid || topic.url || topic.title);
			if (topic && key && !seen.has(key)) {
				seen.add(key);
				merged.push(topic);
			}
		});
	});
	return merged;
}

exports.opzohubHome = async function (req, res, next) {
	try {
		const brand = getBrand();
		const seo = getHomeSeo(brand);
		res.locals.metaTags = [{
			name: 'description',
			content: seo.description,
		}];

		const [homeCategories, recentTopics, newestTopics, popularTopics, votedTopics, activeUsers, stats] = await Promise.all([
			getHomeCategories(req.uid),
			getTopicList(req.uid, 'recent', 9),
			getTopicList(req.uid, 'create', 9),
			getTopicList(req.uid, 'posts', 9),
			getTopicList(req.uid, 'votes', 9),
			getActiveUsers(),
			db.getObjectFields('global', ['topicCount', 'postCount', 'userCount']),
		]);

		const featuredTopics = votedTopics.length ? votedTopics.slice(0, 5) : recentTopics.slice(0, 5);
		const featuredTabTopics = votedTopics.length ? votedTopics : featuredTopics;
		const noticeFallbackTopics = mergeTopicFallbacks(recentTopics, newestTopics, popularTopics);
		const resourceFallbackTopics = mergeTopicFallbacks(popularTopics, votedTopics, recentTopics, newestTopics);
		const eventFallbackTopics = mergeTopicFallbacks(newestTopics, recentTopics, popularTopics);
		const [noticeSection, resourceSection, eventSection] = await Promise.all([
			getSectionTopics(req.uid, 'notice', 2, noticeFallbackTopics.slice(0, 3), { title: '公告' }),
			getSectionTopics(req.uid, 'resource', 3, resourceFallbackTopics.slice(0, 4), { title: '资源推荐', sort: 'votes' }),
			getSectionTopics(req.uid, 'event', 1, eventFallbackTopics.slice(0, 2), { title: '近期活动', sort: 'create' }),
		]);
		const noticeTopics = noticeSection.topics;
		const resourceTopics = resourceSection.topics;
		const eventTopics = eventSection.topics;
		const banners = getHomeBanners();

		res.render('opzohub-home', {
			title: seo.title,
			bodyClasses: ['page-opzohub-home'],
			breadcrumbs: helpers.buildBreadcrumbs([{ text: 'opzohub' }]),
			brand: brand,
			banners: banners,
			navItems: getHomeNav(),
			channelItems: getHomeChannels(),
			homeCategories: homeCategories,
			topics: recentTopics,
			newestTopics: newestTopics,
			popularTopics: popularTopics,
			featuredTabTopics: featuredTabTopics,
			featuredTopics: featuredTopics,
			noticeTitle: noticeSection.title,
			noticeUrl: noticeSection.url,
			resourceTitle: resourceSection.title,
			resourceUrl: resourceSection.url,
			eventTitle: eventSection.title,
			eventUrl: eventSection.url,
			noticeTopics: noticeTopics,
			resourceTopics: resourceTopics,
			eventTopics: eventTopics,
			activeUsers: activeUsers,
			hasHomeCategories: listHasItems(homeCategories),
			hasTopics: listHasItems(recentTopics),
			hasNewestTopics: listHasItems(newestTopics),
			hasPopularTopics: listHasItems(popularTopics),
			hasFeaturedTopics: listHasItems(featuredTabTopics),
			hasNoticeTopics: listHasItems(noticeTopics),
			hasResourceTopics: listHasItems(resourceTopics),
			hasEventTopics: listHasItems(eventTopics),
			hasActiveUsers: listHasItems(activeUsers),
			stats: {
				topics: compactNumber(stats.topicCount),
				posts: compactNumber(stats.postCount),
				users: compactNumber(stats.userCount),
				today: compactNumber(recentTopics.filter(topic => (Date.now() - parseInt(topic.timestamp || 0, 10)) < 86400000).length || newestTopics.length),
			},
		});
	} catch (err) {
		next(err);
	}
};
