return {
	{
		"rcarriga/nvim-notify",
		dependencies = { "MunifTanjim/nui.nvim" },
		opts = {
			timeout = 3000,
			max_height = function()
				return math.floor(vim.o.lines * 0.75)
			end,
			max_width = function()
				return math.floor(vim.o.columns * 0.75)
			end,
		},
		init = function()
			local Util = require("utils")
			if not Util.has("noice.nvim") then
				Util.on_very_lazy(function()
					vim.notify = require("notify")
				end)
			end
		end,
	},
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		opts = {
			views = {
				cmdline_popup = {
          position = {
            row = 5,
            col = "50%"
          },
          size = {
            width = 60,
            height = "auto"
          },
          border = {
            style = "single"
          }
        },
        popupmenu = {
          relative = "editor",
          position = {
            row = 8,
            col = "50%"
          },
          size = {
            width = 60,
            height = 10,
          },
          border = {
            style = "single",
            padding = { 0, 1 }
          },
          win_options = {
            winhighlight = { Normal = "Normal",  FloatBorder = "MoreMsg" }
          }
        }
			},
			lsp = {
				override = {
					["vim.lsp.util.convert_input_to_markdown_lines"] = true,
					["vim.lsp.util.stylize_markdown"] = true,
				},
				presets = {
					bottom_search = true,
					command_palette = true,
					long_message_to_split = true,
				},
			},
		},
	},
	{
		"nvim-lualine/lualine.nvim",
		event = "VeryLazy",
		opts = function()
			local icons = require("utils").icons.modes
			local lsp_names = function()
				local clients = {}
				for _, client in ipairs(vim.lsp.get_active_clients({ bufnr = 0 })) do
					if client.name == "null-ls" then
						local sources = {}
						for _, source in ipairs(require("null-ls.sources").get_available(vim.bo.filetype)) do
							table.insert(sources, source.name)
						end
						table.insert(clients, "null-ls(" .. table.concat(sources, ", ") .. ")")
					else
						table.insert(clients, client.name)
					end
				end
				return " " .. table.concat(clients, ", ")
			end

			--[[
      local skkeleton_indicator = function()
				if vim.fn["skkeleton#is_enabled"]() == true then
					local base = "▼ "
					local mode = vim.fn["skkeleton#mode"]()
					if mode == "hira" then
						return base .. "ひら"
					elseif mode == "kata" then
						return base .. "カタ"
					else
						return base
					end
				else
					return "▽ OFF"
				end
			end
      ]]

			return {
				options = {
					theme = "auto",
					globalstatus = true,
				},
				sections = {
					lualine_a = {
						{
							"mode",
							fmt = function()
								return icons[vim.fn.mode()]
							end,
							color = { bg = "#202023", fg = "#97A4B5" },
							separator = { right = "" },
						},
					},
					lualine_b = {
						"branch",
					},
					lualine_c = {
						{ "diagnostics" },
						{ "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
						{ "filename", path = 1, symbols = { modified = "  ", readonly = "", unnamed = "" } },
					},
					lualine_x = {
						lsp_names,
						-- skkeleton_indicator,
						{ require("lazy.status").updates, cond = require("lazy.status").has_updates },
						{ "diff" },
					},
					lualine_y = {
						{ "progress", separator = " ", padding = { left = 1, right = 0 } },
						{ "location", padding = { left = 0, right = 1 } },
					},
					lualine_z = {},
				},
			}
		end,
	},
	{
		"nvim-tree/nvim-web-devicons",
		event = "VeryLazy",
		dependencies = {
		},
		config = function()
			require("nvim-web-devicons").setup({
			})
		end,
	},
	{
		"akinsho/bufferline.nvim",
		event = { "BufReadPost" },
		opts = {
			options = {
				diagnostics = "nvim_lsp",
				separator_style = "slant",
				indicator = {
					style = "underline",
				},
				close_command = "bdelete! %d",
				diagnostics_indicator = function(count, _, _, _)
					if count > 9 then
						return "9+"
					end
					return tostring(count)
				end,
				offsets = {
					{
						filetype = "neo-tree",
						text = "Explorer",
						text_align = "center",
					},
				},
				hover = {
					enabled = true,
					delay = 0,
					reveal = { "close" },
				},
			},
		},
	},
	{
		"utilyre/barbecue.nvim",
		name = "barbecue",
		cmd = "Barbecue",
		version = "*",
		dependencies = {
			"SmiteshP/nvim-navic",
			"nvim-tree/nvim-web-devicons",
		},
		opts = function()
			vim.api.nvim_create_autocmd({
				"WinScrolled",
				"BufWinEnter",
				"CursorHold",
				"InsertLeave",
			}, {
				group = vim.api.nvim_create_augroup("barbecue.updater", {}),
				callback = function()
					require("barbecue.ui").update()
				end,
			})
			return {
				create_autocmd = false,
			}
		end,
	},
  {
    "mvllow/modes.nvim",
    tag = "v0.2.0",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      colors = {
        copy = "#DEB974",
        delete = "#EC7279",
        insert = "#A0C980",
        visual = "#D38AEA",
      }
    }
  },
  {
    "lewis6991/gitsigns.nvim",
    opts = true,
    event = "VeryLazy"
  },
  {
    "tpope/vim-fugitive",
    cmds = "Git"
  }
}
