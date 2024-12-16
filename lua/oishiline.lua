return {
	statusline = function()
		local results = {}
		local i = 1

		for _, v in ipairs(vim.g.oishiline.leftModules) do
			results[i] = v()
			i = i + 1
		end

		results[i] = "%=%("
		i = i + 1

		for _, v in ipairs(vim.g.oishiline.rightModules) do
			results[i] = v()
			i = i + 1
		end

		results[i] = "%)"

		return table.concat(results)
	end,

	setup = function(args)
		args = args or {}

		local oishiline = {
			leftModules = {},
			rightModules = {},
		}

		local leftModules = args.leftModules or {
			"mode",
			"branch",
			"filename",
			"diagnostics",
		}

		local rightModules = args.rightModules
			or {
				"encoding",
				"format",
				"type",
				"progress",
				"location",
			}

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

		for i, v in ipairs(leftModules) do
			oishiline.leftModules[i] = require(string.format("oishiline.modules.%s", v))(colors)
		end

		for i, v in ipairs(rightModules) do
			oishiline.rightModules[i] = require(string.format("oishiline.modules.%s", v))(colors)
		end

		vim.g.oishiline = oishiline
		vim.opt_global.statusline = "%{%v:lua.require('oishiline').statusline()%}"
	end,
}
