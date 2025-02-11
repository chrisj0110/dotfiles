return {
    "L3MON4D3/LuaSnip",
    lazy = true,
    -- dependencies = { "nvim-telescope/telescope.nvim" },
    keys = {
        -- {
        --     '<leader>tl', ':Telescope luasnip<CR>', { noremap = true }
        -- },
        {
            '<c-l>', function()
                local ls = require("luasnip")
                if ls.expand_or_jumpable() then
                    ls.expand_or_jump()
                end
            end, mode = { 'i', 's' }, { noremap = true, silent = true }
        },
        {
            '<c-h>', function()
                local ls = require("luasnip")
                if ls.jumpable(-1) then
                    ls.jump(-1)
                end
            end, mode = { 'i', 's' }, { noremap = true, silent = true }
        },
    },
    -- follow latest release.
    version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
    -- install jsregexp (optional!:).
    build = "make install_jsregexp",
    config = function()
        local ls = require("luasnip")
        -- local types = require("luasnip.util.types")

        -- from https://www.youtube.com/watch?v=Dn800rlPIho and https://www.youtube.com/watch?v=KtQZRAkgLqo
        ls.config.set_config({
            history = true,
            updateevents = "TextChanged,TextChangedI",
            enable_autosnippets = true,
            -- ext_ops = {
            --     [types.choiceNode] = {
            --         active = {
            --             virt_text = {{"<", "Error"}},
            --         },
            --     }
            -- },
        })

        -- what does this do?
        -- vim.keymap.set("i", "<c-q>", function()
        --     if ls.choice_active() then
        --         ls.change_choice(1)
        --     end
        -- end, {silent = true})

        -- why doesn't this work?
        -- vim.keymap.set("n", "<leader>ss", ":source ~/.config/nvim/after/plugin/luasnip.lua<CR>")

        local s = ls.s
        local fmt = require("luasnip.extras.fmt").fmt
        local i = ls.insert_node
        -- local t = ls.text_node
        -- local c = ls.choice_node
        -- local rep = require("luasnip.extras").rep

        -- Note: use rep(1) to repeat the first param so it auto-updates
        ls.add_snippets("cucumber", {
            s("follow", fmt("When I send a follow-up utterance {} from the translation file", { i(1, "<utt2>") })),
        })

        ls.add_snippets("rust", {
            s("p",
                fmt("dbg!(\"{}\"{});{}", { i(1), i(2), i(0) })
            ),
            s("tr",
                fmt("tracing::{}!(\"{}\"{});", { i(2, "info"), i(1), i(3) })
            ),
            s("s",
                fmt("std::thread::sleep(core::time::Duration::from_secs({}));{}", { i(1), i(0) })
            ),
            s("timer-start",
                fmt(
                [[
                    use std::time::Instant;
                    let start = Instant::now();{}
                ]],
                { i(0) })
            ),
            s("timer-end",
                fmt(
                [[
                    println!("{}: {{}}", (Instant::now() - start).as_millis());{}
                ]],
                { i(1), i(0) })
            ),
            s("utm",
                fmt(
                [[
                    #[cfg(test)]
                    mod test {{
                        use super::*;

                        #[test]
                        fn {}{}() {{
                            assert_eq!({}, {});{}
                        }}
                    }}
                ]],
                { i(2), i(1), i(3, "1"), i(4, "1"), i(0) }
                )
            ),
            s("utf",
                fmt(
                [[
                    #[test]
                    fn {}{}() {{
                        assert_eq!({}, {});{}
                    }}
                ]],
                { i(2), i(1), i(3, "1"), i(4, "1"), i(0) }
                )
            )
        })

        ls.add_snippets("go", {
            s("p",
                fmt("fmt.Println(\"{}\"{}){}", { i(1), i(2), i(0) })
            ),
        })

        ls.add_snippets("sh", {
            s("p",
                fmt("echo \"{}\"{}", { i(1), i(0) })
            ),
        })

        ls.add_snippets("make", {
            s("p",
                fmt("$(info {}){}", { i(1), i(0) })
            ),
        })

        ls.add_snippets("lua", {
            s("p",
                fmt("print(\"{}\"{}){}", { i(1), i(2), i(0) })
            ),
        })

        -- not using the following because `Telescope luasnip` isn't using the UI picker:
        -- vim.keymap.set("i", "<c-u>", require("luasnip.extras.select_choice"))

        -- ls.add_snippets("cucumber", {
        --     s("step", {
        --         c(1, {
        --             t { "Given " },
        --             t { "When " },
        --             t { "Then " },
        --         }),
        --     }),
        -- })
        --
    end
}
