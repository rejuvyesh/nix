{ pkgs }: {

packageOverrides = self: with pkgs; rec {

local = let
  cabalStatic = haskellPackages.cabal.override {
    enableStaticLibraries  	= true;
    enableSharedLibraries  	= false;
    enableSharedExecutables	= false;
  };
  gitAnnex = stdenv.lib.overrideDerivation (haskellPackages.gitAnnex.override {
    cabal = cabalStatic;
  }) (old: {
       # we pull in lsof and git anyway
       propagatedUserEnvPkgs = [];
  });
  hs  = haskellPackages;

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
      (unzip.override { enableNLS = true; })

      # stuff
      mc
      parallel
      reptyr
      rlwrap
      tmux
      tzdata
      zsh
      unison

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

      colordiff
      convmv
      dos2unix
      hs.pandoc
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

unison.enableX11 = false;

# plugins
firefox.enableAdobeFlash       = true;
firefox.enableGoogleTalkPlugin = true;

}
