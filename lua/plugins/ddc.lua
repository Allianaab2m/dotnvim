-- ref: https://github.com/arrow2nd/dotfiles/blob/main/.config/nvim/lua/plugins/ddc.lua
local imap = require("utils").imap
local fn = vim.fn

return {
  {
    "Shougo/ddc.vim",
    lazy = false,
    enabled = false,
    dependencies = {
      "vim-denops/denops.vim",
      -- UI
      "Shougo/pum.vim",
      "Shougo/ddc-ui-pum",
      -- Source
      "Shougo/ddc-source-around",
      "Shougo/ddc-source-nvim-lsp",
      "uga-rosa/ddc-source-vsnip",
      "rafamadriz/friendly-snippets",
      -- Filter
      "tani/ddc-fuzzy",
      -- Preview
      "matsui54/denops-popup-preview.vim",
    },
    init = function()
      local opts = { silent = true, expr = true, replace_keycodes = true }
      imap("<Tab>", function()
        if vim.fn["pum#visible"]() == true then
          return "<Cmd>call pum#map#insert_relative(+1, 'loop')<CR>"
        elseif vim.fn["vsnip#available"](1) == 1 then
          return "<Plug>(vsnip-expand-or-jump)"
        else
          return "<Tab>"
        end
      end, opts)
      imap("<S-Tab>", function()
        if vim.fn["pum#visible"]() == true then
          return "<Cmd>call pum#map#insert_relative(-1, 'loop')<CR>"
        elseif vim.fn["vsnip#jumpable"](-1) == 1 then
          return "<Plug>(vsnip-jump-prev)"
        else
          return "<S-Tab>"
        end
      end, opts)
      vim.api.nvim_create_autocmd("User", {
        pattern = "LazyPluginPost:lexima",
        callback = function()
          vim.keymap.set("i", "<CR>", function()
            local info = vim.fn["pum#complete_info"]()
            print(info)
            if info.pum_visible then
              if info.selected >= 0 then
                return vim.fn["pum#map#confirm"]()
              else
                return vim.fn["ddc#map#insert_item"](0)
              end
            elseif vim.fn["vsnip#expandable"]() == 1 then
              return vim.keycode("<Plug>(vsnip-expand)")
            else
              --return vim.fn["lexima#expand"]("<CR>", "i")
              return "<CR>"
            end
          end, { silent = true, expr = true, replace_keycodes = false })
        end,
        once = true
      })
    end,
    config = function()
      local patch_global = vim.fn["ddc#custom#patch_global"]

      patch_global("ui", "pum")

      patch_global("sources", {
        "nvim-lsp",
        "vsnip",
        "around",
      })

      patch_global("sourceOptions", {
        _ = {
          matchers = { "matcher_fuzzy" },
          sorters = { "sorter_fuzzy" },
          converters = { "converter_fuzzy" },
        },
        around = {
          mark = "[A]",
        },
        ["nvim-lsp"] = {
          mark = "[LS]",
          dup = "keep",
          forceCompletionPattern = [[\k+]],
          sorters = { "sorter_lsp-kind" },
        },
        vsnip = {
          mark = "[Vsnip]",
          keywordPattern = "\\S*",
        },
      })

      patch_global("sourceParams", {
        ["nvim-lsp"] = {
          snippetEngine = vim.fn["denops#callback#register"](function(body)
            vim.fn["vsnip#anonymous"](body)
          end),
          enableResolveItem = true,
          enableAdditionalTextEdit = true,
          confirmBehavior = "replace",
        },
      })

      -- keymap

      fn["pum#set_option"]({
        border = "single",
        auto_confirm_time = 750
      })
      fn["ddc#enable"]()
    end,
  },
  {
    "matsui54/denops-popup-preview.vim",
    dependencies = { "vim-denops/denops.vim" },
    config = function()
      vim.g.popup_preview_config = {
        border = false,
        supportVsnip = true,
        supportUltisnips = false,
        supportInfo = true,
        delay = 60,
      }

      fn["popup_preview#enable"]()
    end,
  },
  {
    "hrsh7th/vim-vsnip",
    lazy = false,
    config = function()
      vim.cmd('imap <expr> <C-l> vsnip#jumpable(1) ? "<Plug>(vsnip-jump-next)" : "<C-l>"')
      vim.cmd('smap <expr> <C-l> vsnip#jumpable(1) ? "<Plug>(vsnip-jump-next)" : "<C-l>"')
      vim.cmd('imap <expr> <C-h> vsnip#jumpable(-1) ? "<Plug>(vsnip-jump-prev)" : "<C-h>"')
      vim.cmd('smap <expr> <C-h> vsnip#jumpable(-1) ? "<Plug>(vsnip-jump-prev)" : "<C-h>"')
    end,
  },
}
