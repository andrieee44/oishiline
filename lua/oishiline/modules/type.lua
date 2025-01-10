return function()
	local lib = require("oishiline.modules.lib")
	local type, hasDevicons, oldBasename, oldIcon
	local M = {}

	function M.init(globalArgs, moduleArgs)
		local colors = globalArgs.colors
		hasDevicons = vim.opt.termguicolors._value and package.loaded["nvim-web-devicons"]

		local dataHl = {
			fg = colors.lightgray,
			bg = colors.darkgray,
			ctermfg = 7,
			ctermbg = 8,
		}

		type = lib.stdModule(string.format("Type%s", moduleArgs.suffix or ""), moduleArgs, {
			leftPad = lib.pad,
			icon = lib.empty,
			rightPad = lib.pad,
			rightSep = lib.empty,
			leftSepHl = dataHl,
			leftSepHlAlt = dataHl,
			iconHl = dataHl,
			iconHlAlt = dataHl,
			dataHl = dataHl,
			dataHlAlt = dataHl,
			rightSepHl = dataHl,
			rightSepHlAlt = dataHl,

			leftSep = {
				gui = "",
				tty = "|",
			},
		})
	end

	function M.run()
		local icon
		local ft = vim.bo.filetype

		if ft == "" then
			return ""
		end

		if hasDevicons then
			local basename = string.gsub(vim.api.nvim_buf_get_name(0), ".*/", "")

			if icon and basename == oldBasename then
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
end
