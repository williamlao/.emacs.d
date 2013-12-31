echo "**********************************"
echo Starting $USER Profile

mydate=`date '+%H:%M:%S %m/%d/%y'`
echo Current time: $mydate
echo "**********************************"

#######################################################
# Console Settings
######################################################

#Shell Vaiables
PS1='\u:\w$ '
PS1='\[\033[00;32m\]\u:\[\033[00;36m\]\w\[\033[00m\]\[\033[00;32m\]$(git_branch)\[\033[00m\]\[\033[00;31m\]\$\[\033[00m\]'
PS2='> '
PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND ; }"'echo $$ $USER "$(history 1)" >> ~/.bash_eternal_history'

#Settings
set history=5000

#Command Aliases
alias ls='ls -GFh'
alias cs="cd /Users/Will/Dropbox/CS"
alias where="type -a"
alias ssh='ssh -A'
alias findword='find . | xargs grep -i'
alias findfile='find . -iname'
alias grep='grep --color=auto'
alias ip_reset="sudo ifconfig en0 down; sudo ifconfig en0 up"
alias ps="ps -e"

# project specific
alias cdadk='cd /Applications/adt-bundle-mac-x86_64-20131030/sdk'
alias cdviscosity='cd ~/Library/Application\ Support/Viscosity/OpenVPN'

alias jsontotab='ruby ~/code/batch_clipper_app/extract/misc/json_to_tsv.rb'
alias tabtojson='ruby ~/code/batch_clipper_app/extract/misc/tab_to_json.rb'
alias csvtotab='ruby ~/code/batch_clipper_app/extract/misc/csv_to_tab.rb'

alias mysql_start='/usr/local/bin/mysql.server start'
alias python_server='python -m SimpleHTTPServer'

alias javadoc='java -jar /Applications/javadocjarviewer-0.2.0.jar '
alias stunnelstart="stunnel /usr/local/etc/stunnel/stunnel.conf"

alias useproxy='http_proxy=10.0.10.1:3128'
alias lhotsetunnel='ssh -N -D 7070 lhotse'
alias startup101="ssh -i ~/.ssh/startup101.pem ubuntu@54.213.38.19"

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

export PATH=$SCALA_HOME:$PATH
export PATH=$MONGO_HOME:$PATH
export PATH="/usr/local/bin:/usr/local/sbin:$PATH"
export PATH="/Applications/MAMP/bin/php/php5.4.10/bin:$PATH"
export PATH="~/.play/play-1.2.1:$PATH"
export PATH="~/code/d:$PATH" # d
export PATH="~/.lein/bin:$PATH"
export PATH=/opt/local/bin:/opt/local/sbin:$PATH
export PATH="~/code/bitcoin/src:$PATH"
export PATH="~/bin:$PATH"
#export DYLD_LIBRARY_PATH="/usr/local/lib/temp" #:/Users/Will/factual/re2" # adding re2 and its jni path
[[ -s "/Users/Will/.rvm/scripts/rvm" ]] && source "/Users/Will/.rvm/scripts/rvm"


################################
# Completions
###############################

# Bash git-flow-completion
source ~/.emacs.d/other/.git-flow-completion.sh

# Git bash_completion
if [ -f `brew --prefix`/etc/bash_completion ]; then
    . `brew --prefix`/etc/bash_completion
fi

#################################
# Misc Functions
#################################

# Reset istat menus's trial date
rm ~/Library/Preferences/com.bjango.istatmenus.plist > /dev/null 2>&1

#################################
# HELPER FUNCTIONS
#################################

function git_branch {
  ref=$(git symbolic-ref HEAD 2> /dev/null) || return;
  echo " [GIT:"${ref#refs/heads/}"] ";
}

function whatismyip {
  wget http://automation.whatismyip.com/n09230945.asp -O - -q
  echo
}

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
