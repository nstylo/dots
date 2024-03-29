local telescope_config = require "custom.plugins.configs.telescope"
local treesitter_config = require "custom.plugins.configs.treesitter"
local nvim_tree_config = require "custom.plugins.configs.nvimtree"
local my_plugins = require "custom.plugins"

local M = {}

-- Changing theme:
M.ui = {
   theme = "gruvbox",
}

-- make sure you maintain the structure of `core/default_config.lua` here,
M.plugins = {
   install = my_plugins,
   default_plugin_config_replace = {
      telescope = telescope_config,
      nvim_treesitter = treesitter_config,
      nvim_tree = nvim_tree_config,
   },
   options = {
      lspconfig = {
         setup_lspconf = "custom.plugins.configs.lspconfig",
      },
   },
}

M.mappings = {
   terminal = {
      esc_termmode = { "<C-q>" },
      esc_hide_termmode = {},
   },
}

M.mappings.plugins = {
   comment = {
      -- underscore seems to be slash in vim world
      toggle = "<C-_>",
   },
}

return M
