{ pkgs ? import <nixpkgs> {} }:

let
	cython = pkgs.python3Packages.cython.overrideAttrs (oldAttrs: rec {
		pname = "cython";
		version = "0.29.28";
		src = pkgs.fetchPypi {
			inherit pname version;
			sha256 = "df52a7a1b1ab52e999b9e62d87e48eb9c8d43d3d4d89f1a27b1f4dcbd6a6c908";
		};
	});
in
pkgs.mkShell {
  buildInputs = with pkgs; [
    cmake
	cython
    python3
    python3Packages.setuptools
    fftw
    openmpi
	python311Packages.pyopengl
	gsl
	freeglut
    hdf5
    boost
	python311Packages.numpy
	python311Packages.scipy
    # Add other necessary dependencies here
  ];

  shellHook = ''
    echo "Entering EspressoMD development environment"
  '';
}
