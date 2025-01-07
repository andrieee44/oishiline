return function()
	local lib = require("oishiline.modules.lib")
	local filename
	local M = {}

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

		filename = lib.stdModule(string.format("Filename%s", moduleArgs.suffix or ""), moduleArgs, {
			leftSepHl = dataHl,
			iconHl = dataHl,
			iconHlAlt = dataHlAlt,
			dataHl = dataHl,
			dataHlAlt = dataHlAlt,

			leftSepHlAlt = {
				fg = globalArgs.default.bg,
				bg = colors.lightgray,
				ctermfg = globalArgs.default.ctermbg,
				ctermbg = 7,
			},

			rightSepHl = {
				fg = colors.darkblue,
				bg = colors.black,
				ctermfg = 1,
				ctermbg = 0,
			},

			rightSepHlAlt = {
				fg = colors.darkgray,
				bg = colors.black,
				ctermfg = 8,
				ctermbg = 0,
			},

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
				gui = "",
				tty = " ",
			},
		})
	end

	function M.run()
		return lib.stdFormat(filename, "%f%( %w%h%m%r%)")
	end

	return M
end
