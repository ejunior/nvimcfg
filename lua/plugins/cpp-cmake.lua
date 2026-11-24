return {
  {
    "Civitasv/cmake-tools.nvim",
    ft = { "c", "cpp", "cmake" },
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      cmake_build_directory = "build",
      cmake_generate_options = { "-DCMAKE_EXPORT_COMPILE_COMMANDS=ON" },
    },
    keys = {
      -- Generate / Configure
      { "<leader>cg", "<cmd>CMakeGenerate<cr>", desc = "CMake: Generate project" },
      { "<leader>cG", "<cmd>CMakeGenerate!<cr>", desc = "CMake: Generate (--fresh)" },

      -- Build
      { "<leader>cb", "<cmd>CMakeBuild<cr>", desc = "CMake: Build target" },
      { "<leader>cB", "<cmd>CMakeBuild!<cr>", desc = "CMake: Clean & Rebuild (--clean-first)" },

      -- Run / Debug / Stop
      { "<leader>cr", "<cmd>CMakeRun<cr>", desc = "CMake: Run target" },
      { "<leader>cd", "<cmd>CMakeDebug<cr>", desc = "CMake: Debug target" },
      { "<leader>cq", "<cmd>CMakeStopExecutor<cr>", desc = "CMake: Stop running task" },

      -- Selectors (Target, Preset, Build Type)
      { "<leader>ct", "<cmd>CMakeSelectBuildTarget<cr>", desc = "CMake: Select build target" },
      { "<leader>cp", "<cmd>CMakeSelectConfigurePreset<cr>", desc = "CMake: Select configure preset" },
      { "<leader>cs", "<cmd>CMakeSelectBuildType<cr>", desc = "CMake: Select build type" },

      -- Clean artifacts
      { "<leader>cc", "<cmd>CMakeClean<cr>", desc = "CMake: Clean build" },
    },
  },
}
