{ config, pkgs, ... }:
let host = "next.typish.io";
in
{
  services.nextcloud = {
    enable = true;
    package = pkgs.nextcloud23;
    hostName = host;
    https = true;
    autoUpdateApps.enable = true;
    autoUpdateApps.startAt = "04:00:00";
    home = "/data/nextcloud";

    config = {
      overwriteProtocol = "https";

      dbtype = "pgsql";
      dbuser = "nextcloud";
      dbhost = "/run/postgresql";
      dbname = "nextcloud";
      dbpassFile = "/var/secrets/nextcloud-db-pass";

      adminpassFile = "/var/secrets/nextcloud-admin-pass";
      adminuser = "admin";
    };
  };
  services.nginx.virtualHosts.${host} = {
    forceSSL = true;
    enableACME = true;
  };
  systemd.services."nextcloud-setup" = {
    requires = [ "postgresql.service" ];
    after = [ "postgresql.service" ];
  };
}
# sudo - i nextcloud-occ maintenance:mode - -on
# sudo - i nextcloud-occ db:convert-filecache-bigint
# sudo - i nextcloud-occ maintenance:mode - -off
