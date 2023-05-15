local cmp_status_ok, cmp = pcall(require, "cmp")
if not cmp_status_ok then
  return
end

local snip_status_ok, luasnip = pcall(require, "luasnip")
if not snip_status_ok then
  return
end

local lspkind_status_ok, lspkind = pcall(require, "lspkind")
if not lspkind_status_ok then
  return
end

-- require("luasnip.loaders.from_vscode").lazy_load()

vim.opt.completeopt = "menu,menuone,noselect"

-- local compare = cmp.config.compare
-- local types = require("cmp.types")

-- local source_maps = {
--   nvim_lsp = "[lsp]",
--   nvim_lua = "[lua]",
--   buffer = "[buf]",
--   path = "[pth]",
-- }
cmp.setup({

  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body) -- For `luasnip` users.
    end,
  },
  formatting = {
    fields = { "abbr", "kind", "menu" },
    format = lspkind.cmp_format({
      mode = "symbol_text",
      maxwidth = 50,
      elipsis_char = "...",
      -- before = function(entry, vim_item)
      --   vim_item.menu = source_maps[entry.source.name]
      --   return vim_item
      -- end,
      before = require("tailwindcss-colorizer-cmp").formatter,
    }),
  },
  confirm_opts = {
    behavior = cmp.ConfirmBehavior.Replace,
    select = true,
  },
  mapping = cmp.mapping.preset.insert({
    ["<C-k>"] = cmp.mapping.select_prev_item(),
    ["<C-j>"] = cmp.mapping.select_next_item(),
    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-e>"] = cmp.mapping.abort(),
    ["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
  }),
  sources = cmp.config.sources({
    {
      name = "nvim_lsp",
      -- entry_filter = function(entry)
      --   return require("cmp").lsp.CompletionItemKind.Snippet ~= entry:get_kind()
      -- end,
    },
    { name = "nvim_lsp_signature_help" },
    { name = "nvim_lua" },
    { name = "crates" },
    -- { name = "luasnip" }, -- For luasnip users.
    { name = "buffer", keyword_length = 3, max_item_count = 10 },
    { name = "path", keyword_length = 3, max_item_count = 10 },
  }),
})

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline("/", {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = "buffer" },
  },
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(":", {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = "path" },
  }, {
    { name = "cmdline" },
  }),
})
