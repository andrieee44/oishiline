return function(colors)
	local lib = require('modules.lib')
	local module = 'Location'

	local fmt = lib.mkHlStr(' %P', lib.hlName(module, 'Fmt'), {
		fg = colors.black,
		bg = colors.cyan,
		bold = true,
	})

	return function()
		return string.format('%s %s', lib.colorStr(fmt.str, fmt), lib.gui('', '|'))
	end
end
