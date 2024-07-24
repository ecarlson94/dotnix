{
  programs.nixvim.colorschemes.catppuccin = {
    enable = true;

    settings = {
      transparent_background = true;

      integrations = {
        cmp = true;
        flash = true;
        gitsigns = true;
        leap = true;
        mini.enabled = true;
        telescope.enabled = true;
        treesitter = true;
        treesitter_context = true;
        indent_blankline = {
          enable = true;
          colored_indent_levels = true;
        };
      };
    };
  };
}
