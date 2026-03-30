local plugin_modules = {
  'autopairs',
  'blink',
  'conform',
  'debug',
  'gitsigns',
  'guess-indent',
  'indent_line',
  'lint',
  'lspconfig',
  'mini',
  'neo-tree',
  'rainbow',
  'telescope',
  'todo-comments',
  'tokyonight',
  'treesitter',
  'ts-autotag',
  'typescript-tools',
  'which-key',
}

local specs = {}
for _, module_name in ipairs(plugin_modules) do
  local ok, module_specs = pcall(require, 'kickstart.plugins.' .. module_name)
  if not ok then
    vim.notify('Failed to load module kickstart.plugins.' .. module_name .. ': ' .. tostring(module_specs), vim.log.levels.ERROR)
  elseif type(module_specs) == 'table' then
    vim.list_extend(specs, module_specs)
  else
    vim.notify('kickstart.plugins.' .. module_name .. ' did not return a table', vim.log.levels.WARN)
  end
end

return specs
