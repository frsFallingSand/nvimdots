local lang = {}

lang["kevinhwang91/nvim-bqf"] = {
	lazy = true,
	ft = "qf",
	config = require("lang.bqf"),
	dependencies = {
		{ "junegunn/fzf", build = ":call fzf#install()" },
	},
}
lang["ray-x/go.nvim"] = {
	lazy = true,
	ft = { "go", "gomod", "gosum" },
	build = ":GoInstallBinaries",
	config = require("lang.go"),
	dependencies = "ray-x/guihua.lua",
}
lang["mrcjkb/rustaceanvim"] = {
	lazy = true,
	ft = "rust",
	version = "*",
	init = require("lang.rust"),
	dependencies = "nvim-lua/plenary.nvim",
}
lang["Saecki/crates.nvim"] = {
	lazy = true,
	event = "BufReadPost Cargo.toml",
	config = require("lang.crates"),
	dependencies = "nvim-lua/plenary.nvim",
}
lang["MeanderingProgrammer/render-markdown.nvim"] = {
	lazy = true,
	ft = { "markdown", "codecompanion" },
	config = require("lang.render-markdown"),
}
lang["iamcco/markdown-preview.nvim"] = {
	lazy = true,
	ft = "markdown",
	build = ":call mkdp#util#install()",
}
lang["chrisbra/csv.vim"] = {
	lazy = true,
	ft = "csv",
}
lang["mfussenegger/nvim-jdtls"] = {
	lazy = true,
	ft = { "java", "class" },
}
lang["AlexandrosAlexiou/kotlin.nvim"] = {
	ft = { "kotlin", "kt" },
	dependencies = {
		"mason.nvim",
		"mason-lspconfig.nvim",
		"oil.nvim",
		"trouble.nvim",
	},
	config = require("lang.kotlin"),
}
lang["oclay1st/gradle.nvim"] = {
	cmd = { "Gradle", "GradleExec", "GradleInit", "GradleFavorites" },
	dependencies = {
		"nvim-lua/plenary.nvim",
		"MunifTanjim/nui.nvim",
	},
	opts = {}, -- options, see default configuration
	keys = {
		{ "<leader>G", desc = "+Gradle", mode = { "n", "v" } },
		{ "<leader>Gg", "<cmd>Gradle<cr>", desc = "Gradle Projects" },
		{ "<leader>Gf", "<cmd>GradleFavorites<cr>", desc = "Gradle Favorite Commands" },
	},
}
return lang
