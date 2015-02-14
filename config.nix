{ pkgs }: {

packageOverrides = self: with pkgs; rec {

local = let
  haskellngPackages = pkgs.haskellngPackages.override {
      overrides = self : super : {
        pandoc-live = self.callPackage ./packages/pandoc-live.nix {};
        firewall-auth = self.callPackage ./packages/firewall-auth.nix {};
      };    
  };

  hs  = haskellngPackages;
  py3 = python3Packages;

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
      hs.cabal-install
      hs.cabal2nix
      hs.ghc
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
      # gcc
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

  wm = hiPrio (pkgs.buildEnv {
    name = "rejuvnix-wm";
    paths = [
      compton
      dmenu
      # wmname
      hs.xdg-basedir
      hs.xmonad
      hs.xmonad-contrib
      hs.xmonad-extras
      hs.xmobar
      hs.arbtt
      
      gtk_engines
      gtk-engine-murrine
    ];
  });

  code = pkgs.buildEnv {
    name = "rejuvnix-code";
    paths = [
      cloc
      gperftools
      silver-searcher
      strace
      graphviz

      # db
      sqliteInteractive
      sqliteman
    ];
  };

  vcs = pkgs.buildEnv {
    name = "rejuvnix-vcs";
    paths = [
      cvs
      bazaar
      darcs
      gitFull
      gitAndTools.darcsToGit
      gitAndTools.gitAnnex
      mercurial
      subversion
    ];
  };

  txt = pkgs.buildEnv {
    name = "rejuvnix-txt";
    paths = [
      calibre
      zathura
      pdfgrep
      
      colordiff
      convmv
      dos2unix
      ghostscript

      htmlTidy
      meld
      pdftk
      wdiff

      hs.stylish-haskell
      hs.pandoc
      hs.pandoc-citeproc
      hs.pandoc-live
      hs.ghc-mod
      hs.hindent

      emacs
    ];
  };

  track = lowPrio (pkgs.buildEnv {
    name = "rejuvnix-track";
    paths = [
      hs.hledger
      hs.hledger-web
    
      hs.gitit
    ];
  });
  
  web = pkgs.buildEnv {
    name = "rejuvnix-web";
    paths = [
      aria2
      dropbox-cli
      eiskaltdcpp
      firefoxWrapper
      mu
      offlineimap
      quvi
      rtmpdump
      torbrowser
      weechat
      awscli
      hs.hserv
      hs.firewall-auth
    ];
  };

  video = pkgs.buildEnv {
    name = "rejuvnix-video";
    paths = [
      guvcview
      mpv
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
      mpdcron
      hs.vimus
    ];
  };

  image = pkgs.buildEnv {
    name = "rejuvnix-image";
    paths = [
      gimp
      gimpPlugins.lqrPlugin
      inkscape
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

  python3env = pkgs.python3.buildEnv.override {
    extraLibs = [
      py3.beautifulsoup4
      py3.lxml
      py3.mock
      py3.requests
    ];
  };
  
  science = pkgs.myEnvFun {
    name = "science";
    buildInputs = [
      python3env
      py3.ipython
      py3.ipdb
      py3.matplotlib
      py3.numpy
      py3.pillow
      py3.pandas
      py3.scikitlearn
      py3.scipy
    ];
  };
  
  python3 = lowPrio (pkgs.buildEnv {
    name = "rejuvnix-python3";
    paths = [
      python3env
    ];
  });
  
  www = pkgs.myEnvFun {
    name = "www";
    buildInputs = [
      hs.hakyll 
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
