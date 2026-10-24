return function()
	-- 1. Firenvim 网页规则配置
	vim.g.firenvim_config = {
		globalSettings = {
			alt = "all",
		},
		localSettings = {
			-- 默认所有网站不自动接管，只在手动触发（默认快捷键 <C-e>）时唤起
			[".*"] = {
				cmdline = "neovim",
				content = "text",
				priority = 0,
				selector = "textarea",
				takeover = "never",
			},
			-- -- 针对代码与长文网站自动唤起
			-- ["https?://github\\.com/.*"] = {
			-- 	takeover = "always",
			-- 	priority = 1,
			-- },
			-- ["https?://leetcode\\.cn/.*"] = {
			-- 	takeover = "always",
			-- 	priority = 1,
			-- },
		},
	}

	-- 2. 针对 nvimdots 华丽 UI 的“瘦身”优化（仅在浏览器内生效）
	if vim.g.started_by_firenvim == true then
		-- 隐藏状态栏和标签栏，避免小输入框过于拥挤
		vim.opt.laststatus = 0
		vim.opt.showtabline = 0
		vim.opt.ruler = false
		vim.opt.number = false
		vim.opt.relativenumber = false

		-- 浏览器文本输入必备：软换行
		vim.opt.wrap = true
		vim.opt.linebreak = true

		-- 高分屏浏览器字体缩放（根据你的系统字体调节）
		-- vim.opt.guifont = "FiraCode Nerd Font:h14"

		-- 快捷键：连按两次 Esc 将焦点交还给浏览器页面 / Vimium C
		vim.keymap.set("n", "<Esc><Esc>", ":call firenvim#focus_page()<CR>", { silent = true })
	end
end
