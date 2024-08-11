{ config, pkgs, ... }:
let
  domain = "pass.typish.io";
  yubico_secret = builtins.readFile /var/secrets/bitwarden_yubico;
  rocketPort = "3011";
  websocketPort = "3012";
  backupPath = "/var/backups/vaultwarden";
  backupPassFile = "/var/secrets/restic_vaultwarden_pass";
  b2AccountKeysecret = builtins.readFile /var/secrets/restic_vaultwarden_account_key;
  resticConfig = pkgs.writeTextFile {
    name = "restic.env";
    text = ''
      RESTIC_DATA=${backupPath}
      B2_ACCOUNT_ID=000a04ee826917e0000000003
      B2_ACCOUNT_KEY=${b2AccountKeysecret}
    '';
  };
in
{
  services.vaultwarden = {
    enable = true;
    dbBackend = "sqlite";
    backupDir = backupPath;
    config = {
      domain = "https://${domain}";
      smtpHost = "localhost";
      smtpFrom = "bitwarden@typish.io";
      signupsAllowed = "true";
      # YUBICO_CLIENT_ID = 57056;
      # YUBICO_SECRET_KEY = yubico_secret;
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

  services.restic.backups.vaultwarden = {
    initialize = true;
    passwordFile = backupPassFile;
    paths = [ backupPath ];
    pruneOpts = [ "--keep-daily 7" "--keep-weekly 5" "--keep-monthly 12" "--keep-yearly 75" ];
    environmentFile = "${resticConfig}";
    repository = "b2:salsiccia-backup:vaultwarden";
  };
}
