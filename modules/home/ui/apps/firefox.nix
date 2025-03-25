{
  inputs,
  lib,
  config,
  pkgs,
  system,
  ...
}:
with lib; let
  firefox-addons = inputs.firefox-addons.packages.${system};
  cfg = config.ui.apps.firefox;

  lockFalse = {
    Value = false;
    Status = "locked";
  };
  lockTrue = {
    Value = true;
    Status = "locked";
  };
  lockEmptyString = {
    Value = "";
    Status = "locked";
  };
in {
  options.ui.apps.firefox = {enable = mkEnableOption "firefox";};

  config = mkIf cfg.enable {
    programs.firefox = {
      enable = true;

      policies = {
        DisableTelemetry = true;
        DisableFirefoxStudies = true;
        DisablePocket = true;
        SearchBar = "unified";
      };

      profiles.default = {
        id = 0;
        name = "default";
        isDefault = true;

        settings = {
          "browser.search.defaultenginename" = "google";

          # Privacy Settings
          "extensions.pocket.enabled" = lockFalse;
          "browser.topsites.contile.enabled" = lockFalse;
          "browser.newtabpage.pinned" = lockEmptyString;
          "browser.newtabpage.activity-stream.showSponsored" = lockFalse;
          "browser.newtabpage.activity-stream.system.showSponsored" = lockFalse;
          "browser.newtabpage.activity-stream.showSponsoredTopSites" = lockFalse;
          "signon.rememberSignons" = lockFalse;
        };

        extensions.packages = with firefox-addons; [
          bitwarden
          darkreader
          firefox-color
          stylus
          ublock-origin
          vimium
        ];

        search = {
          force = true;
          default = "ddg";
          order = ["ddg" "google"];
          engines = {
            "Nix Packages" = {
              urls = [
                {
                  template = "https://search.nixos.org/packages";
                  params = [
                    {
                      name = "type";
                      value = "packages";
                    }
                    {
                      name = "query";
                      value = "{searchTerms}";
                    }
                  ];
                }
              ];
              icon = "''${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
              definedAliases = ["@np" "@nixpkgs"];
            };
            "Nix Options" = {
              urls = [
                {
                  template = "https://search.nixos.org/options";
                  params = [
                    {
                      name = "type";
                      value = "packages";
                    }
                    {
                      name = "query";
                      value = "{searchTerms}";
                    }
                  ];
                }
              ];
              icon = "''${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
              definedAliases = ["@no" "@nixopts"];
            };
            "NixOS Wiki" = {
              urls = [{template = "https://nixos.wiki/index.php?search={searchTerms}";}];
              iconUpdateUrl = "https://nixos.wiki/favicon.png";
              updateInterval = 24 * 60 * 60 * 1000; # every day
              definedAliases = ["@nw" "@nixwiki"];
            };
            "bing".metaData.hidden = true;
            "google".metaData.alias = "@g"; # builtin engines only support specifying one additional alias
          };
        };
      };
    };
  };
}
