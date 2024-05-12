{
  plugins.oil = {
    enable = true;

    settings = {
      default_file_explorer = true;

      float = {
        max_height = 25;
        max_width = 75;
      };

      view_options.show_hidden = true;
    };
  };

  keymaps = [
    {
      mode = ["n"];
      key = "<leader>e";
      action = "<cmd>Oil<cr>";
      options.desc = "Open Explorer";
    }
  ];
}
