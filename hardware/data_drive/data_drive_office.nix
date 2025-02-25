{ config, pkgs, ... }:

{
  fileSystems."/home/jay/Data" = {
    device = "/dev/sda1";
    fsType = "ext4";
    options = [ "defaults" "noatime" ];
  };
}
