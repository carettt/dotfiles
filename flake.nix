{
  description = "NixOS Config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
  };

  outputs = { self, ... }@inputs: {
    nixosConfigurations.patch = inputs.nixpkgs.lib.nixosSystem {
      specialArgs = {inherit inputs;};
      modules = [
        ./config/configuration.nix
        inputs.home-manager.nixosModules.home-manager
      ];
    };

    homeConfigurations."caret@patch" = inputs.home-manager.lib.homeManagerConfiguration {
      pkgs = inputs.nixpkgs.legacyPackages.x86_64-linux;

      modules = [
        inputs.hyprland.homeManagerModules.default
      ];
    };

    homeManagerModules.default = ./modules/home-manager;
  };
}
