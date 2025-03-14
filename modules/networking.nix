{
  networking = {
    hostName = "nixos";
    networkmanager.enable = true;
    nftables.enable = true;
    firewall.enable = false;
  };
}
