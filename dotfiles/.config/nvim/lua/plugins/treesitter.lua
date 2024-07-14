-- Customize Treesitter

---@type LazySpec
return {
  "nvim-treesitter/nvim-treesitter",
  opts = {
    ensure_installed = {
      "lua",
      "vim",
      "python",
      "rust",
      "javascript",
      "typescript",
      "clojure",
      -- add more arguments for adding more treesitter parsers
    },
  },
}
