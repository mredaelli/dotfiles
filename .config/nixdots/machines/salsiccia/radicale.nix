{ config, pkgs, ... }:
{
  services.radicale = {
    enable = true;
    config = ''
      [auth]
      type = htpasswd
      htpasswd_filename = /var/secrets/radicale.users
      htpasswd_encryption = plain
    '';
  };
  services.nginx.virtualHosts."dav.typish.io" = {
    enableACME = true;
    forceSSL = true;
    locations."/" = {
      proxyPass = "http://localhost:5232/";
      extraConfig = ''
        proxy_set_header  X-Script-Name /;
        proxy_pass_header Authorization;
      '';
    };
  };
}
