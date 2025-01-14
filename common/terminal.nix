{ pkgs, lib, config, ... }:
{
  programs = {
    ghostty = {
      enable = true;
      package = pkgs.ghostty-darwin;

      installVimSyntax = false;
      installBatSyntax = false;

      settings = {
        window-theme = "dark";
        theme = "catppuccin-mocha";
        macos-option-as-alt = false;

        font-size = 11;
        font-family = "JetBrainsMono Nerd Font";

        # Disables ligatures
        font-feature = [ "-liga" "-dlig" "-calt" ];

        command = "${lib.getExe config.programs.nushell.package} --login --interactive --config ${config.xdg.configHome}/nushell/config.nu --env-config ${config.xdg.configHome}/nushell/env.nu";
      };
    };
  };
}
