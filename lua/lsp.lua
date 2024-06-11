local lsp_zero = require('lsp-zero')

lsp_zero.on_attach(function(client, bufnr)
    print('hello rohit')
  -- see :help lsp-zero-keybindings
  -- to learn the available actions
  lsp_zero.default_keymaps({buffer = bufnr})
end)

-- https://github.com/VonHeikemen/lsp-zero.nvim/blob/v3.x/doc/md/guides/integrate-with-mason-nvim.md
require('mason').setup({})
require('mason-lspconfig').setup({
  -- List of LSPs: https://github.com/williamboman/mason-lspconfig.nvim#available-lsp-servers
  ensure_installed = {'lua_ls', 'kotlin_language_server', 'tsserver', 'graphql'},
  handlers = {
    lsp_zero.default_setup,
  },
})

-- Key mappings
local cmp = require('cmp')
local cmp_action = lsp_zero.cmp_action()
cmp.setup({
  mapping = cmp.mapping.preset.insert({
  })
})

require'lspconfig'.kotlin_language_server.setup{}
