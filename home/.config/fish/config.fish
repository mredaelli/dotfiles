alias cpvpn='pushd ~/.ssh; and sudo openvpn --config CPMassimoRedaelli-TO-cp-fw-01.ovpn; or  popd' 

alias kitty='python3 ~/bin/kitty' 

alias ls='exa' 
alias ll='exa -l --git'

alias nano='nvim'
alias vim='nvim'
alias vi='nvim'

alias psg='ps au | grep'

. "$HOME/.homesick/repos/homeshick/homeshick.fish"
source "$HOME/.homesick/repos/homeshick/completions/homeshick.fish"
