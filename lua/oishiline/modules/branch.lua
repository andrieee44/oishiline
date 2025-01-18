return function()
	local lib = require("oishiline.modules.lib")
	local branch, oldPath, branchName
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

		lib.print2buf({
			leftSep = lib.empty,
			leftPad = lib.pad,
			rightPad = lib.pad,
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

			icon = {
				gui = " ",
				tty = "",
			},

			rightSep = {
				gui = "",
				tty = "|",
			},
		})

		branch = lib.stdModule(string.format("Branch%s", moduleArgs.suffix or ""), moduleArgs, {
			leftSep = lib.empty,
			leftPad = lib.pad,
			rightPad = lib.pad,
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

			icon = {
				gui = " ",
				tty = "",
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
end
