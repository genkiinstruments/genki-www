{ pkgs, pname }:
pkgs.writeShellApplication {
  name = pname;

  runtimeInputs = [ pkgs.libwebp ];

  text = builtins.readFile ./png-to-webp.sh;
}
