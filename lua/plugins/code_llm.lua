return {
    {
        'yetone/avante.nvim',
        opts = {
            provider = 'ollama',
            vendors = {
                ollama = {
                    ['local'] = true,
                    endpoint = '127.0.0.1:11434/v1',
                    model = 'qwen2.5-coder:7b-instruct',
                    parse_curl_args = function(opts, code_opts)
                        local messages = require('avante.providers').copilot.parse_message(code_opts)
                        _G.testvar = messages

                        return {
                            url = opts.endpoint .. '/chat/completions',
                            headers = {
                                ['Accept'] = 'application/json',
                                ['Content-Type'] = 'application/json',
                            },
                            body = {
                                model = opts.model,
                                messages = messages,
                                max_tokens = 8192,
                                stream = true,
                            },
                        }
                    end,
                    parse_response_data = function(data_stream, event_state, opts)
                        require('avante.providers').openai.parse_response(data_stream, event_state, opts)
                    end,
                },
            },
        },
        build = require('utilities.os').is_windows()
                and 'powershell -ExecutionPolicy Bypass -File Build -BuildFromSource false'
            or 'make',
        dependencies = {
            'nvim-treesitter/nvim-treesitter',
            'stevearc/dressing.nvim',
            'nvim-lua/plenary.nvim',
            'MunifTanjim/nui.nvim',
            'nvim-tree/nvim-web-devicons',
            'zbirenbaum/copilot.lua', -- for providers='copilot'
        },
    },
}
