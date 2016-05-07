{ stdenv, fetchFromGitHub, fetchpatch, firefox, which, zip }:

stdenv.mkDerivation rec {
  name = "pentadactyl";

  src = fetchFromGitHub {
    owner = "5digits";
    repo = "dactyl";
    rev = "1a4290d92ac3e2dfd3b84168081ba721c02556b0";
    sha256 = "1yravd4ypzs822q8vg5rqf75fz28ihvxcrlg63shpvyjaq1b0zbw";
  };

  patches = [
    (fetchpatch {
      url = "https://github.com/mikar/dactyl/commit/2f32e55e0f0fcf861371055f237dbe928c7835d7.patch";
      sha256 = "1w9qhm4sn5f5waajqmwjd8d58a9vy6bz2zjb82wclmjdci77z12m";
    })
  ];

  nativeBuildInputs = [ which zip ];

  buildInputs = [ firefox ];

  postPatch = ''
    cd pentadactyl
    sed -i 's/maxVersion="[^"]*/maxVersion="50/' install.rdf
  '';

  makeFlags = [ "xpi" ];

  installPhase = ''
    mkdir -p $out/lib/firefox/extensions
    mv ../downloads/* $out/lib/firefox/extensions

    mkdir -p $out/nix-support
    echo "file binary-dist \"$(echo $out/lib/firefox/extensions/*.xpi)\"" >> $out/nix-support/hydra-build-products
  '';

  meta = with stdenv.lib; {
    description = "A Vim-like, five-fingered interface for Firefox";
    homepage = http://5digits.org/pentadactyl/;
    license = licenses.mit;
    platforms = firefox.meta.platforms;
    maintainers = with maintainers; [ abbradar ];
  };
}
