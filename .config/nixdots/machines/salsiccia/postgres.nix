{ config, pkgs, ... }:
{
  services.postgresql = {
    enable = true;
    ensureDatabases = [ "wallabag" "nextcloud" ];
    ensureUsers = [
      {
        name = "nextcloud";
        ensurePermissions."DATABASE nextcloud" = "ALL PRIVILEGES";
      }
      {
        name = "wallabag";
        ensurePermissions."DATABASE wallabag" = "ALL PRIVILEGES";
      }
    ];
  };
}
