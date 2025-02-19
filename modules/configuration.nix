{ config, lib, pkgs, unstable, inputs, ... }:

{
  imports =
  [
    ./hardware-configuration.nix
    inputs.home-manager.nixosModules.default
  ];

  home-manager = {
    users = {
      kamusari = import ../home-manager/home.nix;
    };
    backupFileExtension = "backup";
  };

  programs = {
    zsh.enable = true;

    dconf.enable = true;

    hyprland = {
      enable = true;
      xwayland.enable = true;
    };
  };

  systemd = {
    services = {
      "getty@tty1".enable = false;
      "autovt@tty1".enable = false;

      amnezia-vpn = {
        description = "Amnezia VPN Service";
        after = [ "network-online.target" ];
        wants = [ "network-online.target" ];
        wantedBy = [ "multi-user.target" ];

        serviceConfig = {
          ExecStart = "${unstable.amnezia-vpn}/bin/AmneziaVPN-service";
          Restart = "always";
          Environment = "PATH=/run/current-system/sw/bin";
        };
      };
      amnezia-vpn-gui = {
        description = "Amnezia VPN GUI";
        after = [ "network-online.target" ];
        wants = [ "network-online.target" ];
        wantedBy = [ "multi-user.target" ];

        serviceConfig = {
          ExecStart = "${unstable.amnezia-vpn}/bin/AmneziaVPN";
          Restart = "always";
          Environment = "PATH=/run/current-system/sw/bin";
        };
      };
    };
  };

  disabledModules = [ "services/networking/zapret.nix" ];

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };

  networking.nftables.enable = true;

  hardware = {
    graphics.enable = true;
    nvidia ={
      modesetting.enable = true;
      powerManagement.enable = false;
      powerManagement.finegrained = false;
      open = false;
      nvidiaSettings = false;
      package = config.boot.kernelPackages.nvidiaPackages.beta;
    };
  };

  nix = {
    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];
    };
  };

  nixpkgs.config.allowUnfree = true;

  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
      efi.efiSysMountPoint = "/boot";
    };
    kernelPackages = pkgs.linuxPackages;
  };

  networking = {
    hostName = "nixos";
    networkmanager.enable = true;
    firewall.enable = false;
  };

  virtualisation = {
    docker = {
      enable = true;
    };
  };

  services = {
    openssh.enable = true;

    redis = {
      servers = {
        kaidan-redis-dev = {
          enable = true;
          port = 6379;
        };
      };
    };

    mongodb = {
      enable = true;
      package = pkgs.mongodb-ce;
      bind_ip = "127.0.0.1";
    };

    xserver = {
      enable = true;
      displayManager.gdm.enable = true;
      xkb.layout = "us,ru";
      videoDrivers = [ "nvidia" ];
    };

    displayManager.autoLogin = {
      enable = true;
      user = "kamusari";
    };

    libinput.enable = true;

    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      wireplumber.enable = true;
    };
  };

  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;
    config = {
      common.default = [ "gtk" ];
      hyprland.default = [
        "gtk"
        "hyprland"
        "wlr"
      ];
    };
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal-hyprland
    ];
  };

  fonts.packages = with pkgs; [
    jetbrains-mono
    fira-code
    iosevka
    montserrat
    (nerdfonts.override { fonts = [ "Iosevka" ]; })
  ];

  time.timeZone = "Europe/Astrakhan";

  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
      LC_ADDRESS = "ru_RU.UTF-8";
      LC_IDENTIFICATION = "ru_RU.UTF-8";
      LC_MEASUREMENT = "ru_RU.UTF-8";
      LC_MONETARY = "ru_RU.UTF-8";
      LC_NAME = "ru_RU.UTF-8";
      LC_NUMERIC = "ru_RU.UTF-8";
      LC_PAPER = "ru_RU.UTF-8";
      LC_TELEPHONE = "ru_RU.UTF-8";
      LC_TIME = "ru_RU.UTF-8";
    };
  };

  users.users.kamusari = {
    isNormalUser = true;
    extraGroups = [ "docker" "audio" "input" "networkmanager" "wheel" ];
    shell = pkgs.zsh;
  };

  environment.systemPackages = with pkgs; [
    wget
    git
    kitty
    vim
    neovim
    lazygit

    pavucontrol
    home-manager
    xdg-utils
    waybar
    rofi-wayland
    bibata-cursors
    gruvbox-gtk-theme

    hyprshot
    swaybg
    mako
    wl-clipboard
    cliphist

    google-chrome
    telegram-desktop
    vesktop

    nodejs_23
    jdk21
    maven
    jetbrains.idea-community
    mongosh
    postman

    tmux
    yazi
    toilet
    cbonsai
    cmatrix
    fd
    htop
    zsh
  ] ++ (with unstable; [
    amnezia-vpn
    vscode
  ]);

  system.stateVersion = "24.11";

}
