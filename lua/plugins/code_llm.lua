return {
    {
        'meeehdi-dev/bropilot.nvim',
        opts = {
            auto_suggest = true,
            model = 'qwen2.5-coder:1.5b-base',
            model_params = {
                num_ctx = 16384,
                num_predict = -2,
                temperature = 0.2,
                top_p = 0.95,
                stop = { '<|fim_pad|>', '<|endoftext|>' },
            },
            prompt = {
                prefix = '<|fim_prefix|>',
                suffix = '<|fim_suffix|>',
                middle = '<|fim_middle|>',
            },
            debounce = 500,
            keymap = {
                accept_word = '<C-Right>',
                accept_line = '<S-Right>',
                accept_block = '<M-l>',
                suggest = '<M-x>',
            },
            ollama_url = 'http://localhost:11434/api',
        },
    },
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
                        return {
                            url = opts.endpoint .. '/chat/completions',
                            headers = {
                                ['Accept'] = 'application/json',
                                ['Content-Type'] = 'application/json',
                            },
                            body = {
                                model = opts.model,
                                messages = require('avante.providers').copilot.parse_message(code_opts),
                                max_tokens = 2048,
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
        },
    },
}
