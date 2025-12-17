# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ../../modules/global.nix
      ../../modules/docker.nix
      ../../modules/libvirt.nix
      ../../modules/incus.nix
      ../../modules/zabbix-agent.nix
    ];

  # Bootloader.
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sdc";
  boot.loader.grub.useOSProber = true;

  networking.hostName = "nas"; # Define your hostname.
  
  networking.vswitches.sw0.extraOvsctlCmds = "
                         add-bond sw0 bond0 ens1f0 ens1f1 lacp=active
                         add-br sw0.2 sw0 2
                         add-br sw0.3 sw0 3
                         add-br sw0.4 sw0 4
                       ";  

  networking.interfaces.eno1.ipv4.addresses = [ {
    address = "10.0.2.252";
    prefixLength = 24;
  } ];
  networking.defaultGateway = "10.0.2.1";
  networking.nameservers = [ "8.8.8.8" ];

  networking.interfaces."sw0.4".ipv4.addresses = [ {
    address = "10.0.4.252";
    prefixLength = 24;
  } ];

  services.nfs.server.enable = true;
  services.nfs.server.exports = ''
    /data/docker    *(ro,insecure,sync,no_root_squash)
  '';

}
