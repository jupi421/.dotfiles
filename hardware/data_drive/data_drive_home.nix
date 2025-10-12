{ config, pkgs, ... }:

{
  fileSystems."/home/jay/Data" = {
    device = "/dev/sdb1";
    fsType = "ext4";
    options = [ "defaults" "noatime" ];
  };
}
