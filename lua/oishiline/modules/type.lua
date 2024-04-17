return function(colors)
	local lib = require('oishiline.modules.lib')
	local module = 'Type'

	local leftSep = lib.mkHlStr(lib.gui('', ''), lib.hlName(module, 'Left'), {
		fg = colors.cyan,
		ctermfg = 'cyan',
		bg = colors.brightBlack,
		ctermbg = 'black',
	})

	return function()
		local left =lib.colorStr(leftSep.str, leftSep)

		local type = vim.bo.filetype
		local icon = nil

		if type == '' then
			return left
		end

		if vim.opt.termguicolors._value and package.loaded['nvim-web-devicons'] then
			local basename = string.gsub(vim.api.nvim_buf_get_name(0), '.*/', '')

			icon = require('nvim-web-devicons').get_icon(basename, type)
		end

		if icon ~= nil then
			type = string.format('%s %s', icon, type)
		end

		return string.format('%s %s %s', lib.gui('', '|'), type, left)
	end
end
