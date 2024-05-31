self: super: {
  cython = super.callPackage (super.fetchFromGitHub {
    owner = "cython";
    repo = "cython";
    rev = "3.0.8";
    sha256 = "0w0w8yk9scip7kjmlabmxy3xfq7yxsd4qx53hwhx83wi4qgzdn8n";
  }) {};
}
