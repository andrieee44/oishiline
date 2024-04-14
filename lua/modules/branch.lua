return function(colors)
	local lib = require('modules.lib')
	local module = 'Branch'

	local fmt = lib.mkHl(lib.hlName(module, 'Fmt'), {
		fg = colors.black,
		bg = colors.cyan,
		bold = true,
	}, {
		fg = colors.white,
		bg = colors.brightBlack,
	})

	return function()
		local path = string.match(vim.api.nvim_buf_get_name(0), '.*/')
		local cmd = string.format('git -C \'%s\' branch --show-current 2> /dev/null', path)
		local branch = lib.run(cmd)

		if branch == nil then
			return ''
		end

		return string.format(' %s %s', lib.colorStr(branch, fmt), lib.colorStr(lib.gui('', '|'), fmt))
	end
end
