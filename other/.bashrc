echo "**********************************"
echo Starting $USER Profile

mydate=`date '+%H:%M:%S %m/%d/%y'`
echo Current time: $mydate
echo "**********************************"

# git branch detect
function git_branch {
  ref=$(git symbolic-ref HEAD 2> /dev/null) || return;
  echo " [GIT:"${ref#refs/heads/}"] ";
}

function whatismyip {
  wget http://automation.whatismyip.com/n09230945.asp -O - -q
  echo
}

#Free istat menus
rm ~/Library/Preferences/com.bjango.istatmenus.plist > /dev/null 2>&1

#Shell Vaiables
PS1='\u:\w$ '
PS1='\[\033[00;32m\]\u:\[\033[00;36m\]\w\[\033[00m\]\[\033[00;32m\]$(git_branch)\[\033[00m\]\[\033[00;31m\]\$\[\033[00m\]'
PS2='> '

#Settings
set history=5000

#Command Aliases
alias ls='ls -GFh'
alias ps='ps -e'
alias cs="cd /Users/Will/Dropbox/CS"
alias where="type -a"
alias ssh='ssh -A'
alias findword='find . | xargs grep -i'
alias findfile='find . -iname'
alias grep='grep --color=auto'
alias jsontotab='ruby ~/code/batch_clipper_app/extract/misc/json_to_tsv.rb'
alias tabtojson='ruby ~/code/batch_clipper_app/extract/misc/tab_to_json.rb'
alias csvtotab='ruby ~/code/batch_clipper_app/extract/misc/csv_to_tab.rb'
alias useproxy='http_proxy=10.0.10.1:3128'
alias mysql_start='/usr/local/bin/mysql.server start'
alias lhotsetunnel='ssh -N -D 7070 lhotse'
function srm () {
  local path
  for path in "$@"; do
    # ignore any arguments
    if [[ "$path" = -* ]]; then :
    else
      local dst=${path##*/}
      # append the time if necessary
      while [ -e ~/.Trash/"$dst" ]; do
        dst="$dst "$(date +%H-%M-%S)
      done
      mv "$path" ~/.Trash/"$dst"
    fi
  done
}
function mid {
  tail -n +$1 $2
}

#Exports
export EDITOR=emacs
export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8" 
export CLICOLOR=1
export LSCOLORS=gxfxcxdxbxegedabagacad
export LS_COLORS=$LSCOLORS
export JAVA_HOME=/Library/Java/Home
export SCALA_HOME=/usr/local/scala/scala-2.9.0/bin
export CLOJURE_HOME=/usr/local/clojure
export MONGO_HOME=/usr/local/mongodb/bin
export VISCOSITY="~//Library/Application\ Support/Viscosity/OpenVPN"

export PATH=$SCALA_HOME:$PATH
export PATH=$MONGO_HOME:$PATH
export PATH="/usr/local/bin:/usr/local/sbin:$PATH"
export PATH="~/.play/play-1.2.1:$PATH"
export PATH=/opt/local/bin:/opt/local/sbin:$PATH
export PATH="/usr/alocal/rvm:$PATH" #rvm
export PATH="~/code/d:$PATH" # d
export PATH="~/.lein/bin:$PATH"

#export DYLD_LIBRARY_PATH="/usr/local/lib/temp" #:/Users/Will/factual/re2" # adding re2 and its jni path


#Git bash_completion
if [ -f /opt/local/etc/bash_completion ]; then
    . /opt/local/etc/bash_completion
fi

if [ -f `brew --prefix`/etc/bash_completion ]; then
    . `brew --prefix`/etc/bash_completion
fi

# Bash git-flow-completion
#source ~/.git-flow-completion.sh

#Scarecrow bash-completion
source ~/code/scarecrow/scarecrow-completion.bash


# This loads RVM into a shell session
[[ -s "/Users/Will/.rvm/scripts/rvm" ]] && source "/Users/Will/.rvm/scripts/rvm"

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
