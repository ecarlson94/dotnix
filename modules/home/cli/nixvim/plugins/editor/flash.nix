{
  programs.nixvim = {
    plugins.flash = {
      enable = true;
      modes.char.jumpLabels = true;
    };

    keymaps = [
      {
        mode = [
          "n"
          "x"
          "o"
        ];
        key = "s";
        action = "function() require'flash'.jump() end";
        lua = true;
      }
      {
        mode = [
          "n"
          "x"
          "o"
        ];
        key = "S";
        action = "function() require'flash'.treesitter() end";
        lua = true;
      }
      {
        mode = "o";
        key = "r";
        action = "function() require'flash'.remote() end";
        lua = true;
      }
      {
        mode = [
          "o"
          "x"
        ];
        key = "R";
        action = "function() require'flash'.treesitter_search() end";
        lua = true;
      }
    ];
  };
}
