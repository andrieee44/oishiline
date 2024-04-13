return function(args)
	local lib = require('modules.lib')
	local module = 'Branch'

	local cfg = {
		hl = lib.mkHl(lib.hlName(module, 'Fmt'), {
			fg = 'black',
			bg = 'cyan',
			bold = true,
		}, {
			fg = 'black',
			bg = 'cyan',
		}),

		left = lib.mkHlStr(lib.pipe(''), lib.hlName(module, 'Left'), {
			fg = 'black',
			bg = 'cyan',
		}, {
			fg = 'cyan',
			bg = 'black',
		}),

		right = lib.mkHlStr(lib.space(''), lib.hlName(module, 'Right'), {
			fg = 'cyan',
			bg = 'black',
		}, {
			fg = 'cyan',
			bg = 'black',
		}),
	}

	lib.updateCfg(cfg, args or {})

	return function()
		local left = lib.colorStr(cfg.left.str, cfg.left)
		local right = lib.colorStr(cfg.right.str, cfg.right)
		local path = string.match(vim.api.nvim_buf_get_name(0), '.*/')
		local cmd = string.format('git -C \'%s\' branch --show-current 2> /dev/null', path)
		local branch = lib.run(cmd)

		if branch == nil then
			return ''
		end

		return string.format('%s %s %s', left, lib.colorStr(branch, cfg.hl), right)
	end
end
