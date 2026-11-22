{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.my.wireguardRestrict;
  headscalePrefix = "100.96.0.0/16";
  base_domain = "ts.typish.io";
  baseDomain = "typish.io";
  stellaTSIP = "100.96.0.1";
  typishDevIp = "100.96.0.4";
  fqdn = name: "${name}.${baseDomain}";
in
{
  options.my.wireguardRestrict.enable = lib.mkEnableOption "restrict all nginx vhosts to wireguard";

  config = {

    networking.nameservers = [ "9.9.9.9" ];

    services.blocky = {
      enable = true;
      settings = {
        ports.dns = 53;

        upstreams.groups.default = [
          "https://dns.quad9.net/dns-query" # Quad9 DoH
        ];

        bootstrapDns = {
          upstream = "9.9.9.9";
          ips = [
            "9.9.9.9"
            "149.112.112.112"
          ];
        };

        blocking = {
          denylists = {
            base = [
              "https://codeberg.org/hagezi/mirror2/raw/branch/main/dns-blocklists/domains/pro.txt"
            ];
            threat = [
              "https://codeberg.org/hagezi/mirror2/raw/branch/main/dns-blocklists/domains/tif.txt"
            ];
          };
          clientGroupsBlock = {
            default = [
              "base"
              "threat"
            ];
            # stella's own queries — Pro only, no TIF
            "100.96.0.1" = [ "base" ];
            "127.0.0.1" = [ "base" ];
            "::1" = [ "base" ];
          };
          loading.refreshPeriod = "12h";
        };

        caching = {
          minTime = "5m";
          maxTime = "30m";
          prefetching = true;
        };
      };
    };

    services.headscale = {
      enable = true;

      address = "127.0.0.1";
      port = 8080;

      settings = {
        server_url = "https://headscale.typish.io";

        prefixes = {
          v4 = headscalePrefix;
          v6 = "fd7a:115c:a1e0::/48";
        };

        derp = {
          urls = [ "https://controlplane.tailscale.com/derpmap/default" ];
          auto_update_enabled = true;
          update_frequency = "24h";
          server.enabled = false;
        };
        policy.path = "/data/headscale.json";

        dns = {
          magic_dns = true;
          base_domain = base_domain;

          nameservers.global = [
            # "9.9.9.9"
            # "100.96.0.2" # box
            "100.96.0.1" # stella
          ];

          search_domains = [ "int.typish.io" ];
          extra_records =
            let
              io =
                map
                  (name: {
                    name = fqdn name;
                    type = "A";
                    value = stellaTSIP;
                  })
                  [
                    "atuin"
                    "gokapi"
                    "md"
                    "mini"
                    "next"
                    "pass"
                    "personal"
                    "readeck"
                    "sea"
                    "sheepish"
                    "sync"
                    "elemao"
                  ];
            in
            io
            ++ [
              {
                name = "maotrix.typish.dev";
                type = "A";
                value = stellaTSIP;
              }
              {
                name = "elemao.typish.dev";
                type = "A";
                value = typishDevIp;
              }
            ];
        };

        log.level = "info";

        database = {
          type = "sqlite";
          sqlite.path = "/var/lib/headscale/db.sqlite";
        };

        disable_check_updates = true;
      };
    };

    services.nginx.virtualHosts."headscale.typish.io" = {
      forceSSL = true;
      enableACME = true;
      locations."/" = {
        proxyPass = "http://127.0.0.1:8080";
        proxyWebsockets = true;
        recommendedProxySettings = false;
        extraConfig = ''
          proxy_set_header Upgrade $http_upgrade;
          proxy_set_header Connection $connection_upgrade;
          proxy_set_header Host $host;
          proxy_set_header X-Real-IP $remote_addr;
          proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
          proxy_set_header X-Forwarded-Proto $scheme;
          proxy_buffering off;
          proxy_read_timeout 1d;  # long-lived streaming control connection
        '';
      };
    };
    networking.firewall.allowedUDPPorts = [
      3478 # headscale DERP
      41641 # tailscale
    ];

    networking.firewall.interfaces.tailscale0.allowedUDPPorts = [ 53 ];
    networking.firewall.interfaces.tailscale0.allowedTCPPorts = [ 53 ];

    environment.systemPackages = [ pkgs.headscale ];

    services.tailscale.enable = true;

    services.nginx.commonHttpConfig = lib.mkIf cfg.enable ''
      geo $ts_client {
        default 0;
        ${headscalePrefix} 1;
        127.0.0.1/32 1;
      }
      map "$ts_client:$host:$request_uri" $ts_deny {
        default 1;
        "~^1:" 0;
        "~^0:[^:]+:/\.well-known/acme-challenge/" 0;
        "~^0:pass\.typish\.io:/send/" 0;
        "~^0:next\.typish\.io:/s/" 0;
        "~^0:next\.typish\.io:/index\.php/apps/gpoddersync/" 0;
        "~^0:next\.typish\.io:/remote\.php/dav/public-calendars/.*\?export" 0;
        "~^0:headscale\.typish\.io:" 0;
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
