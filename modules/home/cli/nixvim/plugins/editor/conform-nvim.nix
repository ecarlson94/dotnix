{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.cli.nixvim;
in {
  config = mkIf cfg.enable {
    home.packages = with pkgs; [shfmt prettierd];

    programs.nixvim.plugins.conform-nvim = {
      enable = true;
      notifyOnError = false;

      formatOnSave = {
        lspFallback = true;
        timeoutMs = 500;
      };

      formatters = {
        shfmt = {
          prepend_args = ["-i" "2" "-ci"];
        };
      };

      formattersByFt = {
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
    };
  };
}
