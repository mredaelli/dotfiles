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
end

alias psg='ps au | grep'


## git
abbr gs 'git status -s'
abbr gd 'git diff'
abbr gl 'git log --graph --topo-order --abbrev-commit --date=short --decorate --all --boundary'
abbr ga 'git add'

abbr glb "git for-each-ref --sort='-authordate' --format='%(authordate)%09%(objectname:short)%09%(refname)' refs/heads | sed -e 's-refs/heads/--'"

abbr gc 'git commit --verbose'
abbr gca 'git commit -a --verbose'
abbr gcm 'git commit --verbose -m'
abbr gcam 'git commit --verbose -am'
abbr gamen 'git commit --verbose --amend'

abbr gob 'git checkout -b'
abbr go 'git checkout'

abbr gP 'git push'
abbr gp 'git pull'


alias Idea="idea-community . > /dev/null 2>&1 &";

switch (uname)
   case Linux
      . "$HOME/.homesick/repos/homeshick/homeshick.fish"
      source "$HOME/.homesick/repos/homeshick/completions/homeshick.fish"
   case Darwin
      export HOMESHICK_DIR=/usr/local/opt/homeshick
end


# bobthefish
set -g theme_title_display_process yes
# set -g theme_color_scheme terminal-dark
set -g theme_color_scheme solarized-dark
# set -g theme_color_scheme dark

set PATH ~/bin $PATH

function mutt
    bash --login -c 'cd ~/downloads; neomutt' $argv;
end

function mkcd
    mkdir -pv $argv;
    cd $argv;
end

echo  Remember using tig yank jrnl haxor-news rtv thefuck howdoi buku fzf hub newsboat
echo
