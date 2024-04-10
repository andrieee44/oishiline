return {
	statusline = function()
		local results = {}

		for i, v in ipairs(vim.g.oishiline.modules) do
			results[i] = v.run(v)
		end

		return table.concat(results)
	end,

	setup = function(args)
		args = args or {}
		local oishiline = { modules = {} }

		local cfg = {
			modules = args.modules or {
				{ module = 'mode' },
				{ module = 'branch' },
				{ module = 'filename' },
				{ module = 'diff' },
				{ module = 'progress' },
				{ module = 'location' },
				{ module = 'encoding' },
				{ module = 'format' },
				{ module = 'type' },
			},
		}

		for i, v in ipairs(cfg.modules) do
			oishiline.modules[i] = require(string.format('modules.%s', v.module))(v.args)
		end

		vim.g.oishiline = oishiline
		vim.opt_global.statusline = '%!v:lua.require(\'oishiline\').statusline()'
	end,
}
