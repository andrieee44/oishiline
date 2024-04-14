return function(args)
	local lib = require('modules.lib')
	local module = 'Branch'

	local cfg = {
		hl = lib.mkHl(lib.hlName(module, 'Fmt'), {
			fg = '#2E3440',
			bg = '#88C0D0',
			bold = true,
		}, {
			fg = '#E5E9F0',
			bg = '#4C566A',
		}),

		left = lib.mkHlStr(lib.pipe(''), lib.hlName(module, 'Left'), {
			fg = '#2E3440',
			bg = '#88C0D0',
		}, {
			fg = '#E5E9F0',
			bg = '#4C566A',
		}),

		right = lib.mkHlStr(lib.space(''), lib.hlName(module, 'Right'), {
			fg = '#88C0D0',
			bg = '#2E3440',
		}, {
			fg = '#4C566A',
			bg = '#2E3440',
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
