{ config, pkgs, ... }:
{
  imports =
    [
      ./hardware-configuration.nix
      ../../modules/common_settings.nix
      ../../modules/server.nix
      ../../modules/user.nix

      ./postgres.nix
      ./nginx.nix
      ../../modules/wallabag.nix
      ./wallabag.nix
      ./miniflux.nix
      ./vaultwarden.nix
      ./nextcloud.nix

      # ./postfix.nix
      #      ./syncthing.nix
      #      ./radicale.nix
    ];

  security.acme = {
    defaults.email = "massimo.acme@typish.io";
    acceptTerms = true;
  };

  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  boot.loader.grub.device = "/dev/sda";

  networking.hostName = "salsiccia";

  networking.useDHCP = false;
  networking.interfaces.enp1s0.useDHCP = true;

  # environment.noXlibs = true;

  system.autoUpgrade.enable = true;
  services.openssh.enable = true;

  networking.firewall.allowedTCPPorts = [ 22 80 443 ];

  system.stateVersion = "20.03"; # Did you read the comment?
}
