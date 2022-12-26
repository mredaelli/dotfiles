{ config, pkgs, ... }:
let dir = "/data/syncthing/data";
in {
  services.syncthing = {
    enable = true;
      dataDir = dir;
      configDir = "/data/syncthing/config";
      overrideDevices = true;
      overrideFolders = true;
      devices = {
        "lightsong" = { id = "4K4M525-DTMUO2S-6BLRAWU-DW4PIRM-X5LUXJP-2R7G5IU-N7LHIM5-JPI5WAD"; };
        "gimli" = { id = "K23RLID-SJQSJPD-ARXYHSY-2XFIKKV-KXUK4M3-VVM2PIY-GFTGBFK-2PNWYAX"; };
                "tablet" = { id = "XL44HFN-ZVOEC4Y-333RP5A-ETT7LIH-K7U7TCP-JXDN67G-BOGSYUE-LWBZUQT"; };
      };
      folders = {
        "Sync" = {
          path = "${dir}/sync";
          devices = [ "lightsong" "gimli" ];
        };
        "kb" = {
          path = "${dir}/kb";
          devices = [ "lightsong" "gimli" "tablet"];
        };
        "zotero" = {
          path = "${dir}/zotero-tablet";
          devices = [ "lightsong" "gimli" "tablet"];
        };
      };

  };
  services.nginx.virtualHosts."sync.typish.io" = {
    enableACME = true;
    forceSSL = true;
    locations."/" = {
      extraConfig = ''
        proxy_pass https://localhost:8384;
        proxy_set_header        Host localhost;
        proxy_set_header        X-Real-IP $remote_addr;
        proxy_set_header        X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header        X-Forwarded-Proto $scheme;
        proxy_read_timeout      600s;
        proxy_send_timeout      600s;
      '';
    };
  };
}
