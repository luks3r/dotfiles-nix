{ ... }:
{
  programs = {
    zsh = {
      enable = true;
      antidote = {
        enable = true;
        plugins = [
          "zsh-users/zsh-autosuggestions"
          "zsh-users/zsh-syntax-highlighting"
          "zsh-users/zsh-completions"

          "Aloxaf/fzf-tab"
        ];
      };

      history = {
        append = true;
        share = true;

        save = 10000;
        size = 10000;

        expireDuplicatesFirst = true;
        ignoreAllDups = true;
        ignoreDups = true;
        ignoreSpace = true;
      };

      initExtra = ''
        # Emacs bindings
        bindkey -e

        bindkey '^p' history-search-backward
        bindkey '^n' history-search-forward

        zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'

        zstyle ':completion:*' list-colors ''\${(s.:.)LS_COLORS}
        zstyle ':completion:*' menu no
        zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza --color=always --icons=always -x $realpath'
        zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'eza --color=always --icons=always -x $realpath'
      '';
    };

    ghostty.enableZshIntegration = true;
    fzf.enableZshIntegration = true;
    skim.enableZshIntegration = true;
    direnv.enableZshIntegration = true;
    eza.enableZshIntegration = true;
    starship.enableZshIntegration = true;
    thefuck.enableZshIntegration = true;
    carapace.enableZshIntegration = true;
    zoxide.enableZshIntegration = true;
    yazi.enableZshIntegration = true;
  };
}
