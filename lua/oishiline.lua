return {
	statusline = function()
		local results = {}

		for i, v in ipairs(vim.g.oishiline) do
			results[i] = v()
		end

		return table.concat(results)
	end,

	setup = function(args)
		args = args or {}
		local oishiline = {}

		local modules = args.modules or {
			{ 'mode' },
			{ 'branch' },
			--{ 'filename' },
			--{ 'diff' },
			--{ 'progress' },
			--{ 'location' },
			--{ 'encoding' },
			--{ 'format' },
			--{ 'type' },
		}

		for i, v in ipairs(modules) do
			oishiline[i] = require(string.format('modules.%s', v[1]))(v[2])
		end

		vim.g.oishiline = oishiline
		vim.opt_global.statusline = '%{%v:lua.require(\'oishiline\').statusline()%}'
	end,
}
