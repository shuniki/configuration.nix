# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, inputs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      inputs.home-manager.nixosModules.default
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  # Fixes a kernel bug where the touchpad isn't recognized fully
  boot.kernelParams = [ "psmouse.synaptics_intertouch=0" ];

  networking.hostName = "shuniki"; # Define your hostname.
 # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;
  # Set cores and jobs
  nix.settings.max-jobs = 4;
  nix.settings.cores = 4;
  # Enable bluetooth
  hardware.bluetooth.enable = true;
  # Set your time zone.
  time.timeZone = "Europe/Bucharest";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "ro_RO.UTF-8";
    LC_IDENTIFICATION = "ro_RO.UTF-8";
    LC_MEASUREMENT = "ro_RO.UTF-8";
    LC_MONETARY = "ro_RO.UTF-8";
    LC_NAME = "ro_RO.UTF-8";
    LC_NUMERIC = "ro_RO.UTF-8";
    LC_PAPER = "ro_RO.UTF-8";
    LC_TELEPHONE = "ro_RO.UTF-8";
    LC_TIME = "ro_RO.UTF-8";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the KDE Plasma Desktop Environment.
  services.displayManager.sddm.enable = true;
  services.xserver.desktopManager.plasma5.enable = true;

  # Default environment.
  environment.sessionVariables = {
   EDITOR = "nvim";
   BROWSER = "brave";
   TERMINAL = "kitty";
   SHELL = "bash";
};

  # Enable hyprland
   programs.hyprland = {
   enable = true;
   xwayland.enable = true;
  };
   environment.sessionVariables = {
  # Hint electron apps to use wayland
   NIXOS_OZONE_WL = "1";
  };
 hardware = {
   opengl.enable = true;
   nvidia.modesetting.enable = true;
  };

  # Configure keymap in X11
  services.xserver = {
   xkb.layout = "us";
    xkb.variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
   services.libinput.enable = true;
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.shuniki = {
    isNormalUser = true;
    description = "shuniki";
    extraGroups = [ "networkmanager" "wheel" ];
    hashedPassword = "$y$j9T$7rY51athJ8Kk01AXzfdD70$s5211tr8g0I0m/5k7G7FQ6U1ZHEdP5gjkYns5N1gx33";
    packages = with pkgs; [
      kate
      thunderbird
      firefox
      brave
      vim
      neovim
    ];
  };

  home-manager = {
   # also pass inputs to home-manager modules
   extraSpecialArgs = { inherit inputs; };
   users = {
   	"shuniki" = import ./home.nix;
  };
};

  # Install firefox.
  programs.firefox.enable = true;
  # Install java.
  programs.java.enable = true;
  # Install steam.
  programs.steam.enable = true;
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  # Allow xdg portal
  xdg.portal.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim
    vlc
    wget
    wayland
    brave
    discord
    vesktop
    neofetch
    hyfetch
    ani-cli
   #animdl
    pcsx2
    git
    SDL
    waybar
    dunst
    libnotify
    kitty
    swww
    rofi-wayland
    neovim
    gitkraken
    protonup-qt
    lunar-client
    lutris
    wine
    shutter
    pywal
    glava
    cavalier
    protontricks
    python3
    wallust
    cowsay
    neo-cowsay
    toybox
    pcsxr
    protonup-ng
    bleachbit
    obs-studio
    nix-init
    appimage-run
    steam-run
    minigalaxy
    libsForQt5.dolphin
    libsForQt5.ark
    libsForQt5.kate
    tor
    neo-cowsay
    cowsay
    kittysay
    pokemonsay
    man
    lolcat
    aewan
    jp2a
    fortune
    fortune-kind
    pv
    cmatrix
    cbonsai
    grapejuice
    shipwright
    nerdfonts
    pipes
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
   programs.mtr.enable = true;
   programs.gnupg.agent = {
     enable = true;
     enableSSHSupport = true;
   };

  # List services that you want to enable:

  # Use swap
 swapDevices = [{
   	device = "/swapfile";
	size = 16 * 1024; # 16 gb
   }];
  # Use flakes
   nix.settings.experimental-features = [ "nix-command" "flakes" ];
  # Enable the OpenSSH daemon.
   services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?

}
