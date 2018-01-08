alias cpvpn='pushd ~/.ssh; and sudo openvpn --config CPMassimoRedaelli-TO-cp-fw-01.ovpn; or  popd' 

alias ls='exa' 
alias ll='exa -l --git'

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

set PATH ~/bin $PATH

# bobthefish
set -g theme_title_display_process yes
# set -g theme_color_scheme terminal-dark
set -g theme_color_scheme solarized-dark
# set -g theme_color_scheme dark
