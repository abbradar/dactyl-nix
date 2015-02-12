{ stdenv, fetchhg, firefox, which, zip }:

stdenv.mkDerivation rec {
  name = "pentadactyl";

  src = fetchhg {
    url = https://code.google.com/p/dactyl/;
    rev = "59c43695e9ee";
    sha256 = "01n3isw25y952xbl8w71rnp5sq6sv9kv6q8xqkfik9yi05qi99h0";
  };

  nativeBuildInputs = [ which zip ];

  buildInputs = [ firefox ];

  postUnpack = ''
    sourceRoot="$sourceRoot/pentadactyl"
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
