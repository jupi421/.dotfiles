{ lib, buildGoModule, fetchFromGitHub, ... }:

buildGoModule rec {
	pname = "sesh";
	version = "0.15.0";

	src = fetchFromGitHub {
		owner = "joshmedeski";
		repo = "sesh";
		rev = "v${version}";
		sha256 = "0000000000000000000000000000000000000000000000000000";
	};

	modSha256 = "0000000000000000000000000000000000000000000000000000";

	vendorSha256 = null;

	buildFlagsArray = [ "-ldflags=-s -w" ];

	meta = with lib; {
		description = "smart tmux session manager";
	};
}
