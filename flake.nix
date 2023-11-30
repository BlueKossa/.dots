{
  description = "NixOS Flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-23.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, home-manager, ... } @ inputs:
  let
    inherit (self) outputs;
    system = "x86_64-linux";

    pkgs = import nixpkgs {
        inherit system;

        config = {
          allowUnfree = true;
        };
        overlays = [
          (self: super: {
            discord = super.discord.overrideAttrs (
              _: { src = builtins.fetchTarball {
                url = "https://discord.com/api/download?platform=linux&format=tar.gz";
                sha256 = "sha256:0rcg7mcw2mqklpxj2ygxgg624zx3p2xq2b32anbfvkgfy2pkvfrp";
              }; 
              }
            );
          })
        ];
    };

    unstable = import nixpkgs-unstable {
        inherit system;

        config = {
          allowUnfree = true;
        };
    };
  in
  {
    nixosConfigurations = {
      desk1 = nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit inputs outputs;
        };
        modules = [
          ./nixos/configuration.nix
          (import ./nixos/hardware-configuration__desk1.nix)
        ];
      };
      desk2 = nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit inputs outputs;
        };
        modules = [
          ./nixos/configuration.nix
          (import ./nixos/hardware-configuration__desk2.nix)
        ];
      };
    };
    homeConfigurations = {
      # FIXME replace with your username@hostname
      "bluecore@nixos" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.${system};
        extraSpecialArgs = {inherit inputs outputs pkgs unstable;};
        modules = [
          # > Our main home-manager configuration file <
          ./home-manager/home.nix
        ];
      };
    };
  };
}
