{ pkgs }: {

packageOverrides = self: with pkgs; rec {

# standard environment
rejuvnix = pkgs.buildEnv {
  name = "rejuvnix";
  paths = let
    hs  = haskellPackages;
      in [
      # nix-related
      gem-nix
      nix-prefetch-scripts
      nix-repl
      nox

      # office
      libreoffice
      unoconv

      # wm
      hs.xmonad
      hs.xmonadContrib
      hs.xmonadExtras
      compton

      # vcs
      cvs
      bazaar
      darcs
      git
      gitAnnexStatic
      mercurial
      subversion

      # coding
      cloc
      graphviz
      silver-searcher

      # tools and languages
      rejuvC
      rejuvHaskell
      rejuvJulia
      rejuvJava
      rejuvJS

      # text
      hs.pandoc
      meld
      colordiff
      dos2unix

      # misc
      hs.hakyll
      tmux
      zsh

      # archives
      bchunk
      libarchive
      pigz
      p7zip
      rpm
      unrar

      # games
      cowsay
      wine
      winetricks

      # web
      aria2
      dropbox-cli
      mu
      offlineimap
      quvi
      rtmpdump
      torbrowser
      youtubeDL

      # image
      gimp
      gimpPlugins.lqrPlugin
      imagemagick
      mcomix
      scrot

    ];  
};

cabalStatic = haskellPackages.cabal.override {
  enableStaticLibraries  	= true;
  enableSharedLibraries  	= false;
  enableSharedExecutables	= false;
};

gitAnnexStatic = haskellPackages.gitAnnex.override {
  cabal = cabalStatic;
};

rejuvHaskell = pkgs.buildEnv {
  name = "rejuvHaskell";
  paths = let
  hs = haskellPackages;
  in [
  # coding
  hs.cabalInstall
  hs.cabal2nix
  hs.ghc
  hs.ghcMod

  ];
};

rejuvJulia = pkgs.buildEnv {
  name = "rejuvJulia";
  paths = [
    # juliaGit
  ];
};

rejuvJava = pkgs.buildEnv {
  name = "rejuvJava";
  paths = [
    icedtea7_jdk
    ];
};

rejuvJS = pkgs.buildEnv {
  name = "rejuvJS";
  paths = [
    nodejs
    ];
};

rejuvC = pkgs.buildEnv {
  name = "rejuvC";
  paths = [
    gcc
    gdb
    valgrind
    ];  
};


};

# general options
allowUnfree = true;
allowBroken = true;

# plugins
firefox.enableGoogleTalkPlugin = true;
firefox.enableAdobeFlash = true;

}
