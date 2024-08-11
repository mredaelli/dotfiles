{ config, pkgs, ... }:
{
  security.acme = {
    defaults.email = "massimo.acme@typish.io";
    acceptTerms = true;
  };
  services.nginx = {
    enable = true;

    recommendedProxySettings = true;
    recommendedGzipSettings = true;
    recommendedOptimisation = true;
    recommendedTlsSettings = true;

    appendHttpConfig = ''
      limit_conn_zone $binary_remote_addr zone=addr_poetry:10m;
    '';
  };

}
