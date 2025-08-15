return {
  {
    "tpope/vim-fugitive",
	  config = function() end,
  },
  {
    "lewis6991/gitsigns.nvim",
    config = function() 
      require('gitsigns').setup()
    end,
  }
}
