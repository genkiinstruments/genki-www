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
  runScript = pkgs.writeShellScriptBin name ''
    ${pkgs.process-compose}/bin/process-compose --config ${processComposeConfig}
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
      }
  '';
}
