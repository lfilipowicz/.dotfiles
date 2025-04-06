return {
  {
    event = "VeryLazy",
    lazy = true,
    "NvChad/nvim-colorizer.lua",
    opts = {
      user_default_options = { tailwind = true },
    },
  },
  {
    event = "VeryLazy",
    lazy = true,
    "roobert/tailwindcss-colorizer-cmp.nvim",
    opts = {
      color_square_width = 2,
    },
    -- optionally, override the default options:
  },
}
