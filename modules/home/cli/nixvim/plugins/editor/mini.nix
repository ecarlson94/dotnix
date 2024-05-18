{
  programs.nixvim.plugins.mini = {
    enable = true;

    modules = {
      surround = {};
      comment = {};
    };
  };
}
