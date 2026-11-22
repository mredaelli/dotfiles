{ config, pkgs, ... }: {

  services.nginx = {
    virtualHosts."sheepish.typish.dev" = {
    enableACME = true;
    forceSSL = true;
    locations."/" = {
      proxyPass = "http://127.0.0.1:9998";
    };
  };
};
}
