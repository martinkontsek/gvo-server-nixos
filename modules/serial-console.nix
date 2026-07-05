{ config, pkgs, ... }:

{
  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # 1. Enable serial console on ttyS0
  systemd.services."serial-getty@ttyS0" = {
    enable = true;
    wantedBy = [ "getty.target" ];
    serviceConfig.Restart = "always";
  };

  # 2. Configure kernel parameters for serial console
  boot.kernelParams = [
    "console=tty0"      # Keep local screen output
    "console=ttyS0,115200n8" # Redirect console to serial port
  ];
}
