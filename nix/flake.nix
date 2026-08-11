{
  description = "macOS provisioning via nix-darwin";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, darwin, home-manager }: {
    darwinConfigurations = {
      base = darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        modules = [
          ./modules/base.nix
          home-manager.darwinModules.home-manager
          ./modules/home.nix
        ];
      };

      work = darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        modules = [
          ./modules/base.nix
          home-manager.darwinModules.home-manager
          ./modules/home.nix
          ./modules/work.nix
        ];
      };
    };
  };
}
