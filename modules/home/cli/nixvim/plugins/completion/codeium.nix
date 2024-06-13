{pkgs, ...}: {
  programs.nixvim.plugins = {
    codeium-nvim = {
      enable = true;
      tools = {
        curl = "${pkgs.curl}/bin/curl";
        gzip = "${pkgs.gzip}/bin/gzip";
      };
    };
  };
}
