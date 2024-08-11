{ config, pkgs, ... }:
let port = 9090;
in {
  services.shiori = {
    enable = true;
    address = "127.0.0.1";
    port = port;
  };
  services.nginx.virtualHosts."mark.typish.io" = {
    enableACME = true;
    forceSSL = true;
    locations."/" = {
      extraConfig = ''
        proxy_pass http://127.0.0.1:${toString port};
        proxy_set_header        Host $host;
        proxy_set_header        X-Real-IP $remote_addr;
        proxy_set_header        X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header        X-Forwarded-Proto $scheme;
        proxy_read_timeout      600s;
        proxy_send_timeout      600s;
      '';
          };
  };
}
