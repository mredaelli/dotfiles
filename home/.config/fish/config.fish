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
alias gs='git status -s'
alias gd='git diff'
alias gl='git log --graph --topo-order --abbrev-commit --date=short --decorate --all --boundary --pretty=format:"%Cgreen%ad %Cred%h%Creset -%C(yellow)%d%Creset %s %Cblue[%cn]%Creset %Cblue%G?%Creset"'
alias ga='git add'

alias glb="git for-each-ref --sort='-authordate' --format='%(authordate)%09%(objectname:short)%09%(refname)' refs/heads | sed -e 's-refs/heads/--'"

alias gc='git commit --verbose'
alias gca='git commit -a --verbose'
alias gcm='git commit --verbose -m'
alias gcam='git commit --verbose -am'
alias gamen='git commit --verbose --amend'

alias gob='git checkout -b'
alias go='git checkout'

alias gP='git push'
alias gp='git pull'


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

if test -d ~/miniconda3
  set PATH ~/miniconda3/bin $PATH
  source (conda info --root)/etc/fish/conf.d/conda.fish
end

function mutt
    bash --login -c 'cd ~/downloads; neomutt' $argv;
end

function mkcd
    mkdir -pv $argv;
    cd $argv;
end


