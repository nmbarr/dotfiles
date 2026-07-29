return {
	{
		"nvim-treesitter/nvim-treesitter",
		dependencies = {
			{
				"nvim-treesitter/nvim-treesitter-textobjects",
				branch = "main",
			},
		},
		branch = "main",
		build = ":TSUpdate",
		config = function()
			-- Parser installation list
			local ensure_installed = {
				"vimdoc",
				"markdown",
				"markdown_inline",
				"javascript",
				"typescript",
				"c",
				"lua",
				"rust",
				"jsdoc",
				"bash",
				"go",
				"python",
				"make",
				"cmake",
			}

			-- Install parsers
			local parser_install = require("nvim-treesitter.install")
			parser_install.prefer_git = false
			for _, lang in ipairs(ensure_installed) do
				local installed = #vim.api.nvim_get_runtime_file("parser/" .. lang .. ".so", false) > 0
				if not installed then
					vim.cmd("TSInstall " .. lang)
				end
			end

			-- Highlight configuration
			vim.treesitter.language.register("templ", "templ")

			-- Disable treesitter for html and large files
			vim.api.nvim_create_autocmd("FileType", {
				pattern = "html",
				callback = function()
					vim.treesitter.stop()
				end,
			})

			vim.api.nvim_create_autocmd("BufReadPost", {
				callback = function(args)
					local max_filesize = 100 * 1024 -- 100 KB
					local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(args.buf))
					if ok and stats and stats.size > max_filesize then
						vim.notify(
							"File larger than 100KB treesitter disabled for performance",
							vim.log.levels.WARN,
							{ title = "Treesitter" }
						)
						vim.treesitter.stop(args.buf)
					end
				end,
			})
		end,
	},

	{
		"nvim-treesitter/nvim-treesitter-context",
		after = "nvim-treesitter",
		config = function()
			require("treesitter-context").setup({
				enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
				multiwindow = false, -- Enable multiwindow support.
				max_lines = 0, -- How many lines the window should span. Values <= 0 mean no limit.
				min_window_height = 0, -- Minimum editor window height to enable context. Values <= 0 mean no limit.
				line_numbers = true,
				multiline_threshold = 20, -- Maximum number of lines to show for a single context
				trim_scope = "outer", -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
				mode = "cursor", -- Line used to calculate context. Choices: 'cursor', 'topline'
				-- Separator between context and content. Should be a single character string, like '-'.
				-- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
				separator = nil,
				zindex = 20, -- The Z-index of the context window
				on_attach = nil, -- (fun(buf: integer): boolean) return false to disable attaching
			})
		end,
	},
}
