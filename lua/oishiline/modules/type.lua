local type, oldBasename, oldIcon
local M = {}
local lib = require("oishiline.modules.lib")

function M.init(globalArgs, moduleArgs)
	local colors = globalArgs.colors

	local dataHl = {
		fg = colors.lightgray,
		bg = colors.darkgray,
		ctermfg = 7,
		ctermbg = 8,
	}

	type = lib.stdModule("Type", moduleArgs, {
		leftSepHl = dataHl,
		leftSepHlAlt = dataHl,
		iconHl = dataHl,
		iconHlAlt = dataHl,
		dataHl = dataHl,
		dataHlAlt = dataHl,
		rightSepHl = dataHl,
		rightSepHlAlt = dataHl,

		leftSep = {
			gui = "",
			tty = "",
		},

		leftPad = {
			gui = " ",
			tty = " ",
		},

		icon = {
			gui = "",
			tty = "",
		},

		rightPad = {
			gui = " ",
			tty = " ",
		},

		rightSep = {
			gui = "",
			tty = "",
		},
	})
end

function M.run()
	local icon
	local ft = vim.bo.filetype

	if ft == "" then
		return ""
	end

	if vim.opt.termguicolors._value and package.loaded["nvim-web-devicons"] then
		local basename = string.gsub(vim.api.nvim_buf_get_name(0), ".*/", "")

		if basename == oldBasename then
			return lib.stdFormat(type, string.format("%s %s", oldIcon, ft))
		end

		icon = require("nvim-web-devicons").get_icon(basename, ft)
		oldBasename = basename
		oldIcon = icon
	end

	if icon ~= nil then
		ft = string.format("%s %s", icon, ft)
	end

	return lib.stdFormat(type, ft)
end

return M
