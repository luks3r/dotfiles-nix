{ pkgs, specialArgs, config, ... }:
let
  inherit (specialArgs) flakePkgs;
  hmSessionVarsNu = pkgs.writeTextFile {
    name = "hm-session-vars.nu";
    text = ''
      let vars = ${pkgs.lib.getExe config.programs.nushell.package} -c '
        use ${flakePkgs.bash-env-nushell}/bash-env.nu *
        bash-env ${config.home.sessionVariablesPackage}/etc/profile.d/hm-session-vars.sh | to nuon
      '
      if ('__HM_SESS_VARS_SOURCED' not-in $env) {
        $vars | from nuon | load-env
        $env.__HM_SESS_VARS_SOURCED = true
      }
    '';
  };
in
{
  home.packages = with pkgs; [
    flakePkgs.bash-env-nushell
  ];

  programs = {
    nushell = {
      enable = true;

      extraConfig = ''
        $env.config = {
          show_banner: false
          edit_mode: 'vi'

          history: {
            max_size: 10000
            sync_on_enter: true
            file_format: "plaintext"
          }

          completions: {
            case_sensitive: false # set to true to enable case-sensitive completions
            quick: true  # set this to false to prevent auto-selecting completions when only one remains
            partial: true  # set this to false to prevent partial filling of the prompt
            algorithm: "fuzzy"  # prefix or fuzzy
          }
        }
      '';

      extraEnv = ''
        source ${hmSessionVarsNu}
      '';

      environmentVariables = builtins.mapAttrs (name: value: "${builtins.toString value}") config.home.sessionVariables;

      plugins = [
        pkgs.nushellPlugins.units
        pkgs.nushellPlugins.highlight
        pkgs.nushellPlugins.skim
      ];
    };

    direnv.enableNushellIntegration = true;
    starship.enableNushellIntegration = true;
    thefuck.enableNushellIntegration = true;
    carapace.enableNushellIntegration = true;
    zoxide.enableNushellIntegration = true;
    yazi.enableNushellIntegration = true;
  };
}
