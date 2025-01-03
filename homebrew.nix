{ ... }:
{
  # Enable Homebrew
  # https://daiderd.com/nix-darwin/manual/index.html#opt-homebrew.enable
  homebrew.enable = true;

  homebrew.global = {
    # Automatically use the Brewfile that this module generates in the Nix store
    # https://daiderd.com/nix-darwin/manual/index.html#opt-homebrew.global.brewfile
    brewfile = true;
    autoUpdate = true;
  };

  homebrew.taps = [
    "homebrew/bundle"
    "homebrew/services"
    "oven-sh/bun"
    "satrik/togglemute"
  ];

  homebrew.brews = [
    "oven-sh/bun/bun"
    "podman"
    "podman-compose"
    "zig"
    "zls"
  ];

  homebrew.casks = [
    "arc"
    "spotify"
    "iina"
    "podman-desktop"
    "obsidian"
    "discord"
    "zen-browser"
    "brave-browser"
    "1password"
    "authy"
    "chatgpt"
    "raycast"
    "zotero"
    "syncplay"
    "setapp"
    "onlyoffice"
    "obs"
    "satrik/togglemute/togglemute"
    "karabiner-elements"
  ];

  homebrew.masApps = {
    "Xcode" = 497799835;
    "Telegram" = 747648890;
    "Shareful" = 1522267256;
    "Runcat" = 1429033973;
  };

  homebrew.onActivation = {
    autoUpdate = true;
    upgrade = true;
    cleanup = "zap";
    extraFlags = [ "--force" ];
  };
}
