{ config, lib, pkgs, ... }:
{
    imports =
    [
        ./hardware-configuration.nix
    ];

    disabledModules = [ "services/networking/zapret.nix" ];

    nix.gc = {
        automatic = true;
        dates = "weekly";
        options = "--delete-older-than 14d";
    };

    networking.nftables.enable = true;

    hardware = {
        graphics.enable = true;
        nvidia ={
            modesetting.enable = true;
            powerManagement.enable = false;
            powerManagement.finegrained = false;
            open = false;
            nvidiaSettings = true;
            package = config.boot.kernelPackages.nvidiaPackages.beta;
        };
    };

    environment.sessionVariables = {
        WRL_NO_HARDWARE_CURSORS = "1";
        NIXOS_OZONE_WL = "1";
    };

    nix = {
        settings = {
            experimental-features = [
                "nix-command"
                "flakes"
            ];
        };
    };

    nixpkgs = {
        config = {
            allowUnfree = true;
            packageOverrides = pkgs: {
                unstable = import (fetchTarball "https://github.com/NixOS/nixpkgs/archive/nixos-unstable.tar.gz") {};
            };
        };
    };

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

    services = {
        openssh.enable = true;

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
            alsa.enable = true;
            alsa.support32Bit = true;
            enable = true;
            pulse.enable = true;
            wireplumber.enable = true;
        };
    };

    security.rtkit.enable = true;

    programs = {
        steam = {
            enable = true;
            remotePlay.openFirewall = true;
            dedicatedServer.openFirewall = true;
            localNetworkGameTransfers.openFirewall = true;
        };

        zsh = {
            enable = true;
            ohMyZsh = {
                enable = true;
                theme = "gentoo";
            };
            shellAliases = {
                rebuild = "sudo nixos-rebuild switch";
                amnezia-service = "sudo /nix/store/a800fq9aggnwzv2nq9cfz13sm931ad45-amnezia-vpn-4.8.3.1//bin/AmneziaVPN-service";
            };
        };

        hyprland = {
            enable = true;
            xwayland.enable = true;
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
            pkgs.xdg-desktop-portal-gnome
        ];
    };

    fonts.packages = with pkgs; [
        jetbrains-mono
        fira-code
        iosevka
        nerdfonts
        ubuntu-sans
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
        extraGroups = [ "audio" "input" "networkmanager" "wheel" ];
        packages = with pkgs; [];
        shell = pkgs.zsh;
    };

    environment.systemPackages = with pkgs; [
        vim
        wget
        git
        kitty
        unstable.nautilus
        pavucontrol

        waybar
        rofi-wayland
        hyprpicker
        hyprcursor
        wayland-protocols

        hyprshot
        swaybg
        mako

        google-chrome
        telegram-desktop
        vesktop
        unstable.amnezia-vpn
        protonup

        vscode
        nodejs_23

        cbonsai
        cmatrix
        fd
        htop
        zsh
    ];
    system.stateVersion = "24.11";
}
