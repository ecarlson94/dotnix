{
  programs.nixvim.plugins.treesitter-textobjects = {
    enable = true;
    move = {
      enable = true;

      gotoNextStart = {
        "]f" = "@function.outer";
        "]c" = "@class.outer";
      };
      gotoNextEnd = {
        "]F" = "@function.outer";
        "]C" = "@class.outer";
      };
      gotoPreviousStart = {
        "[f" = "@function.outer";
        "[c" = "@class.outer";
      };
      gotoPreviousEnd = {
        "[F" = "@function.outer";
        "[C" = "@class.outer";
      };
    };
  };
}
