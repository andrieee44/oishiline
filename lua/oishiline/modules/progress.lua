return function(colors)
	local lib = require("oishiline.modules.lib")
	local module = "Progress"

	local fmt = lib.mkHlStr(" %P", lib.hlName(module, "Fmt"), {
		fg = colors.black,
		ctermfg = "black",
		bg = colors.blue,
		ctermbg = "darkblue",
		bold = true,
	})

	return function()
		return string.format("%s %s", lib.colorStr(fmt.str, fmt), lib.gui("", "|"))
	end
end
