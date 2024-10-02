return {
    -- debug
    {
        "leoluz/nvim-dap-go",
    },
    {
        "mfussenegger/nvim-dap",
        dependencies = {
            "leoluz/nvim-dap-go",
        },
        config = function()
            require('dap-go').setup {
                -- Additional dap configurations can be added.
                -- dap_configurations accepts a list of tables where each entry
                -- represents a dap configuration. For more details do:
                -- :help dap-configuration
                -- delve configurations
                delve = {
                    -- the path to the executable dlv which will be used for debugging.
                    -- by default, this is the "dlv" executable on your PATH.
                    path = "dlv",
                    -- time to wait for delve to initialize the debug session.
                    -- default to 20 seconds
                    initialize_timeout_sec = 20,
                    -- a string that defines the port to start delve debugger.
                    -- default to string "${port}" which instructs nvim-dap
                    -- to start the process in a random available port.
                    -- if you set a port in your debug configuration, its value will be
                    -- assigned dynamically.
                    port = "${port}",
                    -- additional args to pass to dlv
                    args = {},
                    -- the build flags that are passed to delve.
                    -- defaults to empty string, but can be used to provide flags
                    -- such as "-tags=unit" to make sure the test suite is
                    -- compiled during debugging, for example.
                    -- passing build flags using args is ineffective, as those are
                    -- ignored by delve in dap mode.
                    -- avaliable ui interactive function to prompt for arguments get_arguments
                    build_flags = {},
                    -- whether the dlv process to be created detached or not. there is
                    -- an issue on Windows where this needs to be set to false
                    -- otherwise the dlv server creation will fail.
                    -- avaliable ui interactive function to prompt for build flags: get_build_flags
                    detached = vim.fn.has("win32") == 0,
                    -- the current working directory to run dlv from, if other than
                    -- the current working directory.
                    cwd = nil,
                },
                -- options related to running closest test
                tests = {
                    -- enables verbosity when running the test.
                    verbose = false,
                },
            }

            require("dap").set_log_level("debug")

            vim.keymap.set("n", "<leader>bp", ":DapToggleBreakpoint<CR>")
            vim.keymap.set("n", "<leader>dw", function()
                local widgets = require("dap.ui.widgets")
                local sidebar = widgets.sidebar(widgets.scopes, nil, "bot split")
                sidebar.open()
            end)
            vim.keymap.set("n", "<leader>dt", require("dap-go").debug_test)
            vim.keymap.set("n", "<leader>dk", ":lua require('dap.ui.variables').hover()<CR>")
            vim.keymap.set("n", "<leader>sc", require("dap").continue)
            vim.keymap.set("n", "<leader>so", require("dap").step_over)
            vim.keymap.set("n", "<leader>si", require("dap").step_into)
            vim.keymap.set("n", "<leader>ds", require("dap").terminate)
        end,
    },
    {
        dependencies = {
            "nvim-neotest/nvim-nio",
            "mfussenegger/nvim-dap",
        },
        "rcarriga/nvim-dap-ui",
        config = function()
            require("dapui").setup({
                controls = {
                    element = "repl",
                    enabled = true,
                    icons = {
                        disconnect = "",
                        pause = "",
                        play = "",
                        run_last = "",
                        step_back = "",
                        step_into = "",
                        step_out = "",
                        step_over = "",
                        terminate = "",
                    },
                },
                expand_lines = true,
                render = {
                    indent = 1,
                    max_value_lines = 10000,
                    max_type_length = 10000,
                },
            })

            local dap, dapui = require("dap"), require("dapui")
            dap.listeners.before.attach.dapui_config = function()
                dapui.open()
            end
            dap.listeners.before.launch.dapui_config = function()
                dapui.open()
            end
            dap.listeners.before.event_terminated.dapui_config = function()
                dapui.close()
            end
            dap.listeners.before.event_exited.dapui_config = function()
                dapui.close()
            end

            vim.keymap.set("n", "<leader>do", require("dapui").open)
            vim.keymap.set("n", "<leader>dc", require("dapui").close)
        end,
    },
    -- {
    --     "Cliffback/netcoredbg-macOS-arm64.nvim",
    --     dependencies = { "mfussenegger/nvim-dap" },
    --     config = function()
    --         require('netcoredbg-macOS-arm64').setup(require('dap'))
    --     end,
    -- },
    {
        'nicholasmata/nvim-dap-cs',
        dependencies = { 'mfussenegger/nvim-dap' },
        config = function()
            require('dap-cs').setup()
        end,
    }
}
