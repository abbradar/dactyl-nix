{ stdenv, fetchgit, firefox, which, zip }:

stdenv.mkDerivation rec {
  name = "pentadactyl";

  src = fetchgit {
    url = "https://github.com/5digits/dactyl";
    rev = "4356313a0902efbb34013357235419d9cbffeded";
    sha256 = "6655e0dfee34add0208c3519b27e12fdc746c0b5493ec4e94403e64c51cb3460";
  };

  nativeBuildInputs = [ which zip ];

  buildInputs = [ firefox ];

  postUnpack = ''
    sourceRoot="$sourceRoot/pentadactyl"
  '';

  postPatch = ''
    sed -i 's/maxVersion="[^"]*/maxVersion="44/' install.rdf
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
    homepage = https://code.google.com/p/dactyl/;
    license = licenses.mit;
    platforms = firefox.meta.platforms;
    maintainers = with maintainers; [ abbradar ];
  };
}
