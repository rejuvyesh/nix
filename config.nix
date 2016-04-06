{ pkgs }: {

packageOverrides = self: with pkgs; rec {

local = let

  hs  = haskellPackages;

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
      nix-prefetch-scripts
      nix-repl
      nox
    ];
  });


  myhs = hs.ghcWithPackages (
    pkgs: with pkgs; [
      cabal2nix
      cabal-install
      ghc-mod
      hlint
      hledger
      hledger-web
      hserv
      gitit
      pandoc
      # xmonad
      # xmonad-contrib
      # xmonad-extras
      # xmonad
      # xdg-basedir
      # xmobar
      # libmpd
    ]
  );

  haskell = hiPrio (pkgs.buildEnv {
    name = "rejuvnix-haskell";
    paths = [
      myhs
    ];
  });
};

};

# general options
allowUnfree = true;
zathura.useMupdf = true;

# plugins
firefox.enableAdobeFlash       = true;
firefox.enableGoogleTalkPlugin = true;

}
