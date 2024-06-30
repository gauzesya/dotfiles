-- Customize None-ls sources

---@type LazySpec
return {
  "nvimtools/none-ls.nvim",
  opts = function(_, config)
    -- config variable is the default configuration table for the setup function call
    local null_ls = require "null-ls"

    -- Check supported formatters and linters
    -- https://github.com/nvimtools/none-ls.nvim/tree/main/lua/null-ls/builtins/formatting
    -- https://github.com/nvimtools/none-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
    config.sources = {
      -- Set a formatter
      -- null_ls.builtins.formatting.stylua,
      -- null_ls.builtins.formatting.prettier,

      -- for python (venv)
      null_ls.builtins.diagnostics.mypy.with {
        only_local = "./.venv/bin",
      },
      null_ls.builtins.formatting.black.with {
        only_local = "./.venv/bin",
      },
      null_ls.builtins.formatting.isort.with {
        only_local = "./.venv/bin",
      },
    }
    return config -- return final config table
  end,
}
