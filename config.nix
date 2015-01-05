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

  k2pdfopt = pkgs.callPackage ./packages/k2pdfopt {};

  zathura = stdenv.lib.overrideDerivation pkgs.zathuraCollection.zathuraWrapper (_: {
    zathura_core = stdenv.lib.overrideDerivation pkgs.zathuraCollection.zathuraWrapper.zathura_core (_ : {
      src = pkgs.fetchgit {
        url = "https://github.com/fmap/zathura-vi";
        rev = "e86077de8a9950fb72a9935772aa3b6eba70e97e";
        sha256 = "fa2af0b2364cf172bc906afa01ba0a0d36f7c42957ecdb702d3e03faec0673cc";
      };
      buildInputs = [pkgs.python27Packages.sphinx];
    });
  });
  
in recurseIntoAttrs rec {
   # standard environment
  base = hiPrio (pkgs.buildEnv {
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
      unzipNLS

      # stuff
      mc
      parallel
      reptyr
      rlwrap
      tmux
      tzdata
      zsh
      rxvt_unicode

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
  });

  haskell = hiPrio (pkgs.buildEnv {
    name = "rejuvnix-haskell";
    paths = [
      hs.cabalInstall
      hs.cabal2nix
      hs.ghc
      hs.ghcMod
      hs.stylishHaskell
      hs.pandoc
      hs.arbtt
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

  julia = pkgs.buildEnv {
    name = "rejuvnix-julia";
    paths = [
      pkgs.julia
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
      compton
      dmenu
      wmname
      hs.xdgBasedir
      hs.xmonad
      hs.xmonadContrib
      hs.xmonadExtras
      hs.xmobar

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

    ];
  };

  vcs = pkgs.buildEnv {
    name = "rejuvnix-vcs";
    paths = [
      cvs
      bazaar
      darcs
      gitFull
      hs.gitAnnex
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
      ghostscript

      htmlTidy
      meld
      pdftk
      wdiff

      k2pdfopt

      emacs
    ];
  };

  web = pkgs.buildEnv {
    name = "rejuvnix-web";
    paths = [
      aria2
      dropbox
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
