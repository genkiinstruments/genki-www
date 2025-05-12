{
  flake,
  inputs,
  pkgs,
  perSystem,
  ...
}:
let
  treefmtEval = inputs.treefmt-nix.lib.evalModule pkgs {
    projectRootFile = "flake.nix";

    programs.prettier.enable = true;
    programs.prettier.includes = [ "*.svelte" ];

    programs.prettier.settings =
      let
        # [TODO]: Make this simpler one day (May 12, 2025 19:05, oli)
        prettierrc = (builtins.fromJSON (builtins.readFile "${flake}/.prettierrc"));
      in
      {
        plugins = [
          "${perSystem.self.node_modules}/node_modules/prettier-plugin-tailwindcss/dist/index.mjs"
          "${perSystem.self.node_modules}/node_modules/prettier-plugin-svelte/plugin.js"
        ];
        inherit (prettierrc)
          useTabs
          singleQuote
          trailingComma
          printWidth
          bracketSameLine
          ;
      };

    programs.shellcheck.enable = true;
    programs.shfmt.enable = true;
    settings.formatter.shfmt.includes = [
      "*.envrc"
      "*.envrc.private-template"
      "*.bashrc"
      "*.bash_profile"
      "*.bashrc.load"
    ];

    programs.deadnix.enable = true;
    programs.nixfmt.enable = true;

    settings.formatter.deadnix.pipeline = "nix";
    settings.formatter.deadnix.priority = 1;
    settings.formatter.nixfmt.pipeline = "nix";
    settings.formatter.nixfmt.priority = 2;

    settings.formatter.shellcheck.pipeline = "shell";
    settings.formatter.shellcheck.priority = 1;
    settings.formatter.shfmt.pipeline = "shell";
    settings.formatter.shfmt.priority = 2;

    programs.stylua.enable = true;
    programs.taplo.enable = true;
    programs.fish_indent.enable = true;
    programs.clang-format.enable = true;
    programs.deno.enable = true;

    settings.global.excludes = [
      "*.png"
      "*.jpg"
      "*.zip"
      "*.touchosc"
      "*.pdf"
      "*.svg"
      "*.ico"
      "*.webp"
      "*.gif"
    ];
  };
  formatter = treefmtEval.config.build.wrapper;
  check = treefmtEval.config.build.check flake;
in
formatter
// {
  passthru = formatter.passthru // {
    tests = {
      inherit check;
    };
  };
}
