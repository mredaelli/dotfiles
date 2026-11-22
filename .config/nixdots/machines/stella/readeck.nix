{ config, pkgs, ... }:
let
  port = 9096;
in
{
  services.readeck = {
    enable = true;
    settings = {
      server = {
        port = port;
      };
    };
    environmentFile = "/var/secrets/readeck";
  };
  services.nginx.virtualHosts."readeck.typish.io" = {
    enableACME = true;
    forceSSL = true;
    locations."/" = {
      extraConfig = ''
        proxy_pass http://localhost:${toString port};
        client_max_body_size 100M;
        proxy_pass_request_headers on;
        proxy_set_header        Host $host;
        proxy_set_header        X-Real-IP $remote_addr;
        proxy_set_header        X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header        X-Forwarded-Proto $scheme;
      '';
    };
  };
}
