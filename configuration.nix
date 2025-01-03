{ self, pkgs, config, ... }:
{
  nixpkgs.config.allowUnfree = true;
  nixpkgs.overlays = [
    (final: prev: {
      ghostty = prev.ghostty.overrideAttrs (old: {
        src = prev.fetchFromGithub {
          owner = "ghostty-org";
          repo = "ghostty";
          rev = "3f7c3afaf947280bd2852626ff4599c02d9fb07e";
          sha256 = "";
        };
      });
    })
  ];

  # Set system-wide fonts.
  fonts.packages = with pkgs; [
    recursive
    nerd-fonts.jetbrains-mono
    nerd-fonts.recursive-mono
  ];

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;
  # nix.package = pkgs.nix;

  # Necessary for using flakes on this system.
  nix.settings = {
    experimental-features = "nix-command flakes";
    trusted-users = [
      "root"
      "lukser"
      "@wheel"
    ];
  };

  # Create /etc/zshrc that loads the nix-darwin environment.
  programs.zsh.enable = true; # default shell on catalina
  # programs.fish.enable = true;

  # Set Git commit hash for darwin-version.
  system.configurationRevision = self.rev or self.dirtyRev or null;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 5;

  # The platform the configuration will be used on.
  nixpkgs.hostPlatform = "aarch64-darwin";

  users.users = {
    lukser = {
      name = "lukser";
      home = "/Users/lukser";
    };
  };

  security.pam = {
    enableSudoTouchIdAuth = true;
  };

  system.defaults = {
    dock = {
      autohide = true;
      mru-spaces = false;
      show-recents = false;
    };
    finder = {
      AppleShowAllExtensions = true;
    };
  };
}
