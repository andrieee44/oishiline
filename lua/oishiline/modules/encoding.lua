return function(colors)
	local lib = require("oishiline.modules.lib")
	local module = "Encoding"

	local fmt = lib.mkHl(lib.hlName(module, "Fmt"), {
		fg = colors.white,
		ctermfg = "lightgray",
		bg = colors.brightblack,
		ctermbg = "darkgray",
	})

	local leftSep = lib.mkHlStr(lib.gui("", ""), lib.hlName(module, "Left"), {
		fg = colors.brightblack,
		ctermfg = "darkgray",
		bg = colors.black,
		ctermbg = "black",
	})

	return function()
		local left = lib.colorStr(leftSep.str, leftSep)

		local encoding = vim.bo.fileencoding

		if encoding == "" then
			return string.format("%s%s", left, lib.colorStr("", fmt))
		end

		return string.format("%s%s %s", left, lib.colorStr(string.format(" %s", encoding), fmt), lib.gui("", "|"))
	end
end
