{
  programs.nixvim.plugins.harpoon = {
    enable = true;
    markBranch = true;
    saveOnToggle = true;

    keymaps = {
      toggleQuickMenu = "<C-e>";
      addFile = "<C-a>";

      navFile = {
        "1" = "<A-a>";
        "2" = "<A-o>";
        "3" = "<A-e>";
        "4" = "<A-u>";
      };
    };
  };
}
