-- Utilities for creating configurations
local util = require("formatter.util")
local filetype = require("formatter.filetypes")

-- -- Provides the Format, FormatWrite, FormatLock, and FormatWriteLock commands
require("formatter").setup({
  -- Enable or disable logging
  logging = true,
  -- Set the log level
  log_level = vim.log.levels.WARN,
  -- All formatter configurations are opt-in
  filetype = {
    javascript = { filetype.javascript.prettier },
    typescript = { filetype.typescript.prettier },
    javascriptreact = { filetype.javascriptreact.prettier },
    typescriptreact = { filetype.typescriptreact.prettier },
    json = { filetype.json.prettier },
    rust = { filetype.rust.rustfmt },
    graphql = { filetype.graphql.prettier },
    -- Formatter configurations for filetype "lua" go here
    -- and will be executed in order
    lua = {
      -- "formatter.filetypes.lua" defines default configurations for the
      -- "lua" filetype
      filetype.lua.stylua,

      -- You can also define your own configuration
      function()
        -- Supports conditional formatting
        if util.get_current_buffer_file_name() == "special.lua" then
          return nil
        end

        -- Full specification of configurations is down below and in Vim help
        -- files
        return {
          exe = "stylua",
          args = {
            "--search-parent-directories",
            "--stdin-filepath",
            util.escape_path(util.get_current_buffer_file_path()),
            "--",
            "-",
          },
          stdin = true,
        }
      end,
    },
    -- Use the special "*" filetype for defining formatter configurations on
    -- any filetype
  },
})
