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

return {
	updateCfg = updateCfg,

	colorStr = function(text, name, value)
		vim.api.nvim_set_hl(0, name, value)
		return string.format('%%#%s#%s', name, text)
	end,
}
