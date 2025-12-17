{ config, pkgs, ... }:

{

  nix.settings.experimental-features = [ "nix-command" "flakes"];

  # Enable networking
  networking.networkmanager.enable = true;

  virtualisation.vswitch.enable = true;
  virtualisation.vswitch.resetOnStart = true;
  #virtualisation.vswitch.package = pkgs.openvswitch-dpdk;
  
  networking.vswitches = {
    sw0 = {
      interfaces = {
#        "sw0.4" = {
#          vlan = 4;
#          type = "internal";
#        };
      };
    };
  };

  # Set your time zone.
  time.timeZone = "Europe/Bratislava";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "sk_SK.UTF-8";
    LC_IDENTIFICATION = "sk_SK.UTF-8";
    LC_MEASUREMENT = "sk_SK.UTF-8";
    LC_MONETARY = "sk_SK.UTF-8";
    LC_NAME = "sk_SK.UTF-8";
    LC_NUMERIC = "sk_SK.UTF-8";
    LC_PAPER = "sk_SK.UTF-8";
    LC_TELEPHONE = "sk_SK.UTF-8";
    LC_TIME = "sk_SK.UTF-8";
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.kontsek = {
    isNormalUser = true;
    description = "kontsek";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
  };

  security.sudo.wheelNeedsPassword = false;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    mc
    yazi
    vim
    neovim
    tmux
    nload
    nmon
    tcpdump
    curl
    htop
    btop
    wget
    mosh
    inxi
    screenfetch
    fastfetch
    tree
    smartmontools
    lm_sensors
    ncdu
    gdu
    bat
    eza
    nfs-utils
    lldpd
    xfsprogs
    lazydocker
    restic
    glances
    pigz
    dysk
    nh
    duf
    git
    python313
    python313Packages.python-dotenv
    _7zz    
  ];

  services.lldpd.enable = true;
  services.lldpd.extraArgs = [ "-c" ];

  programs.mosh.enable = true;

  # Fix vscode remote ssh
  programs.nix-ld.enable = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [ 
    2049 # NFSv4
  ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Fix Docker macvlan connectivity issues
  networking.firewall.checkReversePath = "loose";

  # allow NFS mount by script
  boot.supportedFilesystems = [ "nfs" "ntfs" ];
  services.rpcbind.enable = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?

}
