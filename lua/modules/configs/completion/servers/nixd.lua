-- https://github.com/neovim/nvim-lspconfig/blob/master/lsp/nixd.lua
return {
	cmd = { "nixd" },
	filetypes = { "nix" },
	root_markers = { "flake.nix", ".git" },
}
