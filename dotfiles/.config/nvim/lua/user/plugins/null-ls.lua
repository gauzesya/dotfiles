return {
  "jose-elias-alvarez/null-ls.nvim",
  opts = function(_, config)
    local null_ls = require "null-ls"
    config.sources = {
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
