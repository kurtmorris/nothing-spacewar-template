{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    mobile-nixos = {
      url = "github:kurtmorris/mobile-nixos-spacewar";
      flake = false;
    };
  };
  outputs = { self, nixpkgs, mobile-nixos }:
  let
    commonModules = [
      (import "${mobile-nixos}/lib/configuration.nix" { device = "nothing-spacewar"; })
      ./configuration.nix
    ];
  in
  {
    nixosConfigurations.nothing-spacewar-cross-x86_64-linux = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = commonModules ++ [
        {
          nixpkgs.crossSystem = {
            system = "aarch64-linux";
          };
        }
      ];
    };
    nixosConfigurations.nothing-spacewar = nixpkgs.lib.nixosSystem {
      system = "aarch64-linux";
      modules = commonModules;
    };
  };
}
