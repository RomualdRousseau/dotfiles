if vim.fn.has("nvim-0.12") == 1 then
  return {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    lazy = false,
    build = ":TSUpdate",

    config = function()
      local treesitter = require("nvim-treesitter")

      local languages = {
        "lua",
        "python",
        "java",
        "markdown",
        "toml",
        "yaml",
        "json",
        "just",
      }

      treesitter.install(languages)

      vim.api.nvim_create_autocmd("FileType", {
        pattern = languages,
        callback = function(args)
          local language = vim.treesitter.language.get_lang(vim.bo[args.buf].filetype)

          if language and pcall(vim.treesitter.start, args.buf, language) then
            vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
          end
        end,
      })
    end,
  }
else
  return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    lazy = false,
    config = function()
      local config = require("nvim-treesitter.configs")
      config.setup({
        ensure_installed = { "lua", "python", "java" },
        highlight = { enable = true },
        indent = { enable = true },
      })
    end,
  }
end
