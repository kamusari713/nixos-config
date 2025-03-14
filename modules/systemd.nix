{ unstable, ... }: {
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
    };
  };
}
