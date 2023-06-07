return {
  {
    "folke/tokyonight.nvim",
    name = "tokyonight",
    config = function()
      require("tokyonight").setup {
        style = "moon",
      }
    end,
  },
}
