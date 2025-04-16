{ pkgs, perSystem }:
pkgs.mkShell {
  # Add build dependencies
  packages =
    with pkgs;
    with perSystem.self;
    [
      pnpm
      figma-sync
      png-to-webp
    ];

  # Add environment variables
  env = { };

  # Load custom bash code
  shellHook = ''

  '';
}
