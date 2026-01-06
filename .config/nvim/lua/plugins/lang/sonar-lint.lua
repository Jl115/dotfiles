return {
  -- LSP Configuration
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      -- 1. Setup path to SonarLint analyzers installed by Mason
      local mason_path = vim.fn.stdpath("data") .. "/mason/packages/sonarlint-language-server/extension/analyzers/"

      -- 2. Find all JAR files in that directory (Python, JS, Java, HTML, etc.)
      local analyzer_paths = vim.fn.glob(mason_path .. "*.jar", true, true)

      -- 3. Construct the command arguments
      local sonarlint_cmd = {
        "sonarlint-language-server",
        "-stdio",
        "-analyzers",
      }
      -- Append every JAR found to the command
      for _, path in ipairs(analyzer_paths) do
        table.insert(sonarlint_cmd, path)
      end

      -- 4. Define the SonarLint configuration
      opts.servers = opts.servers or {}
      opts.servers.sonarlint = {
        -- Use the dynamic command we built above
        cmd = sonarlint_cmd,

        -- Enable for a broad range of filetypes
        filetypes = {
          -- Web
          "typescript",
          "javascript",
          "typescriptreact",
          "javascriptreact",
          "vue",
          "html",
          "css",
          "json",
          -- Backend / Scripting
          "python",
          "java",
          "go",
          "php",
          "ruby",
          "sh",
          "dockerfile",
          -- Config / Data
          "yaml",
          "xml",
          "toml",
          -- C/C++ (requires compilation database usually, but sonarlint can sometimes do basic checks)
          "c",
          "cpp",
        },

        init_options = {
          showVerboseLogs = true, -- Change to true if you need to debug setup
        },

        root_dir = require("lspconfig").util.root_pattern(
          "package.json",
          ".git",
          "pom.xml",
          "requirements.txt",
          ".sonar"
        ),

        settings = {
          sonarlint = {
            rules = {
              -- You can customize specific rules here if they are too annoying
              -- ["typescript:S101"] = { level = "off" },
            },
          },
        },
      }
    end,
  },
}
