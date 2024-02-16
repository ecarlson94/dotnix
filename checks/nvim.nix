{ nvim
, system
, nixvim
, ...
}:
nixvim.lib.${system}.check.mkTestDerivationFromNvim {
  inherit nvim;
  name = "A nixvim configuration";
}
