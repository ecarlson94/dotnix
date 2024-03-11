{
  plugins.treesitter = {
    enable = true;
    indent = true;

    incrementalSelection = {
      enable = true;
      keymaps = {
        initSelection = "<C-space>";
        nodeDecremental = "<C-space>";
        nodeIncremental = "<bs>";
      };
    };
  };
}
