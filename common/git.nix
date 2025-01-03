{ ... }:
let
  lukser = {
    name = "Sergei Lukaushkin";
    email = "luks3r@gmail.com";
  };
in
{
  programs = {
    gh.enable = true;
    eza.git = true;
    git = {
      enable = true;
      userName = lukser.name;
      userEmail = lukser.email;

      ignores = [
        "*~"
        ".DS_Store"
        "*.swp"
      ];

      aliases = {
        st = "status";
        co = "checkout";
        cb = "checkout -b";
        rb = "rebase";
        rba = "rebase --abort";
        rbc = "rebase --continue";
        rbi = "rebase -i";
        pf = "push --force-with-lease";
      };

      delta.enable = true;
      lfs.enable = true;
    };
  };
}
