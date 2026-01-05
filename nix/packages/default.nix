{
  pname,
  flake,
  pkgs,
}:
let
  src = flake;
  version = (builtins.fromJSON (builtins.readFile "${src}/package.json")).version;
in
pkgs.stdenv.mkDerivation {
  inherit pname src version;

  nativeBuildInputs = with pkgs; [
    nodejs
    pnpm
    pnpmConfigHook
  ];

  pnpmDeps = pkgs.fetchPnpmDeps {
    inherit pname version src;
    hash = "sha256-hVnVOn2sQFS6v6ldG+b5uVD2BdWR3ZVgBbjLVpqsex0=";
    fetcherVersion = 3;
  };

  buildPhase = "pnpm check && pnpm build"; # check fixes: Cannot find base config file "./.svelte-kit/tsconfig.json" [tsconfig.json]

  installPhase = "cp -r build $out/";
}
