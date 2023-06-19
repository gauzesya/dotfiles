return {
  "nvim-treesitter/nvim-treesitter",
  opts = function(_, config)
    config.options = {
      ensure_installed = "all",
      auto_install = true,
    }
    return config
  end,
}
