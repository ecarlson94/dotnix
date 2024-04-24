{
  imports = [
    ./conform-nvim.nix
    ./lualine.nix
    ./mini.nix
    ./telescope.nix
    ./toggleterm.nix
    ./trouble.nix
    ./which-key.nix
  ];

  keymaps = [
    {
      mode = ["n"];
      key = "<leader>e";
      action = "<cmd>Ex<cr>";
      options.desc = "Open Explorer";
    }
  ];
}
