local status_ok, _ = pcall(require, 'lspconfig')
if(not status_ok) then
    return
end


require('bizon.lsp.lsp-installer')
require('bizon.lsp.handlers').setup()
