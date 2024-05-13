{
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.cli.zellij;
in {
  options.modules.cli.zellij = {enable = mkEnableOption "zellij";};

  config = mkIf cfg.enable {
    programs.zellij = {
      enable = true;

      settings = {
        theme = "catppuccin-mocha";
        simplified_ui = true;
        pane_frames = false;
        ui.pane_frames.rounded_corners = true;

        keybinds = {
          move = {
            "bind \"Ctrl l\"" = {
              SwitchToMode = "Normal";
            };
            unbind = "Ctrl h";
          };
          "shared_except \"move\" \"locked\"" = {
            "bind \"Ctrl l\"" = {SwitchToMode = "Move";};
            unbind = "Ctrl h";
          };

          search = {
            "bind \"Ctrl w\"" = {
              SwitchToMode = "Normal";
            };
            unbind = "Ctrl s";
          };
          scroll = {
            "bind \"Ctrl w\"" = {
              SwitchToMode = "Normal";
            };
            unbind = "Ctrl s";
          };
          "shared_except \"scroll\" \"locked\"" = {
            "bind \"Ctrl w\"" = {SwitchToMode = "Scroll";};
            unbind = "Ctrl s";
          };
        };
      };
    };
  };
}
