if vim.g.loaded_lsp then
    return
end
vim.g.loaded_lsp = true

vim.lsp.config('*', {
  capabilities = {
    textDocument = {
      semanticTokens = {
        multilineTokenSupport = true,
      }
     }
  }
})

vim.lsp.enable('luals')
