{ config, pkgs, ... }:
{
  imports =
    [
      ./hardware-configuration.nix
      ../../modules/common_settings.nix
      ../../modules/server.nix
      ../../modules/user.nix

      ./postgres.nix
      ./postfix.nix
      ./nginx.nix
      ../../modules/wallabag.nix
      ./wallabag.nix
      ./miniflux.nix
      ./vaultwarden.nix

      #      ./syncthing.nix
      #      ./radicale.nix
    ];

  security.acme = {
    email = "massimo.acme@typish.io";
    acceptTerms = true;
  };

  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  boot.loader.grub.device = "/dev/sda";

  networking.hostName = "salsiccia";

  networking.useDHCP = false;
  networking.interfaces.enp1s0.useDHCP = true;

  environment.noXlibs = true;

  system.autoUpgrade.enable = true;
  services.openssh.enable = true;

  networking.firewall.allowedTCPPorts = [ 22 80 443 53589 ];

  virtualisation.docker.enable = true;

  #services.nginx.virtualHosts."sync.typish.io" =  {
  #enableACME = true;
  #forceSSL = true;
  #locations."/" = {
  #proxyPass = "http://localhost:8080/";
  #extraConfig = ''
  #proxy_set_header   Host $host;
  #proxy_set_header   X-Real-IP $remote_addr;
  #proxy_set_header   X-Forwarded-For $proxy_add_x_forwarded_for;
  #proxy_set_header   X-Forwarded-Host $server_name;
  #proxy_set_header   X-Forwarded-Proto https;
  #client_max_body_size 100M;
  #'';
  #};
  #};
  system.stateVersion = "20.03"; # Did you read the comment?
}
