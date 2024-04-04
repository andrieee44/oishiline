local function statusline()
	local results = {}

	for i, v in ipairs(vim.g.oishiline.modules) do
		results[i] = v:run()
	end

	return table.concat(results)
end

local function setup(args)
	args = args or {}
	local oishiline = { modules = {} }

	local cfg = {
		modules = args.modules or {
			{
				module = 'filename',
				args = nil,
			},
		},
	}

	local modules = {
		filename = require('modules.filename')
	}

	for i, v in ipairs(cfg.modules) do
		module = {
			init = modules[v.module].init,
			run = modules[v.module].run,
		}

		module:init(v.args)
		oishiline.modules[i] = module
	end

	vim.g.oishiline = oishiline
	vim.opt_global.statusline = '%!v:lua.require(\'oishiline\').statusline()'
end

setup()

return {
	setup = setup,
	statusline = statusline,
}
