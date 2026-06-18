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

function getBrand() {
	return {
		title: configValue('siteTitle', 'title') || 'opzohub',
		logo: configValue('brand:logo', 'brand:logo:url', 'logo'),
		logoAlt: configValue('brand:logo:alt', 'siteTitle', 'title') || 'opzohub',
	};
}

function getHomeBanners() {
	return {
		heroTitle: configValue('opzohub:home:hero:title') || 'AI赋能增长 · 跨境创造未来',
		heroSubtitle: configValue('opzohub:home:hero:subtitle') || '聚焦AI、跨境电商与独立站的实战经验分享平台',
		heroEyebrow: configValue('opzohub:home:hero:eyebrow') || 'AI · CROSS-BORDER · INDEPENDENT SITE',
		heroImage: configValue('opzohub:home:hero:image'),
		mainBannerImage: configValue('opzohub:home:banner:main:image'),
		mainBannerLink: configValue('opzohub:home:banner:main:link') || '#',
		rightBannerImage: configValue('opzohub:home:banner:right:image'),
		rightBannerLink: configValue('opzohub:home:banner:right:link') || '#',
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

async function getRecentTopics(uid, sort = 'recent', stop = 9) {
	const data = await topics.getSortedTopics({
		uid: uid,
		start: 0,
		stop: stop,
		sort: sort,
		term: 'alltime',
		query: {},
	});
	return (data.topics || []).filter(Boolean).slice(0, stop + 1).map((topic, index) => {
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

exports.opzohubHome = async function (req, res, next) {
	try {
		res.locals.metaTags = [{
			name: 'description',
			content: 'opzohub 汇聚 AI 资讯、亚马逊运营、Codex 自动化与出海增长话题。',
		}];

		const [homeCategories, recentTopics, newestTopics, activeUsers, stats] = await Promise.all([
			getHomeCategories(req.uid),
			getRecentTopics(req.uid, 'recent', 9),
			getRecentTopics(req.uid, 'newest_to_oldest', 9),
			getActiveUsers(),
			db.getObjectFields('global', ['topicCount', 'postCount', 'userCount']),
		]);

		const featuredTopics = recentTopics.slice(0, 5);
		const noticeTopics = pickTopics(recentTopics, 0, 3);
		const resourceTopics = pickTopics(recentTopics, 3, 4);
		const eventTopics = pickTopics(recentTopics, 7, 2);
		const brand = getBrand();
		const banners = getHomeBanners();

		res.render('opzohub-home', {
			title: `${brand.title} - AI 与跨境增长社区`,
			bodyClasses: ['page-opzohub-home'],
			breadcrumbs: helpers.buildBreadcrumbs([{ text: 'opzohub' }]),
			brand: brand,
			banners: banners,
			homeCategories: homeCategories,
			topics: recentTopics,
			newestTopics: newestTopics,
			featuredTopics: featuredTopics,
			noticeTopics: noticeTopics,
			resourceTopics: resourceTopics,
			eventTopics: eventTopics,
			activeUsers: activeUsers,
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
