return {
	statusline = function()
		local results = {}

		for _, v in ipairs(vim.g.oishiline.leftModules) do
			table.insert(results, v())
		end

		table.insert(results, '%=%(')

		for _, v in ipairs(vim.g.oishiline.rightModules) do
			table.insert(results, v())
		end

		table.insert(results, '%)')

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
			black = '#2E3440',
			red = '#BF616A',
			green = '#A3BE8C',
			yellow = '#EBCB8B',
			blue = '#81A1C1',
			magenta = '#B48EAD',
			cyan = '#88C0D0',
			white = '#E5E9F0',
			brightBlack = '#4C566A',
			brightRed = '#BF616A',
			brightGreen = '#A3BE8C',
			brightYellow = '#EBCB8B',
			brightBlue = '#81A1C1',
			brightMagenta = '#B48EAD',
			brightCyan = '#88C0D0',
			brightWhite = '#8FBCBB',
		}

		for i, v in ipairs(leftModules) do
			oishiline.leftModules[i] = require(string.format('modules.%s', v))(colors)
		end

		for i, v in ipairs(rightModules) do
			oishiline.rightModules[i] = require(string.format('modules.%s', v))(colors)
		end

		vim.g.oishiline = oishiline
		vim.opt_global.statusline = '%{%v:lua.require(\'oishiline\').statusline()%}'
	end,
}
