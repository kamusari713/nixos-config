{ unstable, ... }: {
  environment.systemPackages = with unstable; [
    # Terminal
    ghostty

    # General CLI utilities
    cbonsai
    cmatrix
    fd
    fzf
    git
    htop
    lazygit
    tmux
    toilet
    unzip
    wget
    yazi
    zsh

    # For make / qmake stuff
    autoconf
    automake
    bison
    flex
    gcc
    gnumake
    libiconv
    libtool
    makeWrapper
    pkg-config

    # Utilities
    cliphist
    home-manager
    hyprshot
    mako
    pavucontrol
    swaybg
    wl-clipboard
    xdg-utils

    # GUI / Desktop extras
    bibata-cursors
    gruvbox-gtk-theme
    rofi-wayland
    waybar

    # Social and etc ...
    amnezia-vpn
    google-chrome
    prismlauncher
    telegram-desktop
    vesktop

    # LibreOffice
    libreoffice-qt
    hunspell
    hunspellDicts.ru_RU

    # Workflow
    jdk21
    maven
    mongosh
    nodejs_23
    obsidian
    postman
  ];
  # ++ (with pkgs; [
  # ]);
}
