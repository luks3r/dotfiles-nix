{
  description = "Lukser's Darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    mac-app-util = {
      url = "github:hraban/mac-app-util";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    bash-env-json = {
      url = "github:tesujimath/bash-env-json/main";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    bash-env-nushell = {
      url = "github:tesujimath/bash-env-nushell/main";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.bash-env-json.follows = "bash-env-json";
    };

  };

  outputs = inputs@{ self, nix-darwin, nixpkgs, home-manager, mac-app-util, bash-env-json, bash-env-nushell }:
    let
      system = "aarch64-darwin";
      apple-silicon = { pkgs, config, ... }: {
        nixpkgs.hostPlatform = system;
      };

      overlays = [
        (final: prev: {
          ghostty-darwin = prev.stdenv.mkDerivation rec {
            pname = "Ghostty";
            version = "tip";

            buildInputs = [ prev.unzip prev.wget ];
            sourceRoot = ".";

            phases = [ "unpackPhase" "installPhase" ];

            unpackPhase = ''
              runHook preUnpack
              wget -O ghostty.zip "https://github.com/ghostty-org/ghostty/releases/download/${version}/ghostty-macos-universal.zip" --verbose --no-check-certificate
              unzip ghostty.zip -d "$sourceRoot"
              runHook postUnpack
            '';

            installPhase = ''
              runHook preInstall
              mkdir -p $out/Applications
              cp -r Ghostty.app "$out/Applications/"
              mkdir -p $out/bin
              ln -s ../Applications/Ghostty.app/Contents/MacOS/ghostty "$out/bin/ghostty"
              runHook postInstall
            '';

            meta = with prev.lib; {
              description = "Ghostty is a cross-platform, GPU-accelerated terminal emulator";
              homepage = "https://ghostty.org/";
              license = licenses.mit;
              platforms = platforms.darwin;
              mainProgram = "ghostty";
            };
          };
        })
      ];

      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
        config.allowBroken = true;
        overlays = overlays;
      };
      flakePkgs = {
        bash-env-json = bash-env-json.packages.${system}.default;
        bash-env-nushell = bash-env-nushell.packages.${system}.default;
      };
    in
    {
      darwinConfigurations.LukserPro = nix-darwin.lib.darwinSystem {
        modules = [
          apple-silicon
          ./configuration.nix
          home-manager.darwinModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.lukser.imports = [
              ./common
            ];
            home-manager.sharedModules = [
              mac-app-util.homeManagerModules.default
            ];
            home-manager.extraSpecialArgs = { inherit inputs self pkgs flakePkgs; };
          }
          ./homebrew.nix
          mac-app-util.darwinModules.default
        ];
        specialArgs = { inherit inputs self pkgs flakePkgs; };
      };

      formatter.aarch64-darwin = nixpkgs.legacyPackages.${system}.nixpkgs-fmt;
      darwinPackages = self.darwinConfigurations.default.pkgs;
    };
}
