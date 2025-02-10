{ pkgs, config, lib, ... }:
let
  flakeDir = "~/nixos-config";
in
{

  home = {
    username = "kamusari";
    homeDirectory = "/home/kamusari";
    stateVersion = "24.11";
  };

  gtk = {
    enable = true;
    iconTheme = {
      name = "Gruvbox-dark";
      package = pkgs.gruvbox-dark-icons-gtk;
    };
    theme = {
      name = "Gruvbox-dark";
      package = pkgs.gruvbox-dark-gtk;
    };
  };

  programs = {
    bash = {
      enable = true;
    };

    java = {
      enable = true;
      package = pkgs.jdk21;
    };

    git = {
      enable = true;
      userName = "kamusari713";
      userEmail = "kamusari713@yandex.com";
    };

    home-manager = {
      enable = true;
    };

    zsh = {
      enable = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
      enableCompletion = true;
      history = {
        size = 1000;
      };
      oh-my-zsh = {
        enable = true;
        theme = "gentoo";
        plugins = [ "git" ];
      };
      shellAliases = {
        az = "sudo /nix/store/a800fq9aggnwzv2nq9cfz13sm931ad45-amnezia-vpn-4.8.3.1/bin/AmneziaVPN-service";
        az-permit = "sudo ${flakeDir}/home-manager/scripts/amnezia.sh";

        rb = "sudo nixos-rebuild switch --flake ${flakeDir}";
        upd = "nix flake update ${flakeDir}";
        upg = "sudo nixos-rebuild switch --upgrade --flake ${flakeDir}";

        hms = "home-manager switch --flake ${flakeDir}";

        dfiles = "rsync -av --progress --include=\".*\" ~/nixos-config/dotfiles/ ~/";

        conf = "code ${flakeDir}";

        cls = "clear";
        ls = "ls -lh";
      };
    };
  };
}
