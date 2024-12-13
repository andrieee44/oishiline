return function(colors)
	local lib = require("oishiline.modules.lib")
	local module = "Branch"

	local fmt = lib.mkHl(lib.hlName(module, "Fmt"), {
		fg = colors.black,
		ctermfg = "black",
		bg = colors.blue,
		ctermbg = "darkblue",
		bold = true,
	}, {
		fg = colors.white,
		ctermfg = "lightgray",
		bg = colors.brightblack,
		ctermbg = "darkgray",
	})

	return function()
		local path = string.match(vim.api.nvim_buf_get_name(0), ".*/")
		local cmd = string.format("git -C '%s' branch --show-current 2> /dev/null", path)
		local branch = lib.run(cmd)

		if branch == nil then
			return ""
		end

		return string.format(" %s%s %s", lib.colorStr(lib.gui(" ", ""), fmt), branch, lib.gui("", "|"))
	end
end
