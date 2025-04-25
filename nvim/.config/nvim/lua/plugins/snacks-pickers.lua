return {
  "snacks.nvim",
  opts = {
    picker = {
      sources = {
        files = {
          hidden = true, -- ✅ Show hidden files in <leader>ff
        },
        grep = {
          hidden = true, -- ✅ Grep through hidden files in <leader>sg
        },
      },
    },
  },
}
