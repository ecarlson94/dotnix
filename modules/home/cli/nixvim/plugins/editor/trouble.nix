{
  programs.nixvim = {
    plugins.trouble.enable = true;

    keymaps = [
      {
        mode = ["n"];
        key = "<leader>xx";
        action = "<cmd>TroubleToggle<cr>";
        options.desc = "Toggle Trouble";
      }
      {
        mode = ["n"];
        key = "<leader>xl";
        action = "<cmd>TroubleToggle loclist<cr>";
        options.desc = "Toggle Location List";
      }
      {
        mode = ["n"];
        key = "<leader>xq";
        action = "<cmd>TroubleToggle quickfix<cr>";
        options.desc = "Toggle Quickfix List";
      }
      {
        mode = ["n"];
        key = "<leader>xd";
        action = "<cmd>TroubleToggle document_diagnostics<cr>";
        options.desc = "Toggle Document Diagnostics";
      }
      {
        mode = ["n"];
        key = "<leader>xw";
        action = "<cmd>TroubleToggle workspace_diagnostics<cr>";
        options.desc = "Toggle Workspace Diagnostics";
      }
      {
        mode = ["n"];
        key = "gR";
        action = "<cmd>TroubleToggle lsp_references<cr>";
        options.desc = "Toggle Quickfix List";
      }
      {
        mode = ["n"];
        key = "[q";
        action = "vim.cmd.cprev";
        lua = true;
        options.desc = "Prev quickfix";
      }
      {
        mode = ["n"];
        key = "]q";
        action = "vim.cmd.cnext";
        lua = true;
        options.desc = "Next quickfix";
      }
    ];
  };
}
