local lib = require("oishiline.modules.lib")
local leftSepHl, iconHl, encodingHl, rightSepHl, leftSep, icon, rightSep

function M.init(globalArgs, moduleArgs)
	fmt = lib.mkHl("OishilineStatuslineEncodingFmt", {
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
end

function M.run()
	local left = lib.colorStr(leftSep.str, leftSep)
	local encoding = vim.bo.fileencoding

	if encoding == "" then
		return string.format("%s%s", left, lib.colorStr("", fmt))
	end

	return string.format("%s%s %s", left, lib.colorStr(string.format(" %s", encoding), fmt), lib.gui("", "|"))
end
