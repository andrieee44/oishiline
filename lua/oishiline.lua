function initStatusline(args)
	local oishiline = vim.g.oishiline

	local colors = args.colors
		or {
			black = "#2e3440",
			red = "#bf616a",
			green = "#a3be8c",
			yellow = "#ebcb8b",
			blue = "#81a1c1",
			magenta = "#b48ead",
			cyan = "#88c0d0",
			white = "#e5e9f0",
			brightblack = "#4c566a",
			brightred = "#bf616a",
			brightgreen = "#a3be8c",
			brightyellow = "#ebcb8b",
			brightblue = "#81a1c1",
			brightmagenta = "#b48ead",
			brightcyan = "#88c0d0",
			brightwhite = "#8fbcbb",
		}

	oishiline.statusline.leftModules = args.leftModules or {
		"mode",
		"branch",
		"filename",
		"diagnostics",
	}

	oishiline.statusline.rightModules = args.rightModules or {
		"encoding",
		"format",
		"type",
		"progress",
		"location",
	}
	
	for i, v in ipairs(oishiline.statusline.leftModules) do
		oishiline.statusline.leftModules[i] = require(string.format("oishiline.modules.%s", v))(colors)
	end

	for i, v in ipairs(oishiline.statusline.rightModules) do
		oishiline.statusline.rightModules[i] = require(string.format("oishiline.modules.%s", v))(colors)
	end

	vim.g.oishiline = oishiline
	vim.opt_global.statusline = "%{%v:lua.require('oishiline').statusline()%}"
end

function initTabline(args)
	vim.opt_global.tabline = "test"
end

return {
	statusline = function()
		local results = {}
		local i = 1

		for _, v in ipairs(vim.g.oishiline.statusline.leftModules) do
			results[i] = v()
			i = i + 1
		end

		results[i] = "%=%("
		i = i + 1

		for _, v in ipairs(vim.g.oishiline.statusline.rightModules) do
			results[i] = v()
			i = i + 1
		end

		results[i] = "%)"

		return table.concat(results)
	end,

	setup = function(args)
		args = args or {}
		args.statusline = args.statusline or {}
		args.tabline = args.tabline or {}

		vim.g.oishiline = {
			statusline = {},
			tabline = {},
		}

		if args.statusline.enable then
			initStatusline(args)
		end

		if args.tabline.enable then
			initTabline(args)
		end
	end,
}
