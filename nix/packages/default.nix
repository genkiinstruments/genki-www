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
    esbuild
  ];

  pnpmDeps = pkgs.pnpm.fetchDeps {
    inherit pname version src;
    hash = "sha256-/3hpokiIZI6RqtEGpp3NgZEoYsDxU8a9LljTkINmK64=";
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
