{ config, lib, pkgs, ... }:
let 
  domain = "sea.typish.io"; 
  seafileSocket = "unix:/run/seafile/server.sock";
  seahubSocket = "unix:/run/seahub/gunicorn.sock";
in {
  services.mysql.package = lib.mkForce  pkgs.mariadb;
  services.seafile = {
    enable = true;

    adminEmail = "massimo@typish.io";
    initialAdminPassword = "change this later!";

    ccnetSettings.General.SERVICE_URL = "https://${domain}";
    dataDir = "/data/seafile";

    seafileSettings = {
      fileserver = {
        host = seafileSocket;
        web_token_expire_time = 18000;
      };
      history.keep_days = "30";
    };
    gc = {
      enable = true;
      dates = [ "Sun 03:00:00" ];
    };
  };
  services.nginx.virtualHosts."${domain}" = {
    forceSSL = true;
    enableACME = true;
    locations = {
      "/" = {
        proxyPass = "http://${seahubSocket}";
          # proxy_set_header   Host $host;
        extraConfig = ''
          proxy_set_header   X-Real-IP $remote_addr;
          proxy_set_header   X-Forwarded-For $proxy_add_x_forwarded_for;
          proxy_set_header   X-Forwarded-Host $server_name;
          proxy_read_timeout  1200s;
          client_max_body_size 0;
        '';
      };
      "/seafhttp" = {
        proxyPass = "http://${seafileSocket}";
        extraConfig = ''
          rewrite ^/seafhttp(.*)$ $1 break;
          client_max_body_size 0;
          proxy_set_header   X-Forwarded-For $proxy_add_x_forwarded_for;
          proxy_connect_timeout  36000s;
          proxy_read_timeout  36000s;
          proxy_send_timeout  36000s;
          send_timeout  36000s;
        '';
      };
    };
  };
}
