local branch, oldPath, branchName
local M = {}
local lib = require("oishiline.modules.lib")

function M.init(globalArgs, moduleArgs)
	local colors = globalArgs.colors

	local dataHl = {
		fg = colors.black,
		bg = colors.darkblue,
		ctermfg = 0,
		ctermbg = 4,
		bold = true,
	}

	local dataHlAlt = {
		fg = colors.lightgray,
		bg = colors.darkgray,
		ctermfg = 7,
		ctermbg = 8,
	}

	branch = lib.stdModule("Branch", moduleArgs, {
		leftSepHl = dataHl,
		iconHl = dataHl,
		iconHlAlt = dataHlAlt,
		dataHl = dataHl,
		dataHlAlt = dataHlAlt,
		rightSepHl = dataHl,
		rightSepHlAlt = dataHlAlt,

		leftSepHlAlt = {
			fg = globalArgs.default.bg,
			bg = colors.darkgray,
			ctermfg = globalArgs.default.ctermbg,
			ctermbg = 8,
		},

		leftSep = {
			gui = "",
			tty = "",
		},

		leftPad = {
			gui = " ",
			tty = " ",
		},

		icon = {
			gui = " ",
			tty = "",
		},

		rightPad = {
			gui = " ",
			tty = " ",
		},

		rightSep = {
			gui = "",
			tty = "|",
		},
	})
end

function M.run()
	local path = string.match(vim.api.nvim_buf_get_name(0), ".*/")

	if path ~= oldPath then
		branchName = lib.run(string.format("git -C '%s' branch --show-current 2> /dev/null", path))
	end

	oldPath = path

	return branchName == nil and "" or lib.stdFormat(branch, branchName)
end

return M
