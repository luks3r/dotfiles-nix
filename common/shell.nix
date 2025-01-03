{ pkgs, config, ... }:
{
  xdg.enable = true;

  # Environment variables to always set at login.
  # https://nix-community.github.io/home-manager/options.html#opt-home.sessionVariables
  home.sessionVariables = {
    GOPATH = "$HOME/go";
    VISUAL = "code";
    LIBRARY_PATH = ''${pkgs.lib.makeLibraryPath [pkgs.libiconv]}''${LIBRARY_PATH:+:$LIBRARY_PATH}'';
  };

  # Extra directories to add to $PATH
  # https://nix-community.github.io/home-manager/options.html#opt-home.sessionPath
  home.sessionPath = [
    # home-manager per-user profile
    # This is supposed to be set automatically by the home-manager.useUserPackages flag
    # However, it doesn't seem to be working for me
    # Therefore, I'm adding it manually
    # https://nix-community.github.io/home-manager/index.xhtml#sec-flakes-nix-darwin-module
    # FIXME: Remove this once the issue is fixed
    "/etc/profiles/per-user/lukser/bin"
    "/run/current-system/sw/bin"

    # pnpm
    "$HOME/.pnpm-global/bin"
    "$HOME/.local/bin"
    "$HOME/.cargo/bin"
    "$GOPATH/bin"
    "$HOME/.dotnet/tools"
    "$HOME/.bun/bin"

    "/opt/homebrew/opt/libiconv/bin"
  ];

  programs = {
    fzf.enable = true;
    skim.enable = true;

    direnv = {
      enable = true;
      nix-direnv = {
        enable = true;
      };
    };

    eza = {
      enable = true;

      colors = "always";
      icons = "always";
    };

    starship.enable = true;
    thefuck.enable = true;
    carapace.enable = true;
    zoxide.enable = true;
    yazi.enable = true;

    # Non-integratable utilities
    command-not-found.enable = true;
    jq.enable = true;
    fd.enable = true;
    bat.enable = true;
    bottom.enable = true;
    ripgrep.enable = true;
    man.enable = true;
    topgrade.enable = true;
    yt-dlp.enable = true;

    # Editors
    neovim = {
      enable = true;
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;
    };

    # Languages
    go.enable = true;
    # bun.enable = true;
    java.enable = true;
    gradle.enable = true;
  };
}
