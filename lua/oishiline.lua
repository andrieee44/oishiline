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
			bg = '#3B4252',
			altBg = '#434C5E',
			darkFg = '#4C566A',
			fg = '#D8DEE9',
			lightFg = '#E5E9F0',
			normal = '#81A1C1',
			insert = '#A3BE8C',
			visual = '#B48EAD',
			replace = '#D08770',
			command = '#81A1C1',
			terminal = '#A3BE8C',
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
