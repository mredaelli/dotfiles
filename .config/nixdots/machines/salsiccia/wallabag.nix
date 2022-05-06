{ config, pkgs, ... }:
let
  domain = "walla.typish.io";
  secret = builtins.readFile /var/secrets/wallabag_secret;
  dbPassword = builtins.readFile /var/secrets/wallabag_db_password;
in
{
  services.wallabag = {
    enable = true;
    hostName = domain;
    conf = ''
      parameters:
          database_driver: pdo_pgsql
          database_host: 127.0.0.1
          database_port: null
          database_name: wallabag
          database_user: wallabag
          database_password: ${dbPassword}
          database_path: null
          database_table_prefix: wallabag_
          database_socket: null
          database_charset: utf8

          domain_name: https://${domain}
          server_name: "Typish Walla"

          mailer_transport:  smtp
          mailer_user:       ~
          mailer_password:   ~
          mailer_host:       127.0.0.1
          mailer_port:       false
          mailer_encryption: ~
          mailer_auth_mode:  ~

          locale: en
          secret: ${secret}

          twofactor_auth: false
          twofactor_sender: no-reply@wallabag.org

          fosuser_registration: false
          fosuser_confirmation: false

          fos_oauth_server_access_token_lifetime: 3600
          fos_oauth_server_refresh_token_lifetime: 1209600

          from_email: no-reply@wallabag.org

          rss_limit: 50

          rabbitmq_host: null
          rabbitmq_port: 5672
          rabbitmq_user: guest
          rabbitmq_password: guest
          rabbitmq_prefetch_count: 10

          # Redis processing
          redis_scheme: tcp
          redis_host: null
          redis_port: 6379
          redis_path: null
          redis_password: null

          ## sentry logging
          sentry_dsn: ~
    '';
  };
}
