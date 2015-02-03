{ stdenv, fetchhg, firefox, which, zip }:

stdenv.mkDerivation rec {
  name = "pentadactyl";

  src = fetchhg {
    url = https://code.google.com/p/dactyl/;
    rev = "56521ded229c";
    sha256 = "1ncz0vhvc801phgv8whckyw1q4i8afanji79xm3m2pfyzjvj52q1";
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
  '';

  meta = with stdenv.lib; {
    description = "A Vim-like, five-fingered interface for Firefox";
    homepage = https://code.google.com/p/dactyl/;
    license = licenses.mit;
    platforms = firefox.meta.platforms;
    maintainers = with maintainers; [ abbradar ];
  };
}
