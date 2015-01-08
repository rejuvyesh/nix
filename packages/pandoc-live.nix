# This file was auto-generated by cabal2nix. Please do NOT edit manually!

{ cabal, async, blazeBuilder, enumerator, linuxInotify, pandoc
, snapCore, snapServer, stm, text, transformers
}:

cabal.mkDerivation (self: {
  pname = "pandoc-live";
  version = "1.0.0";
  src = /home/rejuvyesh/src/haskell/pandoc-live;
  isLibrary = false;
  isExecutable = true;
  buildDepends = [
    async blazeBuilder enumerator linuxInotify pandoc snapCore
    snapServer stm text transformers
  ];
  meta = {
    homepage = "http://github.com/ocharles/pandoc-live";
    description = "Automatically refresh Pandoc documents in your web browser";
    license = self.stdenv.lib.licenses.bsd3;
    platforms = self.ghc.meta.platforms;
  };
})