return {
  "mrcjkb/rustaceanvim",
  ft = { "rust" },
  init = function()
    vim.g.rustaceanvim = {
      server = {
        cmd = { "rust-analyzer" },
        default_settings = {
          ["rust-analyzer"] = {
            procMacro = { enable = true },
            cachePriming = { enable = true },
            restartServerOnConfigChange = true,
            workspace = { discoverConfig = vim.NIL },
            cargo = {
              allFeatures = false,
              features = {},
              targetDir = vim.NIL,
              autoreload = false,
              sysroot = "discover",
              buildScripts = {
                overrideCommand = {
                  "bazel",
                  "run",
                  "@rules_rust//tools/upstream_wrapper:cargo",
                  "--@rules_rust//rust/settings:toolchain_generated_sysroot",
                  "--",
                  "check",
                  "--quiet",
                  "--workspace",
                  "--message-format=json",
                  "--all-targets",
                  "--keep-going",
                  "--rustc_flags=--cfg=platform=\"arene-na-cdc\""
                },
              },
            },
            check = {
              overrideCommand = {
                "bazel",
                "run",
                "@rules_rust//tools/upstream_wrapper:cargo",
                "--@rules_rust//rust/settings:toolchain_generated_sysroot",
                "--",
                "check",
                "--rustc_flags=--cfg=platform=\"arene-na-cdc\""
              },
            },
            rustfmt = {
              overrideCommand = {
                "bazel",
                "run",
                "@rules_rust//tools/upstream_wrapper:rustfmt",
                "--@rules_rust//rust/settings:toolchain_generated_sysroot",
                "--",
                "--emit=files"
              },
            },
            files = {
              exclude = {
                "output/",
                "bazel-p21-embedded/",
                "bazel-out/",
                "bazel-bin/**",
                "bazel-testlogs/**",
                "bazel-*//**",
                ".git/**",
                "target/**",
              },
              excludeDirs = {
                "audio/examples",
                "cap/examples",
                "ml/examples",
                "p21/p21-navigation/examples",
                "p21/p21-radio/benches",
                "p21/p21-radio/examples",
                "vi/examples",
              },
            },
          },
        },
      },
    }
  end,
}
