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

		local modules = {
			mode = require('modules.mode'),
			filename = require('modules.filename'),
		}

		local cfg = {
			modules = args.modules or {
				{ module = 'filename' },
				{ module = 'mode' },
			},
		}

		for i, v in ipairs(cfg.modules) do
			oishiline.modules[i] = modules[v.module](v.args)
		end

		vim.g.oishiline = oishiline
		vim.opt_global.statusline = '%!v:lua.require(\'oishiline\').statusline()'
	end,
}
