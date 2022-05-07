{ config, pkgs, ... }:
let
  domain = "pass.typish.io";
  secret = builtins.readFile /var/secrets/bitwarden_yubico;
  rocketPort = "3011";
  websocketPort = "3012";
in
{
  services.vaultwarden = {
    enable = true;
    dbBackend = "sqlite";
    config = {
      domain = "https://${domain}";
      smtpHost = "localhost";
      smtpFrom = "bitwarden@typish.io";
      signupsAllowed = "true";
      # YUBICO_CLIENT_ID = 57056;
      # YUBICO_SECRET_KEY = secret;
      # YUBICO_SERVER=http://yourdomain.com/wsapi/2.0/verify
      rocketPort = rocketPort;
      websocketPort = websocketPort;
    };
  };

  services.nginx.virtualHosts."pass.typish.io" = {
    enableACME = true;
    forceSSL = true;
    extraConfig = ''
      client_max_body_size 128M;
    '';
    locations."/" = {
      proxyPass = "http://127.0.0.1:${rocketPort}";
      proxyWebsockets = true;
    };
    locations."/notifications/hub" = {
      proxyPass = "http://localhost:${websocketPort}";
      proxyWebsockets = true;
    };
    locations."/notifications/hub/negotiate" = {
      proxyPass = "http://localhost:${rocketPort}";
      proxyWebsockets = true;
    };
  };
}
