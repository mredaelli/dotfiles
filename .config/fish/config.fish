if not functions -q fisher
    set -q XDG_CONFIG_HOME; or set XDG_CONFIG_HOME ~/.config
    curl https://git.io/fisher --create-dirs -sLo $XDG_CONFIG_HOME/fish/functions/fisher.fish
    fish -c fisher
    fisher update
end

alias du="du -h"
alias df="duf"
alias free="free -m"

if type -q htop
  alias top="htop"
end

if type -q viddy
  alias watch="viddy"
end

if type -q bat
  alias cat="bat";
  alias catt="bat --style plain";
end

if type -q exa
  alias ls='exa --icons'
  alias ll='exa -l --git --icons --color-scale'
end

alias less='less -r'

if type -q nvim
  alias nano='nvim'
  alias vim='nvim'
  alias vi='nvim'
  alias vmux="abduco -e '^g' -A nvim-session nvim"
end

if type -q ultralist
  abbr ul "ultralist"
  alias u="ultralist l"
  alias uc="ultralist l group:context"
  alias up="ultralist l group:project"
end

alias psg='ps au | grep'

alias cdgr='cd (git rev-parse --show-toplevel)'
abbr kdiff 'kitty +kitten diff'

## git
abbr gs 'git status -s'
abbr gd 'git diff'
abbr gl 'git log --oneline'
abbr ga 'git add'

abbr glb "git for-each-ref --sort='-authordate' --format='%(authordate)%09%(objectname:short)%09%(refname)' refs/heads | sed -e 's-refs/heads/--'"

abbr gc 'git commit --verbose'
abbr gcf 'git commit --amend --verbose'
abbr gca 'git commit -a --verbose'
abbr gcaf 'git commit -a --verbose --amend'
abbr gcm 'git commit --verbose -m'
abbr gcam 'git commit --verbose -am'

abbr gf 'git fetch -p'
abbr gt 'git trim'

abbr gob 'git checkout -b'
abbr go 'git checkout'
abbr gom 'git checkout master'

abbr gP 'git push'
abbr gPP 'git push --force-with-lease'
abbr gp 'git pull'

abbr grm 'git rebase master'
abbr grom 'git rebase origin/master'
abbr grh 'git rebase -i HEAD~'
abbr gra 'git rebase --abort'
abbr grc 'git rebase --continue'

abbr gmm 'git merge'
abbr gm 'git merge --ff'
abbr gma 'git merge --abort'
abbr gmc 'git merge --continue'

abbr gRo 'git fetch; and git reset --hard @{u}'
abbr gRm 'git fetch; and git reset --hard origin/master'
abbr gro 'git fetch; and git reset --soft @{u}'
abbr grw 'git reword'

abbr gC 'git cherry-pick'
abbr gCa 'git cherry-pick --abort'
abbr gCc 'git cherry-pick --continue'

abbr :e 'vi'
abbr :q 'exit'

set PATH ~/bin $PATH

function mutt
    bash --login -c 'cd ~/downloads; neomutt' $argv;
end

function mkcd
    mkdir -pv $argv;
    cd $argv;
end

if type -q tig
   abbr tig "tig status"
end

if type -q any-nix-shell
   any-nix-shell fish | source
end
abbr ,i 'nix-shell -p'

if type -q fd
  export FZF_DEFAULT_COMMAND='fd --type f'
  export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
end

direnv hook fish | source

if status --is-interactive
  set fish_cursor_default block
  set fish_cursor_insert line
  set fish_cursor_visual block
  fish_vi_key_bindings

  if type -q starship
    starship init fish | source
  else
    set -g theme_title_display_process yes
    set -g theme_color_scheme solarized-dark
  end

  zoxide init fish | source

  echo
  echo  Remember using procs tig thefuck fzf git-absorb
  echo
end
set -Ux FZF_DEFAULT_OPTS "\
--color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
--color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
--color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8"
set -Ux BAT_THEME "Catppuccin-mocha"

