local function mkDiagnostic(severity)
	return {
		lnum = 0,
		col = 0,
		message = "WARN",
		severity = vim.diagnostic.severity[severity],
	}
end

vim.diagnostic.set(vim.api.nvim_create_namespace("test"), 0, {
	mkDiagnostic("ERROR"),
	mkDiagnostic("WARN"),
	mkDiagnostic("INFO"),
	mkDiagnostic("HINT"),
})

vim.o.rtp = vim.o.rtp .. ",."
vim.opt.termguicolors = vim.env.XDG_SESSION_TYPE ~= "tty"
vim.opt.showtabline = 2
require("oishiline").setup()
