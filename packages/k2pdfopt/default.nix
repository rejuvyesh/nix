{ stdenv, requireFile }:

stdenv.mkDerivation {
        name = "k2pdfopt";
        src = requireFile {
          name = "k2pdfopt";
          url = "http://www.willus.com/k2pdfopt/download/";
          sha256 = "0da7pgv1q2jfwqswwk91iq0jlh1rkdgg5bi9qdjwirbhc2rf72ia"; # For 64bit linux
        };
        phases = ["installPhase"];
        installPhase = ''
          mkdir -p $out/bin
          cp $src $out/bin/k2pdfopt
          chmod +x $out/bin/k2pdfopt
        '';
}
