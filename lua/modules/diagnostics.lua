return function(args)
	local lib = require('modules.lib')

	local cfg = {
		errorHl = {
			fg = 'yellow',
			bg = 'black',
		},

		errorSepLeft = '<',
		errorSepRight = '>',

		errorSepLeftHl = {
			fg = 'red',
			bg = 'black',
		},

		errorSepRightHl = {
			fg = 'cyan',
			bg = 'black',
		},

		warnHl = {
			fg = 'yellow',
			bg = 'black',
		},

		warnSepLeft = '<',
		warnSepRight = '>',

		warnSepLeftHl = {
			fg = 'red',
			bg = 'black',
		},

		warnSepRightHl = {
			fg = 'cyan',
			bg = 'black',
		},

		infoHl = {
			fg = 'yellow',
			bg = 'black',
		},

		infoSepLeft = '<',
		infoSepRight = '>',

		infoSepLeftHl = {
			fg = 'red',
			bg = 'black',
		},

		infoSepRightHl = {
			fg = 'cyan',
			bg = 'black',
		},

		hintHl = {
			fg = 'yellow',
			bg = 'black',
		},

		hintSepLeft = '<',
		hintSepRight = '>',

		hintSepLeftHl = {
			fg = 'red',
			bg = 'black',
		},

		hintSepRightHl = {
			fg = 'cyan',
			bg = 'black',
		},
	}

	lib.updateCfg(cfg, args or {})
	vim.api.nvim_set_hl(0, 'OishilineDiagnosticsErrorFmt', cfg.errorHl)

	local data = {
		cfg = cfg,
		errorSepLeft = lib.colorStr(cfg.errorSepLeft, 'OishilineDiagnosticsErrorLeftSep', cfg.errorSepLeftHl),
		errorSepRight = lib.colorStr(cfg.errorSepRight, 'OishilineDiagnosticsErrorRightSep', cfg.errorSepRightHl),

		run = function(data)
			local count = { 0, 0, 0, 0 }
			local diagnostics = vim.diagnostic.get(0)

			for _, v in pairs(diagnostics) do
				count[v.severity] = count[v.severity] + 1
			end

			local errors = count[vim.diagnostic.severity.ERROR]

			return string.format('%s%%#%s#%s%s', data.errorSepLeft, 'OishilineDiagnosticsErrorFmt', errors,
				data.errorSepRight)
		end,
	}

	return type(cfg.init) == 'function' and cfg.init(data) or data
end
