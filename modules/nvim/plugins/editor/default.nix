{
  imports = [
    ./telescope.nix
    ./mini.nix
    ./toggleterm.nix
  ];

  keymaps = [
    { mode = [ "n" ]; key = "<leader>e"; action = "<cmd>Ex<cr>"; options.desc = "Open Explorer"; }
  ];
}
