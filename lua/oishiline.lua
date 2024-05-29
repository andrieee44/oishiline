return {
	statusline = function()
		local results = {}
		local i = 1

		for _, v in ipairs(vim.g.oishiline.leftModules) do
			results[i] = v()
			i = i + 1
		end

		results[i] = '%=%('
		i = i + 1

		for _, v in ipairs(vim.g.oishiline.rightModules) do
			results[i] = v()
			i = i + 1
		end

		results[i] = '%)'

		return table.concat(results)
	end,

	setup = function(args)
		args = args or {}

		local oishiline = {
			leftModules = {},
			rightModules = {},
		}

		local leftModules = args.leftModules or {
			'mode',
			'branch',
			'filename',
			'diagnostics',
		}

		local rightModules = args.rightModules or {
			'encoding',
			'format',
			'type',
			'progress',
			'location',
		}

		local colors = args.colors or {
			black = "#24283b",
			red = "#c0caf5",
			green = "#9ece6a",
			yellow = "#0db9d7",
			blue = "#2ac3de",
			magenta = "#bb9af7",
			cyan = "#b4f9f8",
			white = "#a9b1d6",
			brightblack = "#444b6a",
			brightred = "#c0caf5",
			brightgreen = "#9ece6a",
			brightyellow = "#0db9d7",
			brightblue = "#2ac3de",
			brightmagenta = "#bb9af7",
			brightcyan = "#b4f9f8",
			brightwhite = "#d5d6db",
		}

		for i, v in ipairs(leftModules) do
			oishiline.leftModules[i] = require(string.format('oishiline.modules.%s', v))(colors)
		end

		for i, v in ipairs(rightModules) do
			oishiline.rightModules[i] = require(string.format('oishiline.modules.%s', v))(colors)
		end

		vim.g.oishiline = oishiline
		vim.opt_global.statusline = '%{%v:lua.require(\'oishiline\').statusline()%}'
	end,
}
