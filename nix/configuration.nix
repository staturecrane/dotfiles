# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      /etc/nixos/hardware-configuration.nix
    ];

  # Use the gummiboot efi boot loader.
  boot.loader.gummiboot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  hardware = {
    pulseaudio.enable = true;
  };

  networking.hostName = "shodan"; # Define your hostname.
  networking.networkmanager.enable = true;

  environment.shells = [
    "${pkgs.zsh}/bin/zsh"
  ];

  time.timeZone = "US/Central";

  services.ntp = {
    enable = true;
  };

  security.sudo.wheelNeedsPassword = false;

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [
    chromium flashplayer
    compton
    conky
    curl
    docker
    dunst
    git
    i3lock
    i3status
    nodejs-5_x
    parcellite
    pavucontrol
    python
    rofi
    stow
    termite
    tmux
    unclutter
    vim
    wget
    xorg.xbacklight
    xclip
    zsh
  ] ++ (with python27Packages; [
    docker_compose
    udiskie
  ]);

  # NOTE: changes to this take effect on login.
  environment.sessionVariables = {
    EDITOR = "vim";
    NIXPKGS_ALLOW_UNFREE = "1";
  };

  nixpkgs.config = {
    allowUnfree = true;

    chromium = {
      enableGoogleTalkPlugin = true;
      enablePepperFlash = true;
      enablePepperPDF = true;
    };

    vim = {
      lua = true;
      python = true;
    };

    programs = {
      bash.enableCompletion = true;
      zsh.enable = true;
    };
  };

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable the X11 windowing system.

  services.xserver = {
    enable = true;
    layout = "us";

    displayManager = {
      slim = {
        enable = true;
        autoLogin = false;
        defaultUser = "josh";
        theme = pkgs.fetchurl {
          url = "mirror://sourceforge/slim.berlios/slim-rear-window.tar.gz";
          sha256 = "0b123706ccb67e94f626c183530ec5732b209bab155bc661d6a3f5cd5ee39511";
        };
      };
      sessionCommands = ''
        ${pkgs.xlibs.xset}/bin/xset r rate 200 60  # set the keyboard repeat rate
        ${pkgs.feh}/bin/feh --no-fehbg --bg-scale ~/dotfiles/backgrounds/wall.jpg &
        ${pkgs.compton}/bin/compton -b &
        ${pkgs.networkmanagerapplet}/bin/nm-applet &
        ${pkgs.dunst}/bin/dunst &
        ${pkgs.parcellite}/bin/parcellite -n &
        ${pkgs.unclutter}/bin/unclutter -root -visible &
        ${pkgs.python27Packages.udiskie}/bin/udiskie &
      '';
    };

    desktopManager = {
      default = "none";
    };

    windowManager = {
      default = "i3";
      i3.enable = true;
    };
  };

  services.dbus.enable = true;
  services.upower.enable = true;

  # Define a user account. Don't forget to set a password with `passwd`.
  users.extraUsers.josh = {
    name = "josh";
    extraGroups = [ "wheel" "networkmanager" "docker"];
    uid = 1000;
    createHome = true;
    home = "/home/josh";
    shell = "${pkgs.zsh}/bin/zsh";
  };

  # Enable Docker
  virtualisation.docker.enable = true;
  virtualisation.docker.storageDriver = "btrfs";

  # Fonts
  fonts = {
    enableCoreFonts = true;
    enableFontDir = true;
    fonts = with pkgs; [
      hack-font
      terminus_font
    ];
  };

  # The NixOS release to be compatible with for stateful data such as databases.
  system.stateVersion = "16.03";

}