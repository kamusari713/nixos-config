{ inputs, ... }: {
  imports = [
    ./boot.nix
    ./fonts.nix
    ./gc.nix
    ./hardware-configuration.nix
    ./hardware.nix
    ./home.nix
    ./networking.nix
    ./packages.nix
    ./programs.nix
    ./services.nix
    ./settings.nix
    ./systemd.nix
    ./xdg.nix

    inputs.home-manager.nixosModules.default
  ];
}
