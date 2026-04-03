-- requires a local installation of treesitter cli via:
-- > sudo apt update && sudo apt install tree-sitter-cli
--
-- if that doesn't work, use cargo:
-- > cargo install tree-sitter-cli
return {
	"nvim-treesitter/nvim-treesitter",
	branch = "main",
	lazy = false,
	build = ":TSUpdate",
	config = function()
		local parsers = {
			"html",
			"css",
			"javascript",
			"typescript",
			"tsx",
			"go",
			"python",
			"c",
			"markdown",
			"markdown_inline",
			"json",
			"jsonc",
			"lua",
		}

		require("nvim-treesitter").install(parsers)

		vim.api.nvim_create_autocmd("FileType", {
			callback = function(args)
				local buf, filetype = args.buf, args.match

				local language = vim.treesitter.language.get_lang(filetype)
				if not language then
					return
				end

				-- check if parser exists and load it
				if not vim.treesitter.language.add(language) then
					return
				end

				-- enables syntax highlighting and other treesitter features
				vim.treesitter.start(buf, language)

				-- enables treesitter based indentation
				vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
			end,
		})
	end,
}
