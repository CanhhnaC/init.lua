local null_ls = require('null-ls')

local b = null_ls.builtins

null_ls.setup({
  sources = {
    b.formatting.prettier,
    b.formatting.stylua,
    b.formatting.black,
    b.formatting.isort.with {
      extra_args = { "--profile", "black" },
    },
    b.formatting.rustfmt,
  }
})
