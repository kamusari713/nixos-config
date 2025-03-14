{ pkgs, ... }: {
  services = {
    keyd = {
      enable = true;
      keyboards = {
        default = {
          ids = [ "*" ];
          settings = {
            main = {
              capslock = "overload(meta, esc)";
            };
          };
        };
      };
    };

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
}
