{
  plugins.conform-nvim = {
    enable = true;

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
      css = [["prettierd" "prettier"]];
      html = [["prettierd" "prettier"]];
      javascript = [["prettierd" "prettier"]];
      javascriptreact = [["prettierd" "prettier"]];
      markdown = [["prettierd" "prettier"]];
      nix = [["alejandra" "nixpkgs-fmt"]];
      typescript = [["prettierd" "prettier"]];
      typescriptreact = [["prettierd" "prettier"]];
      elixir = ["mix"];
      go = ["gofmt"];
    };
  };
}
