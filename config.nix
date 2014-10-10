{ pkgs }: {

packageOverrides = self: with pkgs; rec {

local = let
  hs  = haskellPackages;
  gst = gst_all_1;

  # over-rides
  cabalStatic = hs.cabal.override {
    enableStaticLibraries  	= true;
    enableSharedLibraries  	= false;
    enableSharedExecutables	= false;
  };

  gitAnnex = stdenv.lib.overrideDerivation (hs.gitAnnex.override {
    cabal = cabalStatic;
  }) (old: {
       # we pull in lsof and git anyway
       propagatedUserEnvPkgs = [];
  });
  zathura = stdenv.lib.overrideDerivation pkgs.zathura (default: {
    src = pkgs.fetchurl {
    url = "https://github.com/fmap/zathura-vi/releases/download/vi-0.2.8/zathura-0.2.7.tar.gz";
    sha256 = "8cb6553f67c4e53e23f11a2d83c19bc41fcf0c15933d70e801c598c17480dbd2";
    };
  });
  hs  = haskellPackages;

  unzip = pkgs.unzip.override { enableNLS = true; };

  git = pkgs.gitAndTools.git.override { svnSupport = true; };

in recurseIntoAttrs rec {
   # standard environment
  base = pkgs.buildEnv {
    name = "rejuvnix";
    paths = [
      # nix-related
      gem-nix
      nix-prefetch-scripts
      nix-repl
      nox

      # archives
      bchunk
      gnutar
      libarchive
      pigz
      p7zip
      rpm
      unrar
      unzip

      # stuff
      mc
      parallel
      reptyr
      rlwrap
      tmux
      tzdata
      zsh

      # system
      extundelete
      hddtemp
      inotifyTools
      lsof
      netcat
      nmap
      utillinuxCurses
      vnstat
    ];
  };

  haskell = hiPrio (pkgs.buildEnv {
    name = "rejuvnix-haskell";
    paths = [
      hs.cabalInstall
      hs.cabal2nix
      hs.ghc
      hs.ghcMod
    ];
  });

  go = pkgs.buildEnv {
    name = "rejuvnix-go";
    paths = [
      pkgs.go
    ];
  };

  java = pkgs.buildEnv {
    name = "rejuvnix-java";
    paths = [
      icedtea7_jdk
    ];
  };

  js = pkgs.buildEnv {
    name = "rejuvnix-js";
    paths = [
      nodejs
    ];
  };

  c = pkgs.buildEnv {
    name = "rejuvnix-c";
    paths = [
      gcc
      gdb
      valgrind
    ];
  };

  office = pkgs.buildEnv {
    name = "rejuvnix-office";
    paths = [
      libreoffice
      unoconv
    ];
  };

  wm = pkgs.buildEnv {
    name = "rejuvnix-wm";
    paths = [
      hs.xmonad
      hs.xmonadContrib
      hs.xmonadExtras
      hs.xmobar
      compton
      dmenu
      wmname
      hs.arbtt

      gtk_engines
      gtk-engine-murrine
    ];
  };

  code = pkgs.buildEnv {
    name = "rejuvnix-code";
    paths = [
      cloc
      gperftools
      silver-searcher
      strace

      cvs
      bazaar
      darcs
      git
      gitAnnex
      mercurial
      subversion
    ];
  };

  txt = pkgs.buildEnv {
    name = "rejuvnix-txt";
    paths = [
      calibre
      zathura

      colordiff
      convmv
      dos2unix
      hs.pandoc
      ghostscript

      htmlTidy
      meld
      pdftk
      wdiff

      emacs
    ];
  };

  web = pkgs.buildEnv {
    name = "rejuvnix-web";
    paths = [
      aria2
      dropbox-cli
      firefoxWrapper
      mu
      offlineimap
      quvi
      rtmpdump
      torbrowser
      weechat
      youtubeDL
    ];
  };

  video = pkgs.buildEnv {
    name = "rejuvnix-video";
    paths = [
      guvcview
      mpv
      gst.gst-plugins-base
      gst.gst-plugins-good
      swftools
    ];
  };

  audio = pkgs.buildEnv {
    name = "rejuvnix-audio";
    paths = [
      audacity
      alsaLib
      alsaPlugins
      alsaUtils
      mpc
      ncmpcpp
    ];
  };
  image = pkgs.buildEnv {
    name = "rejuvnix-image";
    paths = [
      gimp
      gimpPlugins.lqrPlugin
      imagemagick
      mcomix
      scrot
    ];
  };

  win = pkgs.buildEnv {
    name = "rejuvnix-win";
    paths = [
      wine
      winetricks
    ];
  };
};

};  

# general options
allowUnfree = true;

zathura.useMupdf = true;

# plugins
firefox.enableAdobeFlash       = true;
firefox.enableGoogleTalkPlugin = true;

chromium.enablePepperFlash = true;
chromium.enablePepperPDF   = true;
}
