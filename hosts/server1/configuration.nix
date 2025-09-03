# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ../../modules/boot-efi.nix
      ../../modules/global.nix
      ../../modules/docker.nix
      ../../modules/libvirt.nix
      ../../modules/incus.nix
      ../../modules/zabbix-agent.nix
    ];

  networking.hostName = "server1"; # Define your hostname.
  
  networking.interfaces.enp5s0.ipv4.addresses = [ {
    address = "10.0.2.254";
    prefixLength = 24;
  } ];
  networking.defaultGateway = "10.0.2.1";
  networking.nameservers = [ "8.8.8.8" ];

  networking.interfaces."sw0.4".ipv4.addresses = [ {
    address = "10.0.4.254";
    prefixLength = 24;
  } ];

  networking.vswitches.sw0.extraOvsctlCmds = "
                         add-bond sw0 bond0 enp1s0f0np0 enp1s0f1np1 lacp=active
                         add-br sw0.2 sw0 2
                         add-br sw0.3 sw0 3
                         add-br sw0.4 sw0 4
                       ";

    services.cron = {
      enable = true;
      systemCronJobs = [
        "* * * * *      root    /data/docker/moodle/moodle-cron.sh"
      ];
    };
}
