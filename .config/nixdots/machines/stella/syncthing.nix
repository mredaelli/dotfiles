{ config, pkgs, ... }:
let
  dir = "/data/syncthing/data";
  password = builtins.readFile /var/secrets/syncthing.pw;
in
{
  services.syncthing = {
    enable = true;
    dataDir = dir;
    user = "nextcloud";
    configDir = "/data/syncthing/config";
    overrideDevices = true;
    overrideFolders = true;
    settings = {
      devices = {
        "lightsong" = { id = "CUY27IF-2TJRXUG-T2O4VQA-LI33JLO-AH4IVF3-X6NANGF-RMSET4V-AR23RQI"; };
        "boox" = { id = "PRY2SZN-IAZG7I7-3EHZXOU-63OYFCE-5WCLAFY-XL4EQLZ-JRO76US-JNPROQU"; };
      };
      folders = {
        "kb" = {
          path = "${dir}/nextcloud/kb";
          devices = [ "lightsong" "boox" ];
        };
        "boox" = {
          path = "${dir}/nextcloud/boox";
          devices = [ "boox" ];
        };
        "zotero" = {
          path = "${dir}/nextcloud/zotero";
          devices = [ "boox" ];
        };
      };
      gui = {
        user = "typish";
        password = password;
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
