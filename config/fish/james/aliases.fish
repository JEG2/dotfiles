# Git
alias g="git status"
alias ga="git add"
alias gaa="git add --all ."
alias gc="git commit -m"
alias gb="git branch"
alias gba="git branch -a"
alias gbd="git branch -d"
alias gco="git checkout"
alias gcob="git checkout -b"
alias gcot="git checkout -t"
alias gm="git merge"
alias gl="git log"
alias glr="git --no-pager log --graph --abbrev-commit --date=relative -10 --all --pretty='tformat:%C(yellow)%h%Creset -%C(red)%d%Creset %s %Cgreen(%ar) %C(bold blue)<%an>%Creset'"
alias gs="git show"
alias gd="git diff"
alias gbl="git blame"
alias gps="git push"
alias gpsd="git push --delete"
alias gpso="git push -u origin"
alias gpsdo="git push --delete origin"
alias gpl="git pull"
alias gh='git config --get remote.origin.url | ruby -ne "puts %{https://github.com/#{\$_.split(/.com[\:\/]/)[-1].gsub(%{.git},%{})}}"| xargs open'

# Ruby
alias r="ruby"
alias i="irb"
alias rk="rake"
alias rkt="rake -T"
alias b="bundle"
alias be="bundle exec"
alias bi="bundle install"
alias bu="bundle update"
alias berk="bundle exec rake"

# Rails
# console
function rlc
  if [ -x bin/rails ]
    bin/rails console $argv
  else if [ -x script/console ]
    script/console $argv
  else
    bundle exec rails console $argv
  end
end
# server
function rls
  if [ -x bin/foreman ]
    bin/foreman start $argv
  else if [ -a Procfile ]
    bundle exec foreman start $argv
  else if [ -x bin/rails ]
    bin/rails server $argv
  else if [ -x script/server ]
    script/server $argv
  else
    bundle exec rails server $argv
  end
end
# generator
function rlg
  if [ -x bin/rails ]
    bin/rails generate $argv
  else if [ -x script/generate ]
    script/generate $argv
  else
    bundle exec rails generate $argv
  end
end
# other
alias rkdm="rake db:migrate"
alias rkdmr="rake db:migrate:redo"
alias rkdr="rake db:rollback"
alias rkdc="rake db:create"
alias rklc="rake log:clear"
alias rkr="rake routes"
alias berkdm="bundle exec rake db:migrate"
alias berkdmr="bundle exec rake db:migrate:redo"
alias berkdr="bundle exec rake db:rollback"
alias berkdc="bundle exec rake db:create"
alias berklc="bundle exec rake log:clear"
alias berkr="bundle exec rake routes"
alias berl="bundle exec rails"
alias brk="bin/rake"
alias brkdm="bin/rake db:migrate"
alias brkdmr="bin/rake db:migrate:redo"
alias brkdr="bin/rake db:rollback"
alias brkdc="bin/rake db:create"
alias brklc="bin/rake log:clear"
alias brkr="bin/rake routes"
alias brl="bin/rails"

# Emacs
if [ -n "$EMACS" ]  # inside Emacs terminals
  alias ri="PAGER='less -R' ri -f ansi"
  alias ssh="TERM=xterm ssh"
end
