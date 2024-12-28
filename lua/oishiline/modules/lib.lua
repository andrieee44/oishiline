local M = {}

M.default = "%#OishilineDefault#"

function M.run(cmd)
	local stdout = io.popen(cmd)

	if stdout == nil then
		return nil
	end

	return stdout.read(stdout)
end

function M.gui(icon)
	return vim.opt.termguicolors._value and icon.gui or icon.tty
end

function M.mkHl(name, args, altArgs)
	local alt = nil

	vim.api.nvim_set_hl(0, name, args)

	if altArgs then
		alt = string.format("%s%s", name, "Alt")
		vim.api.nvim_set_hl(0, alt, altArgs)
	end

	return {
		hl = name,
		alt = alt or name,
	}
end

function M.colorStr(str, hl)
	local active = tonumber(vim.g.actual_curwin) == vim.api.nvim_get_current_win()

	return string.format("%%#%s#%s", active and hl.hl or hl.alt, str)
end

return M
