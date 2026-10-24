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

		-- 2. 【核心】自动设定“保底最小尺寸”
		-- 当网页输入框太小时，唤起瞬间自动将它撑大到至少 15 行高、85 列宽
		vim.api.nvim_create_autocmd({ "UIEnter" }, {
			callback = function()
				if vim.o.lines < 15 then
					vim.o.lines = 15
				end
				if vim.o.columns < 85 then
					vim.o.columns = 85
				end
			end,
		})

		-- 3. 【体验进阶】随着你打字输入，自动向下长高（打满后自动扩容）
		vim.api.nvim_create_autocmd({ "TextChanged", "TextChangedI" }, {
			callback = function()
				local line_count = vim.api.nvim_buf_line_count(0)
				-- 随着文本增多逐渐扩大，最大撑到 35 行
				if line_count >= vim.o.lines and vim.o.lines < 35 then
					vim.o.lines = line_count + 2
				end
			end,
		})

		-- 4. 【手动伸缩快捷键】键盘流随心调节
		-- 按 <C-Up> / <C-Down> 动态加减 5 行高度
		vim.keymap.set("n", "<C-Up>", function()
			vim.o.lines = vim.o.lines + 5
		end, { desc = "Increase Firenvim height" })

		vim.keymap.set("n", "<C-Down>", function()
			vim.o.lines = math.max(vim.o.lines - 5, 8)
		end, { desc = "Decrease Firenvim height" })

		-- 一键大视窗（比如写长篇 PR 或代码时直接变大）
		vim.keymap.set("n", "<leader>m", function()
			vim.o.lines = 30
			vim.o.columns = 110
		end, { desc = "Expand Firenvim window" })

		-- 1. 创建专门的文件类型自动识别组
		local ft_group = vim.api.nvim_create_augroup("FirenvimFiletypes", { clear = true })

		-- GitHub / GitLab / Reddit / 各大论坛：一律识别为 Markdown
		vim.api.nvim_create_autocmd("BufEnter", {
			group = ft_group,
			pattern = {
				"github.com_*.txt",
				"gitlab.com_*.txt",
				"reddit.com_*.txt",
				"stackoverflow.com_*.txt",
				"v2ex.com_*.txt",
			},
			callback = function()
				vim.bo.filetype = "markdown"
			end,
		})

		-- Overleaf：识别为 LaTeX
		vim.api.nvim_create_autocmd("BufEnter", {
			group = ft_group,
			pattern = "overleaf.com_*.txt",
			callback = function()
				vim.bo.filetype = "tex"
			end,
		})

		-- 如果是纯文本类型，默认升级为 markdown 语法高亮
		vim.api.nvim_create_autocmd("BufEnter", {
			group = ft_group,
			pattern = "*",
			callback = function()
				if vim.bo.filetype == "text" or vim.bo.filetype == "" then
					vim.bo.filetype = "markdown"
				end
			end,
		})

		-- 快捷键：连按两次 Esc 将焦点交还给浏览器页面 / Vimium C
		vim.keymap.set("n", "<Esc><Esc>", ":call firenvim#focus_page()<CR>", { silent = true })
	end
end
