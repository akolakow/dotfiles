return {
    {
        "rcarriga/nvim-dap-ui",
        dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
        config = function()
            local dap, dapui = require("dap"), require("dapui")
            dapui.setup()
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
            vim.keymap.set('n', '<leader>dd', function()
                require("dapui").eval()
            end, { noremap = true })
        end
    },
    {
        "mfussenegger/nvim-dap",
        config = function()
            local ok, dap = pcall(require, 'dap')
            if not ok then
                return
            end

            vim.keymap.set('n', '<leader>db', function()
                require 'dap'.toggle_breakpoint()
            end, { noremap = true })

            vim.keymap.set('n', '<leader>dc', function()
                require 'dap'.continue()
            end, { noremap = true })

            vim.keymap.set('n', '<leader>dn', function()
                require 'dap'.step_over()
            end, { noremap = true })

            vim.keymap.set('n', '<leader>ds', function()
                require 'dap'.step_into()
            end, { noremap = true })

            vim.keymap.set('n', '<leader>dt', function()
                require 'dap'.terminate()
            end, { noremap = true })

            --
            -- See
            -- https://sourceware.org/gdb/current/onlinedocs/gdb.html/Interpreters.html
            -- https://sourceware.org/gdb/current/onlinedocs/gdb.html/Debugger-Adapter-Protocol.html
            local dap = require("dap")
            dap.adapters.gdb = {
                type = "executable",
                command = "gdb",
                args = { "--interpreter=dap", "--eval-command", "set print pretty on" }
            }


            dap.adapters.codelldb = {
                type = "executable",
                command = "codelldb", -- or if not in $PATH: "/absolute/path/to/codelldb"

                -- On windows you may have to uncomment this:
                -- detached = false,
            }

            dap.configurations.cpp = {
                {
                    name = 'Run executable (GDB)',
                    type = 'gdb',
                    request = 'launch',
                    program = function()
                        return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
                    end,
                },
                {
                    name = 'Run executable with arguments (GDB)',
                    type = 'gdb',
                    request = 'launch',
                    -- This requires special handling of 'run_last', see
                    -- https://github.com/mfussenegger/nvim-dap/issues/1025#issuecomment-1695852355
                    program = function()
                        local path = vim.fn.input({
                            prompt = 'Path to executable: ',
                            default = vim.fn.getcwd() .. '/',
                            completion = 'file',
                        })

                        return (path and path ~= '') and path or dap.ABORT
                    end,
                    args = function()
                        local args_str = vim.fn.input({
                            prompt = 'Arguments: ',
                        })
                        return vim.split(args_str, ' +')
                    end,
                },
                {
                    name = 'Attach to process (GDB)',
                    type = 'gdb',
                    request = 'attach',
                    processId = require('dap.utils').pick_process,
                },
                {
                    name = "Codelldb",
                    type = "codelldb",
                    request = "launch",
                    program = function()
                        local path = vim.fn.input({
                            prompt = 'Path to executable: ',
                            default = vim.fn.getcwd() .. '/',
                            completion = 'file',
                        })

                        return (path and path ~= '') and path or dap.ABORT
                    end,
                    cwd = "${workspaceFolder}",
                    stopOnEntry = false,
                },
                {
                    name = "Codelldb with arguments",
                    type = "codelldb",
                    request = "launch",
                    program = function()
                        local path = vim.fn.input({
                            prompt = 'Path to executable: ',
                            default = vim.fn.getcwd() .. '/',
                            completion = 'file',
                        })

                        return (path and path ~= '') and path or dap.ABORT
                    end,
                    args = function()
                        local args_str = vim.fn.input({
                            prompt = 'Arguments: ',
                        })
                        return vim.split(args_str, ' +')
                    end,
                    cwd = "${workspaceFolder}",
                    stopOnEntry = false,
                }
            }

            dap.adapters.python = {
                id = 'python',
                type = 'executable',
                command = 'python3',
                args = { '-m', 'debugpy.adapter' },
            }

            dap.configurations.python = {
                {
                    type = 'python',
                    request = 'launch',
                    name = "Launch file",
                    program = "${file}",
                    pythonPath = function()
                        return vim.fn.exepath("python")
                    end,
                },
                {
                    type = 'python',
                    request = 'launch',
                    name = 'Launch module',
                    module = '${fileBasenameNoExtension}',
                },
            }


            -- Run last: https://github.com/mfussenegger/nvim-dap/issues/1025
            local last_config = nil
            ---@param session Session
            dap.listeners.after.event_initialized["store_config"] = function(session)
                last_config = session.config
            end

            local function debug_run_last()
                if last_config then
                    dap.run(last_config)
                else
                    dap.continue()
                end
            end

            vim.keymap.set('n', '<Leader>dl', function()
                debug_run_last()
            end)
        end
    },
}
