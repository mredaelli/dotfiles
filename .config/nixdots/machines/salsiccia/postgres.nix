{ config, pkgs, ... }:
{
  services.postgresql = {
    enable = true;
    ensureDatabases = [ "wallabag" "nextcloud" ];
    package = pkgs.postgresql_14;
    ensureUsers = [
      {
        name = "nextcloud";
        ensureDBOwnership = true;#ensurePermissions."DATABASE nextcloud" = "ALL PRIVILEGES";
      }
      {
        name = "wallabag";
        ensureDBOwnership = true;#ensurePermissions."DATABASE wallabag" = "ALL PRIVILEGES";
      }
    ];
  };
}
