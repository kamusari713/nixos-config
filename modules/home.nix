{ pkgs, ... }: {
  home-manager = {
    users = {
      kamusari = import ../home-manager/home.nix;
    };
    backupFileExtension = "backup";
  };

  users.users.kamusari = {
    isNormalUser = true;
    extraGroups = [ "docker" "audio" "input" "networkmanager" "wheel" ];
    shell = pkgs.zsh;
  };

  system.stateVersion = "24.11";
}
