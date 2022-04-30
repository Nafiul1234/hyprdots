local cmp = require'cmp'
local nvim_lsp = require'lspconfig'
local lspkind = require'lspkind'
local kind_icons = {
  Text = '  ',
  Method = ' ',
  Function = ' ',
  Constructor = '  ',
  Field = '  ',
  Variable = ' ',
  Class = '  ',
  Interface = '  ',
  Module = ' ',
  Property = ' ',
  Unit = ' ',
  Value = '  ',
  Enum = ' ',
  Keyword = '  ',
  Snippet = '﬌  ',
  Color = '  ',
  File = ' ',
  Reference = '  ',
  Folder = ' ',
  EnumMember = ' ',
  Constant = ' ',
  Struct = ' ',
  Event = '  ',
  Operator = 'ﬦ ',
  TypeParameter = '  ',
}
cmp.setup({
  snippet = {
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body)
      require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
    end,
  },
  formatting = {
      format = lspkind.cmp_format({with_text = false, maxwidth = 50})
      --format = function(entry,vim_item)
      --  --Icons
      --  -- vim_item.kind = string.format(kind_icons[vim_item.kind],vim_item.kind) --DISLAY THE ICONS ONLY
      --  vim_item.kind = string.format('%s %s',kind_icons[vim_item.kind],vim_item.kind) --DISLAY THE ICONS AND THE TEXT (Kind)
      ---- Source
      ---- vim_item.menu = ({
      ----   buffer = "[Buffer]",
      ----   nvim_lsp = "[LSP]",
      ----   luasnip = "[LuaSnip]",
      ----   nvim_lua = "[Lua]",
      ----   latex_symbols = "[LaTeX]",
      ---- })[entry.source.name]
      --return vim_item
    --end

    },
    mapping = cmp.mapping.preset.insert({
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }),-- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'vsnip' }, -- For vsnip users.
      { name = 'buffer' },
      { name = 'luasnip'}
    }, {
    })
  })

  -- Set configuration for specific filetype.
  cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
      { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
    }, {
      { name = 'buffer' },
    })
  })

  -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline('/', {
    view = {
      --entries = {name = 'wildmenu',separator = '|'}
      entries = {name = 'custom',selectopm_order = 'near_cursor'}
    },
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = 'buffer' }
    }
  })

  -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = 'path' }
    }, {
      { name = 'cmdline' }
    })
  })
vim.cmd [[highlight! default link CmpItemKind CmpItemMenuDefault]]
  -- Setup lspconfig.
  local capabilities = require('cmp_nvim_lsp').update_capabilities(
  vim.lsp.protocol.make_client_capabilities()
  )
  nvim_lsp.flow.setup {
  capabilities = capabilities
  }
  nvim_lsp.pyright.setup{
    capabilities = capabilities,
  }
  nvim_lsp.vimls.setup{
    capabilities = capabilities,
  }
  nvim_lsp.zeta_note.setup{
    capabilities = capabilities,
  }
  nvim_lsp.grammarly.setup{
    capabilities = capabilities,
  }