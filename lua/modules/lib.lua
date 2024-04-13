local gui = vim.opt.termguicolors._value

local function updateCfg(cfg, args)
	for k, v in pairs(args) do
		if type(v) == 'table' then
			cfg[k] = cfg[k] or {}
			updateCfg(cfg[k], v)
		else
			cfg[k] = v
		end
	end
end

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
	updateCfg = updateCfg,
	mkHl = mkHl,

	run = function(cmd)
		local stdout = io.popen(cmd)

		if stdout == nil then
			return nil
		end

		return stdout.read(stdout)
	end,

	pipe = function(str)
		return gui and str or '|'
	end,

	space = function(str)
		return gui and str or ' '
	end,

	colorStr = function(str, hl)
		return string.format('%%#%s#%s', true and hl.hl or hl.alt, str)
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
