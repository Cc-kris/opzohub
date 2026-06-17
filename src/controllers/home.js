'use strict';

const plugins = require('../plugins');
const meta = require('../meta');
const user = require('../user');
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


exports.opzohubHome = async function (req, res) {
	res.locals.metaTags = [{
		name: 'description',
		content: 'opzohub 汇聚 AI 资讯、亚马逊运营、Codex 自动化与出海增长话题。',
	}];

	res.render('opzohub-home', {
		title: 'opzohub - AI 与跨境增长社区',
		bodyClasses: ['page-opzohub-home-pixel'],
		breadcrumbs: helpers.buildBreadcrumbs([{ text: 'opzohub' }]),
		features: [
			{ icon: 'fa-bolt', title: 'AI 快讯', text: '追踪模型、产品、工具链与自动化实践的关键更新。' },
			{ icon: 'fa-store', title: '亚马逊运营', text: '拆解选品、广告、Listing 与账号安全的一线经验。' },
			{ icon: 'fa-code', title: 'Codex 实战', text: '沉淀提示词、Agent 工作流与可复制的代码方案。' },
		],
		spotlights: [
			{ label: '今日焦点', title: 'AI Agent 如何改造跨境运营', text: '从素材生成、客服答疑到竞品监控，把重复劳动交给自动化。' },
			{ label: '社区精选', title: '亚马逊新品冷启动清单', text: '围绕关键词、图片、评价与站外流量建立首周节奏。' },
			{ label: '工具箱', title: 'Codex 自动修复前端样式', text: '记录可回滚、可验证、可上线的工程协作流程。' },
		],
	});
};
