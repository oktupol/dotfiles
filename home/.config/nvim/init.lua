local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	"RRethy/nvim-base16",
	"nvim-lualine/lualine.nvim",
	"nvim-tree/nvim-web-devicons",
	"fladson/vim-kitty",
})

require('common')
require('neovide')

if vim.g.neovide then
	vim.api.nvim_set_option("background", "dark")
	vim.cmd("colorscheme base16-monokai")
else
	vim.api.nvim_set_option("background", "dark")
	vim.cmd("colorscheme vim")
end

if vim.env.TERM ~= "linux" or vim.g.neovide then
	require('lualine').setup()
end
