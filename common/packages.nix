{ pkgs, inputs, ... }:
{
  # The set of packages to appear in the user environment
  # https://nix-community.github.io/home-manager/options.html#opt-home.packages
  home.packages = with pkgs; [
    # Nix-related packages
    nixd
    nix-prefetch-git # to get git signatures for fetchFromGit
    nixpkgs-fmt

    devenv

    # Programming Languages & Build Tools
    rustup

    nodePackages.nodejs
    bun

    python3
    uv
    ruff

    lua

    clang-tools
    cmake
    gcc
    gnumake
    ninja
    pkg-config

    # Utilities
    mkcert
    mkalias
    stow
    tokei
    typst
  ];
}
