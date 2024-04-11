{
  plugins.toggleterm = {
    enable = true;

    autoScroll = true;
    closeOnExit = true;
    direction = "horizontal";
    hideNumbers = true;
    persistMode = true;
    persistSize = true;
    shadeTerminals = true;
    shadingFactor = -30;
    size = 15;
    startInInsert = true;
    floatOpts.border = "curved";
  };

  keymaps = [
    {
      mode = ["t" "n"];
      key = "<leader>th";
      action = "<cmd>1ToggleTerm<cr>";
      options.desc = "Open/Close Terminal 1";
    }
    {
      mode = ["t" "n"];
      key = "<leader>tn";
      action = "<cmd>2ToggleTerm<cr>";
      options.desc = "Open/Close Terminal 2";
    }
    {
      mode = ["t" "n"];
      key = "<leader>tf";
      action = "<cmd>3ToggleTerm direction=float<cr>";
      options.desc = "Open/Close Floating Terminal";
    }
    {
      mode = ["t"];
      key = "jk";
      action = "<C-\\><C-n>";
      options.desc = "Quick exit terminal mode";
    }
    {
      mode = ["t"];
      key = "<C-h>";
      action = "<cmd>wincmd h<cr>";
      options.desc = "Go to left window";
    }
    {
      mode = ["t"];
      key = "<C-j>";
      action = "<cmd>wincmd j<cr>";
      options.desc = "Go to lower window";
    }
    {
      mode = ["t"];
      key = "<C-k>";
      action = "<cmd>wincmd k<cr>";
      options.desc = "Go to upper window";
    }
    {
      mode = ["t"];
      key = "<C-l>";
      action = "<cmd>wincmd l<cr>";
      options.desc = "Go to right window";
    }
  ];
}
