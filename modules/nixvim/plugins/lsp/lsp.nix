{
  plugins = {
    none-ls.enable = true;
    lsp = {
      enable = true;

      servers = {
        dockerls.enable = true;
        elixirls.enable = true;
        gopls.enable = true;
        jsonls.enable = true;
        marksman.enable = true;
        nil_ls.enable = true; # Nix
        tsserver.enable = true;
        terraformls.enable = true;
        omnisharp.enable = true;
      };
      keymaps = {
        lspBuf = {
          "gd" = {
            action = "definition";
            desc = "Goto Definitions";
          };
          "gr" = {
            action = "rename";
            desc = "Rename text across file";
          };
          "gD" = {
            action = "references";
            desc = "Goto References";
          };
          "gt" = {
            action = "type_definition";
            desc = "Goto Type Definitions";
          };
          "gi" = {
            action = "implementation";
            desc = "Goto implementation";
          };
          "K" = "hover";
          "<leader>ca" = {
            action = "code_action";
            desc = "Code Actions";
          };
        };
        diagnostic = {
          "<leader>dd" = {
            action = "open_float";
            desc = "Open Diagnostic List";
          };
          "<leader>d[" = {
            action = "goto_next";
            desc = "Goto Next Issue";
          };
          "<leader>d]" = {
            action = "goto_prev";
            desc = "Goto Prev Issue";
          };
        };
      };
    };
  };
}
