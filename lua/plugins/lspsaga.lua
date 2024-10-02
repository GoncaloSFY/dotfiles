return {
    'nvimdev/lspsaga.nvim',
    config = function()
        require('lspsaga').setup({
            ui = {
                code_action = ''
            }
        })
    end,
    event = "LspAttach",
    dependencies = {
        'nvim-treesitter/nvim-treesitter', -- optional
        'nvim-tree/nvim-web-devicons',     -- optional
    },
}
