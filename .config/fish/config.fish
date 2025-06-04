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
  alias less="bat";
  alias catt="bat --style plain";
  alias bathelp='bat --plain --language=help'
  function help
    $argv --help 2>&1 | bathelp
  end
  abbr -a --position anywhere -- --help '--help | bat -plhelp'
  abbr -a --position anywhere -- -h '-h | bat -plhelp'
  export MANPAGER="sh -c 'sed -u -e \"s/\\x1B\[[0-9;]*m//g; s/.\\x08//g\" | bat -p -lman'"
  alias rgb="batgrep"
end

if type -q eza
  alias ls='eza --icons'
  alias ll='eza -l --git --icons --color-scale'
end

if type -q nvim
  alias nano='nvim'
  alias vim='nvim'
  alias vi='nvim'
  alias vmux="abduco -e '^g' -A nvim-session nvim"
end

alias psg='ps au | rg'

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

function mkcd
    mkdir -pv $argv;
    cd $argv;
end

if type -q tig
   abbr tig "tig status"
end

abbr ,i 'nix-shell -p'
function ,x
  nix-shell -p $argv[1] --run "$argv"
end

if type -q fd
  export FZF_DEFAULT_COMMAND='fd --type f'
  export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
end

if status --is-interactive
  set fish_cursor_default block
  set fish_cursor_insert line
  set fish_cursor_visual block
  fish_vi_key_bindings
end
set -Ux FZF_DEFAULT_OPTS "\
--color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
--color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
--color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8"

