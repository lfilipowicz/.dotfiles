local cmp = require("cmp")
vim.opt.completeopt = { "menu", "menuone", "noselect" }
vim.opt.shortmess:append("c")

local luasnip = require("luasnip")
local lspkind = require("lspkind")
-- require("luasnip.loaders.from_vscode").lazy_load()

-- luasnip.config.set_config = {
--   history = false,
--   updateevents = "TextChanged,TextChangedI",
-- }

-- cmp.setup({
-- snippet = {
--   expand = function(args)
--     luasnip.lsp_expand(args.body) -- For `luasnip` users.
--   end,
-- },
-- completion = {
--   completeopt = "menu,menuone,preview,oselect",
-- },
-- formatting = {
--   fields = { "abbr", "kind", "menu" },
--   format = lspkind.cmp_format({
--     maxwidth = 50,
--     elipsis_char = "...",
--     before = require("tailwindcss-colorizer-cmp").formatter,
--   }),
-- },
-- confirm_opts = {
--   behavior = cmp.ConfirmBehavior.Replace,
--   select = true,
-- },
-- mapping = {
--   ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
--   ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
--   ["<C-y>"] = cmp.mapping(cmp.mapping.confirm({ select = true, behavior = cmp.SelectBehavior.Insert }), { "i", "c" }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
--   ["<CR>"] = cmp.mapping(cmp.mapping.confirm({ select = true, behavior = cmp.SelectBehavior.Insert }), { "i", "c" }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
--   ["<C-Space>"] = cmp.mapping.complete(),
-- },
-- sources = cmp.config.sources({
--   { name = "buffer" },
--   { name = "nvim_lsp" },
--   { name = "path" },
--   { name = "luasnip" }, -- For luasnip users.
-- }),
-- })

cmp.setup.filetype({ "templ" }, {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body) -- For `luasnip` users.
    end,
  },
  completion = {
    completeopt = "menu,menuone,preview,oselect",
  },
  formatting = {
    fields = { "abbr", "kind", "menu" },
    format = lspkind.cmp_format({
      maxwidth = 50,
      elipsis_char = "...",
      before = require("tailwindcss-colorizer-cmp").formatter,
    }),
  },
  confirm_opts = {
    behavior = cmp.ConfirmBehavior.Replace,
    select = true,
  },
  mapping = {
    ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
    ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
    ["<C-y>"] = cmp.mapping(cmp.mapping.confirm({ select = true, behavior = cmp.SelectBehavior.Insert }), { "i", "c" }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    ["<CR>"] = cmp.mapping(cmp.mapping.confirm({ select = true, behavior = cmp.SelectBehavior.Insert }), { "i", "c" }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    ["<C-Space>"] = cmp.mapping.complete(),
  },
  sources = {
    { name = "buffer" },
    { name = "nvim_lsp" },
    { name = "path" },
    { name = "luasnip" }, -- For luasnip users.
  },
})

-- Setup up vim-dadbod
cmp.setup.filetype({ "sql" }, {
  sources = {
    { name = "vim-dadbod-completion" },
    { name = "buffer" },
  },
})

cmp.setup.filetype({ "rust" }, {
  sources = {
    { name = "nvim_lsp" },
    { name = "buffer" },
    { name = "path" },
    { name = "crates" },
    { name = "luasnip" }, -- For luasnip users.
  },
})

-- cmp.setup.cmdline("/", {
--   mapping = cmp.mapping.preset.cmdline(),
--   sources = {
--     { name = "buffer" },
--   },
-- })
