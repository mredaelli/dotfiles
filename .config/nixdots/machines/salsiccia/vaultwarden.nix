{ config, pkgs, ... }:
let
  domain = "pass.typish.io";
  secret = builtins.readFile /var/secrets/bitwarden_yubico;
in
{
  services.vaultwarden = {
    enable = true;
    dbBackend = "sqlite";
    config = {
      SMTP_HOST = "localhost";
      SMTP_FROM = "bitwarden@typish.io";
      SIGNUPS_ALLOWED = "false";
      DOMAIN = "https://${domain}";
      YUBICO_CLIENT_ID = 57056;
      YUBICO_SECRET_KEY = secret;
      # YUBICO_SERVER=http://yourdomain.com/wsapi/2.0/verify
      ROCKET_ENV = "production";
      ROCKET_ADDRESS = "127.0.0.1";
      ROCKET_PORT = 8815;
    };
  };

  services.nginx.virtualHosts.${domain} = {
    enableACME = true;
    forceSSL = true;
    locations."/" = {
      proxyPass = "http://localhost:8815";
      proxyWebsockets = true;
    };
    locations."/notifications/hub" = {
      proxyPass = "http://localhost:3012";
      proxyWebsockets = true;
    };
    locations."/notifications/hub/negotiate" = {
      proxyPass = "http://localhost:8815";
      proxyWebsockets = true;
    };
  };
}
