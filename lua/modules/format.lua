return function(_)
	local lib = require('modules.lib')

	local icons = {
		unix = lib.gui('', 'unix'),
		dos = lib.gui('', 'dos'),
		mac = lib.gui('', 'mac'),
	}

	return function()
		local icon = icons[vim.bo.fileformat] or vim.bo.fileformat

		return string.format(' %s %s', icon, lib.gui('', '|'))
	end
end
