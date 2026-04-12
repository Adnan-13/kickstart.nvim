-- Disable Node provider to silence health check warnings since it's not needed for this stack
-- Community standard way to silence provider warnings in internal config
vim.g.loaded_node_provider = 0
