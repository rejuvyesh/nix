{ mkDerivation, async, base, blaze-builder, enumerator
, linux-inotify, pandoc, snap-core, snap-server, stdenv, stm, text
, transformers
}:
mkDerivation {
  pname = "pandoc-live";
  version = "1.0.0";
  src = /home/rejuvyesh/src/haskell/pandoc-live;
  isLibrary = false;
  isExecutable = true;
  buildDepends = [
    async base blaze-builder enumerator linux-inotify pandoc snap-core
    snap-server stm text transformers
  ];
  homepage = "http://github.com/ocharles/pandoc-live";
  description = "Automatically refresh Pandoc documents in your web browser";
  license = stdenv.lib.licenses.bsd3;
}
