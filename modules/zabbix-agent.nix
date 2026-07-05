{ pkgs, ... }:
{
  services.zabbixAgent = {
    enable = true;
    package = pkgs.zabbix74.agent2;
    openFirewall = true;
    server = "0.0.0.0/0";
  };
}
