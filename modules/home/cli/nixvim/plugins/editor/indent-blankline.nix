{
  programs.nixvim.plugins.indent-blankline = {
    enable = true;

    settings.indent.highlight = [
      "RainbowYellow"
      "RainbowBlue"
      "RainbowOrange"
      "RainbowGreen"
      "RainbowViolet"
      "RainbowCyan"
    ];
  };
}
