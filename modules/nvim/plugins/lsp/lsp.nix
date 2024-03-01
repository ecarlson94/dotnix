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
        nil_ls.enable = true;
        tsserver.enable = true;
        terraformls.enable = true;
      };
      keymaps = {
        lspBuf = {
          "<leader>gd" = {
            action = "definition";
            desc = "Goto Definitions";
          };
          "<leader>gr" = {
            action = "rename";
            desc = "Rename text across file";
          };
          "<leader>gD" = {
            action = "references";
            desc = "Goto References";
          };
          "<leader>gt" = {
            action = "type_definition";
            desc = "Goto Type Definitions";
          };
          "<leader>gi" = {
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
