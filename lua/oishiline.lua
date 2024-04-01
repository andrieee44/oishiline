local function updateTbl(tblA, tblB)
	if tblB ~= nil and type(tblB) == 'table' then
		for k, v in pairs(tblB) do
			tblA[k] = v
		end
	end
end

local modules = {
	mode = function(userArgs)
		local nvimMode = vim.api.nvim_get_mode().mode

		local args = {
			sep = {
				left = ' ',
				right = ' ',
			},
		}

		local modeStr = {
			['n']     = 'NORMAL',
			['no']    = 'O-PENDING',
			['nov']   = 'O-PENDING',
			['noV']   = 'O-PENDING',
			['no\22'] = 'O-PENDING',
			['niI']   = 'NORMAL',
			['niR']   = 'NORMAL',
			['niV']   = 'NORMAL',
			['nt']    = 'NORMAL',
			['ntT']   = 'NORMAL',
			['v']     = 'VISUAL',
			['vs']    = 'VISUAL',
			['V']     = 'V-LINE',
			['Vs']    = 'V-LINE',
			['\22']   = 'V-BLOCK',
			['\22s']  = 'V-BLOCK',
			['s']     = 'SELECT',
			['S']     = 'S-LINE',
			['\19']   = 'S-BLOCK',
			['i']     = 'INSERT',
			['ic']    = 'INSERT',
			['ix']    = 'INSERT',
			['R']     = 'REPLACE',
			['Rc']    = 'REPLACE',
			['Rx']    = 'REPLACE',
			['Rv']    = 'V-REPLACE',
			['Rvc']   = 'V-REPLACE',
			['Rvx']   = 'V-REPLACE',
			['c']     = 'COMMAND',
			['cv']    = 'EX',
			['ce']    = 'EX',
			['r']     = 'REPLACE',
			['rm']    = 'MORE',
			['r?']    = 'CONFIRM',
			['!']     = 'SHELL',
			['t']     = 'TERMINAL',
		}

		updateTbl(args, userArgs)

		return table.concat({
			args.sep.left,
			modeStr[nvimMode] ~= nil and modeStr[nvimMode] or nvimMode,
			args.sep.right,
		})
	end,

	filename = function(userArgs)
		local args = {
			sep = {
				left = ' ',
				right = ' ',
			},

			fmt = '%f%w%h%m%r',
		}

		updateTbl(args, userArgs)

		return table.concat({
			args.sep.left,
			args.fmt,
			args.sep.right,
		})
	end,
}

local function statusline()
	local moduleResults = { '%#OishilineDefault#' }

	for _, v in ipairs(vim.g.oishiline.modules) do
		if type(v) == 'function' then
			moduleResults[#moduleResults + 1] = v(nil)
		elseif type(v) == 'table' then
			moduleResults[#moduleResults + 1] = v.fn(v.args)
		end
	end

	return table.concat(moduleResults)
end

local function setup(userCfg)
	local cfg = {
		defaultColors = {
			ctermfg = 'white',
			fg = 'white',
			ctermbg = 'black',
			bg = 'black',
		},

		modules = {
			modules.mode,
			modules.filename,
		},
	}

	updateTbl(cfg, userCfg)
	vim.api.nvim_set_hl(0, 'OishilineDefault', cfg.defaultColors)
	vim.g.oishiline = { modules = cfg.modules }
	vim.opt_global.statusline = "%!v:lua.require('oishiline').statusline()"
end

return {
	setup = setup,
	statusline = statusline,
	modules = modules,
}
