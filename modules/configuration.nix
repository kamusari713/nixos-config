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
            enable = true;
            alsa.enable = true;
            alsa.support32Bit = true;
            pulse.enable = true;
            wireplumber.enable = true;
        };
    };

    environment.etc."wireplumber/main.lua.d/50-disable-auto-adjust.lua".text = ''
    table.insert(config.rules, {
        matches = {
            {
                -- Отключает автонастройку микрофона
                { "node.name", "matches", "alsa_input.*" }
            }
        },
        apply_properties = {
            ["session.suspend-timeout-seconds"] = 0,
            ["node.nick"] = "Disabled Auto Adjust",
            ["audio.adaptive-resampler"] = false
        }
    })
    '';

    programs = {
        steam = {
            enable = true;
            extraPackages = with pkgs; [ libpulseaudio ];
            remotePlay.openFirewall = true;
            dedicatedServer.openFirewall = true;
            localNetworkGameTransfers.openFirewall = true;
        };

        hyprland = {
            enable = true;
            xwayland.enable = true;
        };

        zsh.enable = true;
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
        extraGroups = [ "audio" "input" "networkmanager" "wheel" ];
        shell = pkgs.zsh;
    };

    environment.systemPackages = with pkgs; [
        wget
        git
        kitty
        pavucontrol
        home-manager

        nautilus
        waybar
        rofi-wayland
        hyprpicker
        bibata-cursors

        hyprshot
        swaybg
        mako
        wl-clipboard
        cliphist

        google-chrome
        telegram-desktop
        vesktop
        protonup

        vscode
        jetbrains.idea-community
        nodejs_23
        (jdk21.override { enableJavaFX = true; })
        maven

        cbonsai
        cmatrix
        fd
        htop
        zsh
    ] ++ (with unstable; [
        amnezia-vpn
    ]);

    system.stateVersion = "24.11";

}
