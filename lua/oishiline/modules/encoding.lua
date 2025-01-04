return function()
	local encoding
	local M = {}
	local lib = require("oishiline.modules.lib")

	function M.init(globalArgs, moduleArgs)
		local colors = globalArgs.colors

		local leftSepHl = {
			fg = colors.darkgray,
			bg = globalArgs.default.bg,
			ctermfg = 8,
			ctermbg = globalArgs.default.ctermbg,
		}

		local dataHl = {
			fg = colors.lightgray,
			bg = colors.darkgray,
			ctermfg = 7,
			ctermbg = 8,
		}

		encoding = lib.stdModule(string.format("Encoding%s", moduleArgs.suffix or ""), moduleArgs, {
			leftSepHl = leftSepHl,
			leftSepHlAlt = leftSepHl,
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
				gui = "",
				tty = "|",
			},
		})
	end

	function M.run()
		local enc = vim.bo.fileencoding

		return enc == "" and "" or lib.stdFormat(encoding, enc)
	end

	return M
end
