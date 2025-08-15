return {
  "nvim-treesitter/nvim-treesitter",
  opts = {
    ensure_installed = {
      "javascript",
    },
    auto_install = true,
    highlight = { enable = true },
    indent = { enable = true },
  },
}
