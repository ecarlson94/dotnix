{
  plugins.telescope = {
    enable = true;

    extensions.ui-select.enable = true;
    extensions.fzf-native.enable = true;

    extraOptions = {
      pickers.find_files = {
        hidden = true;
      };
      pickers.git_files = {
        hidden = true;
      };
    };

    keymaps = {
      "<leader>," = { action = "buffers"; desc = "Switch Buffers"; };
      "<leader>." = { action = "live_grep"; desc = "Grep (root dir)"; };
      "<leader>:" = { action = "command_history"; desc = "Command History"; };
      "<leader><space>" = { action = "git_files"; desc = "Git Files"; };

      # Find
      "<leader>fb" = { action = "buffers"; desc = "Find Buffer"; };
      "<leader>ff" = { action = "find_files"; desc = "Find File"; };
      "<leader>fg" = { action = "git_files"; desc = "Find Git File"; };
      "<leader>fr" = { action = "oldfiles"; desc = "Find Recent File"; };

      # Git
      "<leader>gc" = { action = "git_commits"; desc = "Search Git Commits"; };
      "<leader>gs" = { action = "git_status"; desc = "Search Git Status"; };

      # Search
      "<leader>sa" = { action = "autocommands"; desc = "Search Auto Commands"; };
      "<leader>sb" = { action = "current_buffer_fuzzy_find"; desc = "Search Current Buffer"; };
      "<leader>sc" = { action = "command_history"; desc = "Search Command History"; };
      "<leader>sC" = { action = "commands"; desc = "Search Commands"; };
      "<leader>sg" = { action = "live_grep"; desc = "Search Grep"; };
      "<leader>sh" = { action = "help_tags"; desc = "Search Help Pages"; };
      "<leader>sH" = { action = "highlights"; desc = "Search Highlight Groups"; };
      "<leader>sk" = { action = "keymaps"; desc = "Search Key Maps"; };
      "<leader>sm" = { action = "marks"; desc = "Go to Mark"; };
      "<leader>sM" = { action = "man_pages"; desc = "Search Man Pages"; };
      "<leader>so" = { action = "vim_options"; desc = "Search Options"; };
      "<leader>sr" = { action = "registers"; desc = "Search Registers"; };
      "<leader>sR" = { action = "resume"; desc = "Search Resume"; };
      "<leader>ss" = { action = "lsp_document_symbols"; desc = "Go to Symbol"; };
      "<leader>sS" = { action = "lsp_dynamic_workspace_symbols"; desc = "Go to Symbol (Workspace)"; };
    };
  };
}
