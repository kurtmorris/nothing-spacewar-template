{ config, lib, pkgs, ... }:

let
  defaultUserName = "kurt";
in
{
    users.users."${defaultUserName}" = {
      isNormalUser = true;
      password = "1234";
      extraGroups = [
        "dialout"
        "feedbackd"
        "networkmanager"
        "video"
        "wheel"
      ];
    };

    mobile.beautification = {
      silentBoot = lib.mkDefault true;
      splash = lib.mkDefault true;
    };

    services.xserver.enable = true;
    services.displayManager.autoLogin.enable = true;
    services.displayManager.autoLogin.user = "${defaultUserName}";
    services.xserver.displayManager.lightdm.enable = true;
    services.xserver.displayManager.lightdm.greeter.enable = false;

    services.xserver.desktopManager.phosh = {
      enable = true;
      user = defaultUserName;
      group = "users";
      # for better compatibility with x11 applications
      phocConfig.xwayland = "immediate";
    };

    programs.calls.enable = true;

    environment.systemPackages = with pkgs; [
      chatty # IM and SMS
      epiphany # Web browser
      gnome-console # Terminal
      megapixels # Camera
    ];

    hardware.sensor.iio.enable = true;
}
