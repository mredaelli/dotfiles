{ config, pkgs, ... }:
{
  services.postgresql = {
    enable = true;
    ensureDatabases = [ "wallabag" ];
    ensureUsers = [
      {
        name = "wallabag";
        ensurePermissions."DATABASE wallabag" = "ALL PRIVILEGES";
      }
    ];
  };
}
