local function mkHl(name, args, altArgs)
	local alt = string.format('%s%s', name, 'Alt')

	vim.api.nvim_set_hl(0, name, args)
	vim.api.nvim_set_hl(0, alt, altArgs)

	return {
		hl = name,
		alt = alt,
	}
end

return {
	mkHl = mkHl,

	run = function(cmd)
		local stdout = io.popen(cmd)

		if stdout == nil then
			return nil
		end

		return stdout.read(stdout)
	end,

	gui = function(guiStr, str)
		return vim.opt.termguicolors._value and guiStr or str
	end,

	colorStr = function(str, hl)
		local active = tonumber(vim.g.actual_curwin) == vim.api.nvim_get_current_win()

		return string.format('%%#%s#%s', active and hl.hl or hl.alt, str)
	end,

	hlName = function(module, name)
		return string.format('Oishiline%s%s', module, name)
	end,

	mkHlStr = function(str, name, args, altArgs)
		local hl = mkHl(name, args, altArgs)

		return {
			str = str,
			hl = hl.hl,
			alt = hl.alt,
		}
	end,
}
