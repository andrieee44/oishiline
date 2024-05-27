return function(colors)
	local lib = require('oishiline.modules.lib')
	local module = 'Branch'

	local fmt = lib.mkHl(lib.hlName(module, 'Fmt'), {
		fg = colors.bg,
		ctermfg = 'black',
		bg = colors.normal,
		ctermbg = 'blue',
		bold = true,
	}, {
		fg = colors.lightFg,
		ctermfg = 'white',
		bg = colors.altBg,
		ctermbg = 'black',
	})

	return function()
		local path = string.match(vim.api.nvim_buf_get_name(0), '.*/')
		local cmd = string.format('git -C \'%s\' branch --show-current 2> /dev/null', path)
		local branch = lib.run(cmd)

		if branch == nil then
			return ''
		end

		return string.format(' %s%s %s', lib.colorStr(lib.gui(' ', ''), fmt), branch, lib.gui('', '|'))
	end
end
