{ pkgs, ... }: {

  home = {
    username = "kamusari";
    homeDirectory = "/home/kamusari";
    stateVersion = "24.11";
  };

  programs = {
    home-manager = {
      enable = true;
    };

    zsh = {
        enable = true;
        autosuggestion.enable = true;
        oh-my-zsh = {
            enable = true;
            theme = "gentoo";
        };
        shellAliases =
          let
            flakeDir = "~/nix-config/";
          in {
            az = "sudo /nix/store/a800fq9aggnwzv2nq9cfz13sm931ad45-amnezia-vpn-4.8.3.1//bin/AmneziaVPN-service";
            rb = "sudo nixos-rebuild switch --flake ${flakeDir}";
            upd = "nix flake update ${flakeDir}";
            upg = "sudo nixos-rebuild switch --upgrade --flake ${flakeDir}";

            hms = "home-manager switch --flake ${flakeDir}";

            conf = "code ${flakeDir}";
          };
      };

      git = {
        enable = true;
        userName = "kamusari1337";
        userEmail = "ovsyannikovkostyan@gmail.com";
      };
  };

}
