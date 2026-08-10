{
  description = "macOS provisioning via nix-darwin";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, darwin }: {
    darwinConfigurations = {
      base = darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        modules = [ ./modules/base.nix ];
      };

      work = darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        modules = [ ./modules/base.nix ./modules/work.nix ];
      };
    };
  };
}
