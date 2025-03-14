{ pkgs, ... }:
let
  flakeDir = "~/nixos-config";

  nixvim = import (builtins.fetchGit {
    url = "https://github.com/nix-community/nixvim";
    ref = "main";
  });
in
{
  imports = [
    nixvim.homeManagerModules.nixvim
    ./nixvim
  ];

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
    home-manager = {
      enable = true;
    };

    bash = {
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
        rb = "sudo nixos-rebuild switch --flake ${flakeDir} --impure";
        upd = "nix flake update ${flakeDir} --impure";
        upg = "sudo nixos-rebuild switch --upgrade --flake ${flakeDir} --impure";
        hms = "home-manager switch --flake ${flakeDir} --impure";

        df = "sudo rsync -av --progress --include=\".*\" ~/nixos-config/dotfiles/ ~/";

        cls = "clear";
        ls = "ls -lh";
      };
    };

    java = {
      enable = true;
      package = pkgs.jdk21;
    };

    git = {
      enable = true;
      userName = "kamusari713";
      userEmail = "ovsyannikovkostyan@gmail.com";
    };
  };
}
