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
      "<leader>/" = { action = "live_grep"; desc = "Grep (root dir)"; };
      "<leader>:" = { action = "command_history"; desc = "Command History"; };
      "<leader><space>" = { action = "git_files"; desc = "Git Files"; };

      # Find
      "<leader>fb" = { action = "buffers"; desc = "Buffers"; };
      "<leader>ff" = { action = "find_files"; desc = "Find Files"; };
      "<leader>fg" = { action = "git_files"; desc = "Git Files"; };
      "<leader>fr" = { action = "oldfiles"; desc = "Recent Files"; };

      # Git
      "<leader>gc" = { action = "git_commits"; desc = "Git Commits"; };
      "<leader>gs" = { action = "git_status"; desc = "Git Status"; };

      # Search
      "<leader>sa" = { action = "autocommands"; desc = "Auto Commands"; };
      "<leader>sb" = { action = "current_buffer_fuzzy_find"; desc = "Current Buffer"; };
      "<leader>sc" = { action = "command_history"; desc = "Command History"; };
      "<leader>sC" = { action = "commands"; desc = "Commands"; };
      "<leader>sg" = { action = "live_grep"; desc = "Grep"; };
      "<leader>sh" = { action = "help_tags"; desc = "Help Pages"; };
      "<leader>sH" = { action = "highlights"; desc = "Highlight Groups"; };
      "<leader>sk" = { action = "keymaps"; desc = "Key Maps"; };
      "<leader>sm" = { action = "marks"; desc = "Go to Mark"; };
      "<leader>sM" = { action = "man_pages"; desc = "Man Pages"; };
      "<leader>so" = { action = "vim_options"; desc = "Options"; };
      "<leader>sr" = { action = "registers"; desc = "Registers"; };
      "<leader>sR" = { action = "resume"; desc = "Resume"; };
      "<leader>ss" = { action = "lsp_document_symbols"; desc = "Go to Symbol"; };
      "<leader>sS" = { action = "lsp_dynamic_workspace_symbols"; desc = "Go to Symbol (Workspace)"; };
    };
  };
}
