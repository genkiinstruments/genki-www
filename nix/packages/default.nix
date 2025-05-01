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
    pnpm.configHook
  ];

  pnpmDeps = pkgs.pnpm.fetchDeps {
    inherit pname version src;
    hash = "sha256-mHvE4Nv/iEefwy/QU7uKKn4k0kcAicFZhQv0qOACXxI=";
  };

  buildPhase = "pnpm check && pnpm build"; # check fixes: Cannot find base config file "./.svelte-kit/tsconfig.json" [tsconfig.json]

  installPhase = "cp -r build $out/";
}
