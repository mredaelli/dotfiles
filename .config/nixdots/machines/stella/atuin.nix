{
  config,
  pkgs,
  ...
}:
{
  services.atuin = {
    enable = true;
    openFirewall = true;
    host = "0.0.0.0";
  };
  services.nginx.virtualHosts."atuin.typish.io" = {
    enableACME = true;
    forceSSL = true;
    locations."/" = {
      extraConfig = ''
        proxy_pass http://localhost:8888;
        proxy_pass_request_headers on;
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
