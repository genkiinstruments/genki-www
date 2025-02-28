{ pkgs, ... }:
let
  name = "process-compose";
  processComposeConfig = pkgs.writeTextFile {
    name = "process-compose.yaml";
    text = # yaml
      ''
        processes:
          pnpm-dev:
            command: __VITE_ADDITIONAL_SERVER_ALLOWED_HOSTS=.tail01dbd.ts.net pnpm dev
            readiness_probe:
              http_get:
                host: localhost
                port: 5173
                path: /
          
          tailscale-funnel:
            command: tailscale funnel localhost:5173
      '';
  };
  catppuccinRepo = pkgs.fetchFromGitHub {
    owner = "catppuccin";
    repo = "process-compose";
    rev = "b0c48aa07244a8ed6a7d339a9b9265a3b561464d";
    sha256 = "sha256-uqJR9OPrlbFVnWvI3vR8iZZyPSD3heI3Eky4aFdT0Qo=";
  };
  themeDir = pkgs.runCommand "process-compose-theme" { } ''
    mkdir -p $out/process-compose
    cp ${catppuccinRepo}/themes/catppuccin-mocha.yaml $out/process-compose/theme.yaml
  '';
  runScript = pkgs.writeShellScriptBin name ''
    ${pkgs.process-compose}/bin/process-compose --config ${processComposeConfig} --theme "Custom Style"
  '';
in
pkgs.symlinkJoin {
  inherit name;
  paths = [
    runScript
    pkgs.pnpm
    pkgs.nodejs
    pkgs.tailscale
  ];
  buildInputs = [ pkgs.makeWrapper ];
  postBuild = ''
    wrapProgram $out/bin/${name} \
      --prefix PATH : ${
        pkgs.lib.makeBinPath [
          pkgs.pnpm
          pkgs.nodejs
          pkgs.tailscale
        ]
      } \
      --set XDG_CONFIG_HOME ${themeDir}
  '';
}
