{pkgs, ...}: {
  programs.nixvim.plugins = {
    codeium-nvim = {
      enable = true;
      settings.tools = {
        curl = "${pkgs.curl}/bin/curl";
        gzip = "${pkgs.gzip}/bin/gzip";
      };
    };
  };
}
