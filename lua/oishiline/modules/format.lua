return function(_)
	local lib = require("oishiline.modules.lib")

	local icons = {
		unix = lib.gui("", "unix"),
		dos = lib.gui("", "dos"),
		mac = lib.gui("", "mac"),
	}

	return function()
		return string.format(" %s ", icons[vim.bo.fileformat] or vim.bo.fileformat)
	end
end
