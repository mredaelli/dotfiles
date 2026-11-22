{
  config,
  pkgs,
  lib,
  ...
}:
let
  port = 9097;
in
{
  services.gokapi = {
    enable = true;
    environment = {
      GOKAPI_PORT = port;
    };
    mutableSettings = true;
  };
  services.nginx.virtualHosts."gokapi.typish.io" = {
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
}
