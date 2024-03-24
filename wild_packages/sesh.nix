{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    (buildGoModule rec {
      pname = "sesh";
      version = "0.15.0"; # Replace this with the actual version

      src = fetchFromGitHub {
        owner = "owner"; # Replace with the actual GitHub owner
        repo = pname;
        rev = "v${version}";
        sha256 = "0000000000000000000000000000000000000000000000000000"; # Replace with the actual sha256 of the source
      };

      modSha256 = "0000000000000000000000000000000000000000000000000000";

      # Optional: Add build flags or make post-install adjustments
      #buildFlagsArray = [""];
      #postInstall = "";
    })
  ];
}
