{
    description = "My nixos flake";

    inputs = {

        nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
        nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

        home-manager = {
            url = "github:nix-community/home-manager/release-24.11";
            inputs.nixpkgs.follows = "nixpkgs";
        };

    };

    outputs = {
        nixpkgs,
        nixpkgs-unstable,
        home-manager,
        ... } @inputs:
    let
        lib = nixpkgs.lib;
        system = "x86_64-linux";
        pkgs = nixpkgs.legacyPackages.${system};
    in {

        homeConfigurations.kamusari = home-manager.lib.homeManagerConfiguration {
            inherit pkgs;
            extraSpecialArgs = { inherit inputs; };
            modules = [
                ./home-manager/home.nix
            ];
        };

        nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
            specialArgs = {
                inherit inputs;
                unstable = import inputs.nixpkgs-unstable {
                    inherit system;
                    config.allowUnfree = true;
                };
            };

            modules = [
                ./modules/configuration.nix
            ];
        };

    };

}
