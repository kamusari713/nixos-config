{
  programs = {
    steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
      localNetworkGameTransfers.openFirewall = true;
    };

    zsh = {
      enable = true;
    };

    dconf = {
      enable = true;
    };

    hyprland = {
      enable = true;
      xwayland.enable = true;
    };
  };
}
