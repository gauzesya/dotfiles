return {
  {
    "folke/tokyonight.nvim",
    name = "tokyonight",
    config = function()
      require("tokyonight").setup({
        style = "moon",
        on_colors = function(colors)
          colors.border = colors.orange
        end,
      })
    end,
  },
}
