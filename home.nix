{ config, pkgs, ... }:

{
  home = {
    username = "janders";
    homeDirectory = "/home/janders";

    stateVersion = "23.11";

    packages = with pkgs; [
      cmake
      deadnix
      gcc
      luajitPackages.luarocks
      nodejs_18
      rnix-lsp
      rustup
      unzip
    ];

    file = {
    };

    sessionPath = [
      "$HOME/.local/bin"
    ];

    sessionVariables = {
      TERM = "xterm-256color";
      FZF_DEFAULT_OPTS="--color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8  --color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc  --color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8";
    };

    shellAliases = {
      l = "ls -hal";
      cat = "bat";
      hm = "home-manager switch";
    };
  };

  programs = {
    bash = {
      enable = true;
      enableCompletion = true;
    };
    bat = {
      enable = true;
      config = {
        pager = "less -FR";
        theme = "Catppuccin-mocha";
      };
    };
    dircolors = {
      enable = true;
      enableBashIntegration = true;
      enableZshIntegration = true;
      settings ={};
    };
    direnv = {
      enable = true;
      enableBashIntegration = true;
      enableZshIntegration = true;
      config ={};
      nix-direnv = {
        enable = true;
      };
    };
    fzf = {
      enable = true;
      enableBashIntegration = true;
      enableZshIntegration = true;
      colors = {};
      tmux = {
        enableShellIntegration = true;
      };
    };
    git = {
      enable = true;
      aliases = {
        add = "add -p";
        l = "log --pretty=oneline -n 20 --graph --abbrev-commit";
        s = "status -sb";
        d = "difftool";
        tags = "tag -l";
        branches = "branch -a";
        remotes = "remote -v";
        lg = "log --color --decorate --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an (%G?)>%Creset' --abbrev-commit";
        undo = "reset HEAD~1 --mixed";
        wip = "!git add -A && git commit -m 'WIP'";
        rewrite = "!f() { git rebase -i HEAD~$1; }; f";
        wa = "!f() { git worktree add --track -b $1 $1 $2; cd $1; }; f";
      };
      extraConfig = {
        apply = {
          whitespace = "fix";
        };
        core = {
          whitespace = "space-before-tab,-indent-with-non-tab,trailing-space";
          editor = "vim";
        };
        color = {
          ui = "auto";
        };
        diff = {
          renames = "copies";
        };
        help = {
          autocorrect = "1";
        };
        merge = {
          log = true;
          conflictstyle = "diff3";
        };
        push = {
          default = "simple";
        };
        # commit = {
        #   gpgsign = true;
        # };
        pull = {
          rebase = true;
        };
        rerere = {
          enabled = true;
        };
        init = {
          defaultBranch = "main";
        };
      };
      hooks = {};
      ignores = [
        "*~"
        "*.swp"
        ".direnv/"
        ".envrc"
      ];
      userEmail = "jim_anders@intuit.com";
      userName = "janders";
    };
    gpg = {
      enable = true;
    };
    home-manager = {
      enable = true;
    };
    jq = {
      enable = true;
    };
    neovim = {
      enable = true;
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;
      vimdiffAlias = true;
    };
    ripgrep = {
      enable = true;
    };
    ssh = {
      enable = true;
      addKeysToAgent = "yes";
    };
    starship = 
    let
      flavour = "mocha";
    in
    {
      enable = true;
      enableBashIntegration = true;
      enableZshIntegration = true;
      settings = {
        format = "$all";
        palette = "catppuccin_${flavour}";
      } // builtins.fromTOML (builtins.readFile
      (pkgs.fetchFromGitHub
      {
        owner = "catppuccin";
        repo = "starship";
        rev = "5629d23";
        sha256 = "sha256-nsRuxQFKbQkyEI4TXgvAjcroVdG+heKX5Pauq/4Ota0=";
      } + /palettes/${flavour}.toml));
    };
    tmux = {
      enable = true;
      baseIndex = 1;
      clock24 = true;
      extraConfig = ''
      set-option -ga terminal-overrides ",xterm-256color:Tc"
      bind-key -r f run-shell "tmux neww tmux-sessionizer"
      set -g @catppuccin_flavour 'mocha'
      '';
      keyMode = "vi";
      plugins = with pkgs; [
        tmuxPlugins.catppuccin
      ];
      prefix = "C-s";
      shell = "${pkgs.zsh}/bin/zsh";
      terminal = "xterm-256color";
    };
    zsh = {
      enable = true;
      enableAutosuggestions = true;
      enableCompletion = true;
      cdpath = [
        "~/src/thoreinstein"
        "~/src/oiad"
      ];
      initExtra = ''
        source ~/.zsh_plugins/catppuccin_mocha-zsh-syntax-highlighting.zsh
      '';
      syntaxHighlighting = {
        enable = true;
      };
    };
  };
}
