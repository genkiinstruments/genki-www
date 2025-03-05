{
  pname,
  flake,
  pkgs,
}:
with pkgs;
let
  # Use the flake source if provided, otherwise this would be replaced with fetchFromGitHub
  src = flake;
  # Get nodejs version from package.json
  version = (builtins.fromJSON (builtins.readFile "${src}/package.json")).version;

in
stdenv.mkDerivation {
  inherit pname src version;

  nativeBuildInputs = [
    nodejs
    pnpm.configHook
    esbuild
  ];

  pnpmDeps = pkgs.pnpm.fetchDeps {
    inherit pname version src;
    hash = "sha256-o6jcIVWfaJRRq/VB+FmMJYWv87xkfM/MRyTWatqErWM=";
  };

  buildPhase = ''
    # fixes: Cannot find base config file "./.svelte-kit/tsconfig.json" [tsconfig.json]
    # See: https://github.com/sveltejs/kit/issues/5390
    pnpm check 

    pnpm build
  '';

  installPhase = ''
    runHook preInstall
    cp -pr --reflink=auto build $out/
    runHook postInstall
  '';
}
