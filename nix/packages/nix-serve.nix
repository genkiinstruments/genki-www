{
  pkgs,
  perSystem,
  pname,
  ...
}:
pkgs.writeShellApplication {
  name = pname;
  text = ''${pkgs.tailscale}/bin/tailscale funnel ${perSystem.self.default}'';
}
