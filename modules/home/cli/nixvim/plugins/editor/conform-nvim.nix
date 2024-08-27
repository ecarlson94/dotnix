{
  pkgs,
  lib,
  config,
  ...
}: {
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
        css = [["prettierd" "prettier"]];
        elixir = ["mix"];
        html = [["prettierd" "prettier"]];
        javascript = [["prettierd" "prettier"]];
        javascriptreact = [["prettierd" "prettier"]];
        markdown = [["prettierd" "prettier"]];
        nix = [["alejandra" "nixpkgs-fmt"]];
        typescript = [["prettierd" "prettier"]];
        typescriptreact = [["prettierd" "prettier"]];
        go = ["gofmt"];
        sh = ["shfmt"];
      };

      format_on_save = {
        lsp_fallback = "fallback";
        timeout_ms = 500;
      };
    };
  };
}
