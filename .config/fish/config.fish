if not functions -q fisher
    set -q XDG_CONFIG_HOME; or set XDG_CONFIG_HOME ~/.config
    curl https://git.io/fisher --create-dirs -sLo $XDG_CONFIG_HOME/fish/functions/fisher.fish
    fish -c fisher
end

alias cpvpn='pushd ~/.ssh; and sudo openvpn --config CP-FW-01-UDP4-1194-massimo.redaelli-config.ovpn; or  popd'

alias du="du -h"
alias df="df -h"
alias free="free -m"

if type -q htop
  alias top="htop"
end

if type -q bat
  alias cat="bat";
  alias catt="bat --style plain";
end

if type -q exa
  alias ls='exa'
  alias ll='exa -l --git'
end

alias less='less -r'

if type -q nvim
  alias nano='nvim'
  alias vim='nvim'
  alias vi='nvim'
  alias vmux="abduco -e '^g' -A nvim-session nvim"
end

alias psg='ps au | grep'

alias cdgr='cd (git rev-parse --show-toplevel)'
abbr kdiff 'kitty +kitten diff'

## git
abbr gs 'git status -s'
abbr gd 'git diff'
abbr gl 'git log --graph --topo-order --abbrev-commit --date=short --decorate --all --boundary'
abbr ga 'git add'

abbr glb "git for-each-ref --sort='-authordate' --format='%(authordate)%09%(objectname:short)%09%(refname)' refs/heads | sed -e 's-refs/heads/--'"

abbr gc 'git commit --verbose'
abbr gca 'git commit --amend --verbose'
abbr gcA 'git commit -a --verbose'
abbr gcAa 'git commit -a --verbose --amend'
abbr gcm 'git commit --verbose -m'
abbr gcAm 'git commit --verbose -am'

abbr gf 'git fetch -p'

abbr gob 'git checkout -b'
abbr go 'git checkout'
abbr gom 'git checkout master'

abbr gP 'git push'
abbr gPP 'git push --force'
abbr gp 'git pull'

abbr grm 'git rebase master'
abbr grh 'git rebase -i HEAD~'
abbr gra 'git rebase --abort'
abbr grc 'git rebase --continue'


set PATH ~/bin $PATH

function mutt
    bash --login -c 'cd ~/downloads; neomutt' $argv;
end

function mkcd
    mkdir -pv $argv;
    cd $argv;
end

set fish_cursor_default block
set fish_cursor_insert line
set fish_cursor_visual block
fish_vi_key_bindings

if type -q starship
  starship init fish | source
else
  # bobthefish
  set -g theme_title_display_process yes
  # set -g theme_color_scheme terminal-dark
  set -g theme_color_scheme solarized-dark
  # set -g theme_color_scheme dark
end

if type -q any-nix-shell
   any-nix-shell fish | source
end

set -x TASKRC ~/.config/taskwarrior/taskrc

if status --is-interactive
  echo
  echo  Remember using tig thefuck howdoi buku fzf newsboat broot
  echo
  task next
  echo
end
