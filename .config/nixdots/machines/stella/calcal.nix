{ config, pkgs, ... }: {

  services.nginx = {
    virtualHosts."calcal.typish.io" ={
    enableACME = true;
    forceSSL = true;
    locations."/" = {
      proxyPass = "http://127.0.0.1:9999";
    };
  };
};
}
