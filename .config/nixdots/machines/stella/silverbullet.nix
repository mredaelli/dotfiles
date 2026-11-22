{ config, pkgs, ... }:
let
  port = 9099;
in
{
  services.silverbullet = {
    enable = true;
    listenPort = port;
    envFile = "/var/secrets/silverbullet";
    spaceDir = "/data/silverbullet/data";
  };
  services.nginx.virtualHosts."md.typish.io" = {
    enableACME = true;
    forceSSL = true;
    locations."/" = {
      extraConfig = ''
        proxy_pass http://localhost:${toString port};
        proxy_pass_request_headers on;
        proxy_set_header        Host $host;
        proxy_set_header        X-Real-IP $remote_addr;
        proxy_set_header        X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header        X-Forwarded-Proto $scheme;
      '';
    };
  };
  systemd.services.silverbullet.serviceConfig = {
    Environment = "DENO_DIR=/var/cache/silverbullet/deno";
    CacheDirectory = "silverbullet";
  };
}
