local lsp = require('lsp-zero').preset({})

lsp.on_attach(function(_, bufnr)
  lsp.default_keymaps({ buffer = bufnr })
end)

lsp.format_mapping('<leader>fm', {
  format_opts = {
    async = true,
    timeout_ms = 10000,
  },
  servers = {
    ['null-ls'] = { 'javascript', 'typescript', "lua", 'python' },
  }
})


lsp.setup()
