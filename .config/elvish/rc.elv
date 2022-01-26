use direnv
use epm

epm:install github.com/zzamboni/elvish-completions
use github.com/zzamboni/elvish-completions/git
use github.com/zzamboni/elvish-completions/builtins
use github.com/zzamboni/elvish-completions/ssh
use github.com/zzamboni/elvish-completions/cd

epm:install github.com/zzamboni/elvish-modules
use github.com/zzamboni/elvish-modules/alias
use github.com/zzamboni/elvish-modules/long-running-notifications

eval (starship init elvish)
eval (zoxide init elvish | slurp)

set long-running-notifications:threshold = 60

set edit:max-height = 20

fn only-when-external { |prog lambda|
  if (has-external $prog) { $lambda }
}

fn iff {|cond a b|
  if $cond { put ($a) } else { put ($b) }
}

fn items {|f @d| 
  var x = (iff (eq $d []) { all } { $d[0] }) 
  keys $x | each { |k| $f $k $x[$k] }
}

alias:new du du -h
alias:new df df -h
alias:new free free -m

only-when-external top {
  alias:new top htop
}

set edit:small-word-abbr = [
  &gs='git status -s'
  &gd='git diff'
  &gl='git log --graph --topo-order --abbrev-commit --date=short --decorate --all --boundary'
  &ga='git add'
  &glb="git for-each-ref --sort='-authordate' --format='%(authordate)%09%(objectname:short)%09%(refname)' refs/heads | sed -e 's-refs/heads/--'"
  &gc='git commit --verbose'
  &gcf='git commit --amend --verbose'
  &gca='git commit -a --verbose'
  &gcaf='git commit -a --verbose --amend'
  &gcm='git commit --verbose -m'
  &gcam='git commit --verbose -am'
  &gf='git fetch -p'
  &gt='git trim'
  &gob='git checkout -b'
  &go='git checkout'
  &gom='git checkout master'
  &gP='git push'
  &gPP='git push --force-with-lease'
  &gp='git pull'
  &grm='git rebase master'
  &grom='git rebase origin/master'
  &grh='git rebase -i HEAD~'
  &gra='git rebase --abort'
  &grc='git rebase --continue'
  &gmm='git merge'
  &gm='git merge --ff'
  &gma='git merge --abort'
  &gmc='git merge --continue'
  &gRo='git pull; and git reset --hard @{u}'
  &gRm='git pull; and git reset --hard origin/master'
  &gro='git pull; and git reset --soft @{u}'
  &gC='git cherry-pick'
  &gCa='git cherry-pick --abort'
  &gCc='git cherry-pick --continue'
]

only-when-external nvim {
  alias:new vim nvim
  alias:new vi nvim
  set edit:small-word-abbr[':e'] = nvim
}
set edit:small-word-abbr[':q'] = exit

only-when-external bat {
  alias:new cat bat
  alias:new ccat bat -p
  alias:new more bat --paging always
  set E:MANPAGER = "sh -c 'col -bx | bat -l man -p'"
}
only-when-external exa {
  alias:new ls exa --icons --group-directories-first
  alias:new ll exa -l --git --icons --color-scale --group-directories-first
  # alias:new l ll
}
only-when-external fd {
  set E:FZF_DEFAULT_COMMAND = 'fd --type f'
  set E:FZF_CTRL_T_COMMAND = "$FZF_DEFAULT_COMMAND"
}
fn mkcd {|a| e:mkdir -p $a; cd $a }

set E:LESS = "-i -R"
set E:EDITOR = "vim"

set paths = [~/bin $@paths]

fn mine {|@p|
  chown -R (id -u):(id -g) $@p
}

fn please {
  sudo (edit:command-history &cmd-only &newest-first | take 2 | drop 1)
}
alias:new whatsmyip curl -s ipinfo.io/ip

set edit:small-word-abbr['|cl'] = "| wl-copy"
set edit:small-word-abbr['<cl'] = "< wl-copy"
set edit:small-word-abbr['cl>'] = "wl-paste >"
set edit:small-word-abbr['cl|'] = "wl-paste |"

fn nix-shell {|@a|
    (which .any-nix-shell-wrapper) elvish $@a
}
set edit:rprompt = (constantly (styled (echo $E:ANY_NIX_SHELL_PKGS) green))
