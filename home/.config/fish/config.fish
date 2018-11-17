alias cpvpn='pushd ~/.ssh; and sudo openvpn --config CP-FW-01-UDP4-1194-massimo.redaelli-config.ovpn; or  popd' 

#alias ls='exa' 
#alias ll='exa -l --git'

alias less='less -r'

alias nano='nvim'
alias vim='nvim'
alias vi='nvim'

alias psg='ps au | grep'

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


