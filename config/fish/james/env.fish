set -x ALTERNATE_EDITOR emacs
set -x EDITOR emacsclient
set -x CVSEDITOR emacsclient
set -x CVS_RSH ssh
set -x SVN_EDITOR emacsclient
set -x GIT_EDITOR emacsclient
set -x LC_CTYPE en_US.UTF-8
set -x CLICOLOR 1
set -x JAVA_HOME (/usr/libexec/java_home -v 1.8)
set -x RUBY_CONFIGURE_OPTIONS '--with-opt-dir=/usr/local/opt/openssl:/usr/local/opt/readline:/usr/local/opt/libyaml:/usr/local/opt/gdbm'
set -x ERL_AFLAGS '-kernel shell_history enabled'
set -x KERL_BUILD_DOCS yes

set PATH /Library/Java/JavaVirtualMachines/jdk1.8.0_211.jdk/Contents/Home/bin /usr/local/sbin /usr/local/pgsql/bin /usr/local/heroku/bin $PATH

if test -n "$EMACS"
    set -x TERM eterm-color
end
