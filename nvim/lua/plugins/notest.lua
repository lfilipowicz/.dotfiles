return {
  "nvim-neotest/neotest",
  lazy = true,
  event = "VeryLazy",
  dependencies = {
    "nvim-neotest/nvim-nio",
    "nvim-lua/plenary.nvim",
    "antoinemadec/FixCursorHold.nvim",
    "nvim-treesitter/nvim-treesitter",
    { "fredrikaverpil/neotest-golang", version = "*" }, -- Installation
  },
  keys = {
    {
      "<leader>td",
      function()
        require("neotest").run.run({ suite = false, strategy = "dap" })
      end,
      desc = "Debug nearest test",
    },
  },
  config = function()
    local neotest_golang_opts = {} -- Specify custom configuration
    require("neotest").setup({
      adapters = {
        require("neotest-golang")(neotest_golang_opts), -- Registration
      },
    })
  end,
}
