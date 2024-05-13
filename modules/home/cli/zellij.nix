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
      catppuccin.enable = true;

      settings = {
        simplified_ui = true;
        pane_frames = false;
        ui.pane_frames.rounded_corners = true;

        keybinds = {
          move = {
            "bind \"Ctrl m\"" = {
              SwitchToMode = "Normal";
            };
            unbind = "Ctrl h";
          };
          "shared_except \"move\" \"locked\"" = {
            "bind \"Ctrl m\"" = {SwitchToMode = "Move";};
            unbind = "Ctrl h";
          };

          search = {
            "bind \"Ctrl ,\"" = {
              SwitchToMode = "Normal";
            };
            unbind = "Ctrl s";
          };
          scroll = {
            "bind \"Ctrl ,\"" = {
              SwitchToMode = "Normal";
            };
            unbind = "Ctrl s";
          };
          "shared_except \"scroll\" \"locked\"" = {
            "bind \"Ctrl ,\"" = {SwitchToMode = "Scroll";};
            unbind = "Ctrl s";
          };
        };
      };
    };
  };
}
