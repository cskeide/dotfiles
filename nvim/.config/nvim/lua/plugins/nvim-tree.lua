return { 
  "nvim-tree/nvim-tree.lua", 
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    require("nvim-tree").setup()
    local opts = { noremap = true, silent = true }
    vim.keymap.set("n", "<C-n>", ":NvimTreeToggle<CR>", opts)
  end
}
