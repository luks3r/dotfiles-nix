{ pkgs, lib, config, ... }:
{
  home.packages = with pkgs; [
    wezterm
  ];
  xdg.configFile = {
    "wezterm/wezterm.lua".source = ../config/wezterm/wezterm.lua;
  };

  programs.bat.syntaxes = {
    gleam = {
      src = pkgs.fetchFromGitHub {
        owner = "molnarmark";
        repo = "sublime-gleam";
        rev = "2e761cdb1a87539d827987f997a20a35efd68aa9";
        hash = "sha256-Zj2DKTcO1t9g18qsNKtpHKElbRSc9nBRE2QBzRn9+qs=";
      };
      file = "syntax/gleam.sublime-syntax";
    };
  };

  programs = {
    ghostty = {
      enable = true;
      package = pkgs.ghostty-darwin;

      installVimSyntax = false;
      installBatSyntax = false;

      settings = {
        window-theme = "dark";
        theme = "catppuccin-mocha";
        macos-option-as-alt = true;

        font-size = 11;
        font-family = "JetBrainsMono Nerd Font";

        # Disables ligatures
        font-feature = [ "-liga" "-dlig" "-calt" ];

        command = "${lib.getExe config.programs.nushell.package} --login --interactive --config ${config.xdg.configHome}/nushell/config.nu --env-config ${config.xdg.configHome}/nushell/env.nu";
      };
    };
  };
}
