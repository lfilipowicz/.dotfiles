return {
  "saghen/blink.cmp",
  -- optional: provides snippets for the snippet source
  dependencies = { "rafamadriz/friendly-snippets", "echasnovski/mini.icons" },

  -- use a release tag to download pre-built binaries
  version = "*",
  -- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
  -- build = 'cargo build --release',
  -- If you use nix, you can build from source using latest nightly rust with:
  -- build = 'nix run .#build-plugin',

  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
    cmdline = {
      enabled = false,
    },
    signature = {
      enabled = true,
    },
    completion = {
      documentation = {
        auto_show = true,
        auto_show_delay_ms = 500,
      },
      menu = {
        draw = {
          components = {
            kind_icon = {
              text = function(ctx)
                local kind_icon, _, _ = require("mini.icons").get("lsp", ctx.kind)
                return kind_icon
              end,
              -- (optional) use highlights from mini.icons
              highlight = function(ctx)
                local _, hl, _ = require("mini.icons").get("lsp", ctx.kind)
                return hl
              end,
            },
            kind = {
              -- (optional) use highlights from mini.icons
              highlight = function(ctx)
                local _, hl, _ = require("mini.icons").get("lsp", ctx.kind)
                return hl
              end,
            },
          },
        },
      },
      -- 'default' for mappings similar to built-in completion
      -- 'super-tab' for mappings similar to vscode (tab to accept, arrow keys to navigate)
      -- 'enter' for mappings similar to 'super-tab' but with 'enter' to accept
      -- See the full "keymap" documentation for information on defining your own keymap.
      --
    },

    appearance = {
      -- Sets the fallback highlight groups to nvim-cmp's highlight groups
      -- Useful for when your theme doesn't support blink.cmp
      -- Will be removed in a future release
      -- use_nvim_cmp_as_default = true,
      use_nvim_cmp_as_default = true,
      -- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
      -- Adjusts spacing to ensure icons are aligned
      nerd_font_variant = "mono",
    },

    -- Default list of enabled providers defined so that you can extend it
    -- elsewhere in your config, without redefining it, due to `opts_extend`
  },
}
