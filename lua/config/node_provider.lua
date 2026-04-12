-- Dynamically detect Node.js host path
if vim.fn.executable('neovim-node-host') == 1 then
  vim.g.node_host_prog = vim.fn.exepath('neovim-node-host')
end

vim.g.loaded_node_provider = nil
