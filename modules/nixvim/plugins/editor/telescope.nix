{
  plugins.telescope = {
    enable = true;

    extensions.ui-select.enable = true;
    extensions.fzf-native.enable = true;

    settings = {
      pickers.find_files = {
        hidden = true;
      };
      pickers.git_files = {
        hidden = true;
      };
    };

    keymaps = {
      "<leader>," = {
        action = "buffers";
        options.desc = "Switch Buffers";
      };
      "<leader>." = {
        action = "live_grep";
        options.desc = "Grep (root dir)";
      };
      "<leader>:" = {
        action = "command_history";
        options.desc = "Command History";
      };
      "<leader><space>" = {
        action = "git_files";
        options.desc = "Git Files";
      };

      # Find
      "<leader>fb" = {
        action = "buffers";
        options.desc = "Find Buffer";
      };
      "<leader>ff" = {
        action = "find_files";
        options.desc = "Find File";
      };
      "<leader>fg" = {
        action = "git_files";
        options.desc = "Find Git File";
      };
      "<leader>fr" = {
        action = "oldfiles";
        options.desc = "Find Recent File";
      };

      # Git
      "<leader>gc" = {
        action = "git_commits";
        options.desc = "Search Git Commits";
      };
      "<leader>gs" = {
        action = "git_status";
        options.desc = "Search Git Status";
      };

      # Search
      "<leader>sa" = {
        action = "autocommands";
        options.desc = "Search Auto Commands";
      };
      "<leader>sb" = {
        action = "current_buffer_fuzzy_find";
        options.desc = "Search Current Buffer";
      };
      "<leader>sc" = {
        action = "command_history";
        options.desc = "Search Command History";
      };
      "<leader>sC" = {
        action = "commands";
        options.desc = "Search Commands";
      };
      "<leader>sg" = {
        action = "live_grep";
        options.desc = "Search Grep";
      };
      "<leader>sh" = {
        action = "help_tags";
        options.desc = "Search Help Pages";
      };
      "<leader>sH" = {
        action = "highlights";
        options.desc = "Search Highlight Groups";
      };
      "<leader>sk" = {
        action = "keymaps";
        options.desc = "Search Key Maps";
      };
      "<leader>sm" = {
        action = "marks";
        options.desc = "Go to Mark";
      };
      "<leader>sM" = {
        action = "man_pages";
        options.desc = "Search Man Pages";
      };
      "<leader>so" = {
        action = "vim_options";
        options.desc = "Search Options";
      };
      "<leader>sr" = {
        action = "registers";
        options.desc = "Search Registers";
      };
      "<leader>sR" = {
        action = "resume";
        options.desc = "Search Resume";
      };
      "<leader>ss" = {
        action = "lsp_document_symbols";
        options.desc = "Go to Symbol";
      };
      "<leader>sS" = {
        action = "lsp_dynamic_workspace_symbols";
        options.desc = "Go to Symbol (Workspace)";
      };
    };
  };
}
