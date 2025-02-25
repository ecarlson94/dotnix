{
  pkgs,
  lib,
  config,
  ...
}: let
  prettierd_with_fallback = {
    __unkeyed-1 = "prettierd";
    __unkeyed-2 = "prettier";
    stop_after_first = true;
  };
in {
  config.home.packages = lib.mkIf config.programs.nixvim.enable (with pkgs; [shfmt prettierd]);

  config.programs.nixvim.plugins.conform-nvim = {
    enable = true;

    settings = {
      notify_on_error = false;

      formatters = {
        shfmt = {
          prepend_args = ["-i" "2" "-ci"];
        };
      };

      formatters_by_ft = {
        cs = ["csharpier"];
        css = prettierd_with_fallback;
        elixir = {
          __unkeyed-1 = "mix";
          timeout_ms = 2000;
        };
        html = prettierd_with_fallback;
        javascript = prettierd_with_fallback;
        javascriptreact = prettierd_with_fallback;
        markdown = prettierd_with_fallback;
        nix = {
          __unkeyed-1 = "alejandra";
          __unkeyed-2 = "nixpkgs-fmt";
          stop_after_first = true;
        };
        typescript = prettierd_with_fallback;
        typescriptreact = prettierd_with_fallback;
        go = ["gofmt"];
        sh = ["shfmt"];
      };

      format_on_save = {
        lsp_fallback = "fallback";
        timeout_ms = 1000;
      };
    };
  };
}
