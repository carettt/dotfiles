{
  description = "NixOS Config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";

    stylix = {
      url = "github:carettt/stylix/4ab4a7dda6c45d2deaa0f5f77d6d89013a51381e";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, ... }@inputs: {
    nixosConfigurations.patch = inputs.nixpkgs.lib.nixosSystem {
      specialArgs = {inherit inputs;};
      modules = [
        ./config/configuration.nix
        inputs.home-manager.nixosModules.home-manager
        inputs.stylix.nixosModules.stylix
        { nix.nixPath = [ "nixpkgs=${inputs.nixpkgs}" ]; }
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
