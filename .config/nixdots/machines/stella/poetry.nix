{ config, pkgs, ... }: {

  environment = {
    systemPackages = with pkgs; [ goaccess ];
  };

  services.nginx = {
    virtualHosts."italianpoetry.it" =
      let
        ll = ''~ "/.*\.[0-9a-fA-F]{64}\..*"'';
        headers = ''
          add_header X-Frame-Options "SAMEORIGIN";
          add_header X-XSS-Protection "1; mode=block";

          add_header Content-Security-Policy "default-src 'self'; script-src 'self' https://cloud.umami.is/script.js 'wasm-unsafe-eval'; img-src 'self'; form-action 'none'; base-uri 'self'; frame-src youtube-nocookie.com www.youtube-nocookie.com; connect-src 'self' https://api-gateway.umami.dev/api/send;"; 
          add_header Referrer-Policy "same-origin";
          add_header X-Content-Type-Options nosniff;
          add_header Strict-Transport-Security 'max-age=31536000; includeSubDomains; preload';
        '';
      in
      {
        enableACME = true;
        forceSSL = true;
        root = "/data/italianpoetry";
        kTLS = true;
        extraConfig = ''
          limit_conn addr_poetry 50;

          ##buffer policy
          client_body_buffer_size 1K;
          client_header_buffer_size 1k;
          large_client_header_buffers 2 1k;
          ##end buffer policy

          client_max_body_size 1k;
          client_body_timeout 5s;
          client_header_timeout 5s;
          charset UTF-8;

          ${headers}
          add_header Cache-Control "no-cache, private";

          if ($request_method !~ ^(GET|HEAD)$ ) 
          {
             return 405; 
          }
        '';
        locations.${ll} = {
          extraConfig = ''
            ${headers}
            add_header Cache-Control "public, max-age=31536000";
          '';
        };
      };
    virtualHosts."www.italianpoetry.it" =
      {
        enableACME = true;
        forceSSL = true;
        kTLS = true;
        extraConfig = ''
          return 301 $scheme://italianpoetry.it$request_uri;
        '';
      };
  };
  services.logrotate.settings = {
    header = {
      dateext = true;
      dateformat = "-%Y%m%d";
    };
    nginx.rotate = 4;
  };
}
