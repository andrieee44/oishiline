vim.diagnostic.set(vim.diagnostic.get_namespace(), vim.api.nvim_get_current_buf(), {
	{
		lnum = 0,
		col = 0,
		message = "Dummy error message",
		severity = vim.diagnostic.severity.ERROR,
	},
	{
		lnum = 2,
		col = 10,
		message = "Dummy warning message",
		severity = vim.diagnostic.severity.WARN,
	},
})

vim.o.rtp = vim.o.rtp .. ",."
vim.opt.termguicolors = vim.env.XDG_SESSION_TYPE ~= "tty"
vim.opt.showtabline = 2
require("oishiline").setup()
