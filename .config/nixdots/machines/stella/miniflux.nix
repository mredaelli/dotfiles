{ config, pkgs, ... }:
{
  services.miniflux = {
    enable = true;
    adminCredentialsFile = /var/secrets/miniflux;
    config = {
      LISTEN_ADDR = "localhost:8816";
      BASE_URL = "https://mini.typish.io/";
      # DEBUG = "1";
    };
  };

  services.nginx.virtualHosts."mini.typish.io" = {
    enableACME = true;
    forceSSL = true;
    locations."/" = {
      proxyPass = "http://localhost:8816";
      extraConfig = ''
        proxy_redirect off;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
      '';
    };
  };
}
