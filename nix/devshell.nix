{ pkgs, perSystem }:
pkgs.mkShell {
  # Add build dependencies
  packages = with pkgs; [
    pnpm
    perSystem.self.figma-sync
  ];

  # Add environment variables
  env = { };

  # Load custom bash code
  shellHook = ''

  '';
}
