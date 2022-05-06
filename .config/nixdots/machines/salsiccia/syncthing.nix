{ config, pkgs, ... }:
{
  services.syncthing = {
    enable = true;
    openDefaultPorts = true;
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
