{ config, lib, ... }:

let
  cfg = config.my.wireguardRestrict;
in
{
  options.my.wireguardRestrict.enable = lib.mkEnableOption "restrict all nginx vhosts to wireguard";

  config = lib.mkIf cfg.enable {
    services.nginx.commonHttpConfig = ''
      geo $ts_client {
        default 0;
        10.0.25.93/24 1;
        127.0.0.1/32 1;
      }
      map "$ts_client:$request_uri" $ts_deny {
        default 1;
        "~^1:" 0;
        "~^0:/\.well-known/acme-challenge/" 0;
      }
    '';
  };

  options.services.nginx.virtualHosts = lib.mkOption {
    type = lib.types.attrsOf (
      lib.types.submodule (
        { config, ... }:
        {
          options.wireguardRestrict = lib.mkOption {
            type = lib.types.bool;
            default = cfg.enable;
          };
          config = lib.mkIf config.wireguardRestrict {
            extraConfig = lib.mkBefore ''
              if ($ts_deny) { return 403; }
            '';
          };
        }
      )
    );
  };
}
