{ pkgs
, nixvim
, system
, ...
}:
let
  config = import ./default.nix;
  nixvim' = nixvim.legacyPackages.${system};
in
nixvim'.makeNixvimWithModule {
  inherit pkgs;
  module = config;
  # You can use `extraSpecialArgs` to pass additional arguments to your module files
  extraSpecialArgs = {
    # inherit (inputs) foo;
  };
}
