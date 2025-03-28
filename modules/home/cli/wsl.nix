{
  hostConfig,
  lib,
  pkgs,
  ...
}:
with lib; {
  config = mkIf hostConfig.wsl.enable {
    home = {
      packages = with pkgs; [
        wslu
        wsl-open
        (pkgs.writeShellScriptBin "xdg-open" "exec -a $0 ${wsl-open}/bin/wsl-open $@")
      ];

      sessionVariables = {
        BROWSER = "wsl-open";
      };

      persistence."/persist/home" = lib.mkIf hostConfig.system.impermanence.enable {
        directories = [
          ".config/wslu"
        ];
      };
    };
  };
}
