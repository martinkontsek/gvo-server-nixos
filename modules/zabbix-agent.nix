{ pkgs, ... }:
{
  services.zabbixAgent = {
    enable = true;
    package = pkgs.zabbix72.agent2;
    openFirewall = true;
    server = "0.0.0.0/0";
  };
}
