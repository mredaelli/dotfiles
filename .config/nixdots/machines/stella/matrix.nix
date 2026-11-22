{ pkgs, config, ... }:
{
  services.matrix-tuwunel = {
    enable = true;
    settings = {
      global = {
        server_name = "Maotrix";
        allow_federation = false;
        allow_registration = true;
        unix_socket_path = "/run/tuwunel/tuwunel.sock";
        unix_socket_perms = 660;
        registration_token = "30LCBk&XZZkod@";
      };
    };
  };
  users.users.nginx.extraGroups = [ config.services.matrix-tuwunel.group ];

  services.nginx = {
    upstreams.tuwunel.servers.${
      "unix:" + config.services.matrix-tuwunel.settings.global.unix_socket_path
    } =
      { };

    virtualHosts = {
      "maotrix.typish.dev" = {
        enableACME = true;
        forceSSL = true;
        locations."/".proxyPass = "http://tuwunel";
      };

      #   # Federation, port 8448 — same cert, same upstream
      #   "matrix.example.com-federation" = {
      #     serverName = "matrix.example.com";
      #     useACMEHost = "matrix.example.com";
      #     onlySSL = true;
      #     listen = [
      #       {
      #         addr = "0.0.0.0";
      #         port = 8448;
      #         ssl = true;
      #       }
      #       {
      #         addr = "[::]";
      #         port = 8448;
      #         ssl = true;
      #       }
      #     ];
      #     locations."/".proxyPass = "http://tuwunel";
      #   };
    };
  };
}
