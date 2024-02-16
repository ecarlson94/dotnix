{
  plugins.treesitter-context = {
    enable = true;
  };

  keymaps = [
    {
      mode = "n";
      key = "<leader>ut";
      action = "<cmd>TSContextToggle<CR>";
      options.desc = "Toggle treesitter context";
    }
  ];
}
