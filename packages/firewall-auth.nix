{ mkDerivation, base, bytestring, connection, haskeline, hslogger
, http-conduit, http-types, mtl, regex-compat, stdenv, unix
}:
mkDerivation {
  pname = "hwall-auth-iitk";
  version = "0.1.0.1";
  src = /home/rejuvyesh/src/haskell/hwall-auth-iitk;
  isLibrary = false;
  isExecutable = true;
  buildDepends = [
    base bytestring connection haskeline hslogger http-conduit
    http-types mtl regex-compat unix
  ];
  description = "Initial version of firewall Authentication for IITK network";
  license = stdenv.lib.licenses.bsd3;
}
