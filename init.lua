vim.o.rtp = vim.o.rtp .. ",."
vim.opt.termguicolors = vim.env.XDG_SESSION_TYPE ~= "tty"
vim.opt.showtabline = 2;
require("oishiline").setup()
