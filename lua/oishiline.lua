local modules = {
	mode = function()
		local nvimMode = vim.api.nvim_get_mode().mode

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

		return modeStr[nvimMode] ~= nil and modeStr[nvimMode] or nvimMode
	end
}

local function statusline()
	local moduleResults = {}

	for _, v in ipairs(vim.g.oishiline.modules) do
		moduleResults[#moduleResults + 1] = v()
	end

	return table.concat(moduleResults, '')
end

local function setup(userModules)
	vim.g.oishiline = {
		modules = userModules ~= nil and userModules or {
			modules.mode,
		}
	}

	vim.opt_global.statusline = "%!v:lua.require('oishiline').statusline()"
end

return {
	setup = setup,
	statusline = statusline,
	modules = modules,
}
