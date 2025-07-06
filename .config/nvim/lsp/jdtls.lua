return {
  cmd = { "jdtls" },
  filetypes = { "java" },
  root_markers = { ".git", "mvnw", "gradlew", "pom.xml", "build.gradle" },
  single_file_support = false,
  log_level = vim.lsp.protocol.MessageType.Warning,
  settings = {
    java = {
      eclipse = {
        downloadSources = true,
      },
      configuration = {
        updateBuildConfiguration = "interactive",
        runtimes = {
          {
            name = "JavaSE-24",
            path = "/Library/Java/JavaVirtualMachines/temurin-24.jdk/Contents/Home", -- adjust to your system
          },
        },
      },
      maven = {
        downloadSources = true,
      },
      references = {
        includeDecompiledSources = true,
      },
      implementationsCodeLens = {
        enabled = true,
      },
      referencesCodeLens = {
        enabled = true,
      },
      format = {
        enabled = true,
      },
    },
  },
}
