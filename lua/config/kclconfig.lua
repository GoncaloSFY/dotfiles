local server_config = require("lspconfig.configs")
local util = require("lspconfig.util")
server_config.kcl = {
    default_config = {},
}

local lspconfig = require("lspconfig")
lspconfig.kcl.setup({
    cmd = { "kcl-language-server" },
    filetypes = { "kcl" },
    root_dir = util.root_pattern(".git"),
})

