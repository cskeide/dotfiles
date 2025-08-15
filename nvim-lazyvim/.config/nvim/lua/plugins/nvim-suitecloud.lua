return {
  --dir = "~/Documents/Dev/nvim-suitecloud/",
  "cskeide/nvim-suitecloud",
  dependencies = {
    "folke/snacks.nvim",
  },
  config = function()
    require("suitecloud")
  end,
}
