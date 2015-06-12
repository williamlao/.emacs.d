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
PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND }"'echo $$ $USER "$(history 1)" >> ~/.bash_eternal_history'

#Settings
set history=5000

#Command Aliases
alias ls='ls -GFh'
alias cs="cd /Users/Will/Dropbox/CS"
alias where="type -a"
alias ssh='ssh -A'
alias findword='find . -type f | xargs grep -i'
alias findfile='find . -iname'
alias grep='grep --color=auto'
alias ip_reset="sudo ifconfig en0 down; sudo ifconfig en0 up"
alias ps="ps -e"
alias folderdu="du -sh *"
alias findport="lsof -i tcp:"
alias git_prune_local="git branch -r | awk '{print \$1}' | egrep -v -f /dev/fd/0 <(git branch -vv | grep origin) | awk '{print \$1}' | xargs git branch -d"

# project specific
alias cdadk='cd /Applications/adt-bundle-mac-x86_64-20131030/sdk'
alias cdviscosity='cd ~/Library/Application\ Support/Viscosity/OpenVPN'
alias cdbitcoin='cd ~/Library/Application\ Support/Bitcoin'

alias jsontotab='ruby ~/code/utils/json_to_tsv.rb'
alias tabtojson='ruby ~/code/utils/tab_to_json.rb'
alias csvtotab='ruby ~/code/utils/csv_to_tab.rb'

alias python_server='python -m SimpleHTTPServer'

alias javadoc='java -jar /Applications/javadocjarviewer-0.2.0.jar '

alias subl='/Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl'

alias cnpm="npm --registry=https://registry.npm.taobao.org \
--cache=$HOME/.npm/.cache/cnpm \
--disturl=https://npm.taobao.org/dist" 

source ~/.aws

#Exports
export EDITOR=emacs
export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8" 
export CLICOLOR=1
export LSCOLORS=gxfxcxdxbxegedabagacad
export LS_COLORS=$LSCOLORS
#export JAVA_HOME=/Library/Java/Home
export JAVA_HOME=$(/usr/libexec/java_home)
export CLOJURE_HOME=/usr/local/clojure

export PATH="/usr/local/scala/scala-2.9.0/bin:$PATH"
export PATH="/usr/local/mongodb/bin:$PATH"
export PATH="/usr/local/bin:/usr/local/sbin:$PATH"
export PATH="/Applications/MAMP/bin/php/php5.4.10/bin:$PATH"
export PATH="/Applications/MAMP/Library/bin:$PATH" # use mysql from MAMP
export PATH="~/.play/play-1.2.1:$PATH"
export PATH="~/code/d:$PATH" # d
export PATH="~/.lein/bin:$PATH"
export PATH=/opt/local/bin:/opt/local/sbin:$PATH
export PATH="~/bin:$PATH"
export PATH="/Applications/adt-bundle-mac-x86_64-20131030/sdk/tools:$PATH"
export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
export PATH="$PATH:$HOME/PredictionIO/bin"
export PATH="$PATH:$HOME/code/spark/bin"
export PATH="$PATH:/anaconda/bin"


[[ -s "/Users/Will/.rvm/scripts/rvm" ]] && source "/Users/Will/.rvm/scripts/rvm"
[ -s $HOME/.nvm/nvm.sh ] && . $HOME/.nvm/nvm.sh # This loads NVM

#################################
# Helper Functions
#################################

################################
# Completions
###############################

# Git bash_completion
if [ -f `brew --prefix`/etc/bash_completion ]; then
    . `brew --prefix`/etc/bash_completion
fi

# Bash git-flow-completion
source ~/.emacs.d/other/.git-flow-completion.sh

have()
{
    unset -v have
    # Completions for system administrator commands are installed as well in
    # case completion is attempted via `sudo command ...'.
    PATH=$PATH:/sbin:/usr/sbin:/usr/local/sbin type $1 &>/dev/null &&
    have="yes"
}

if [ -f ~/code/bitcoin/contrib/bitcoind.bash-completion ]; then
    source ~/code/bitcoin/contrib/bitcoind.bash-completion
fi


#################################
# MISC FUNCTIONS
#################################

function git_branch {
  ref=$(git symbolic-ref HEAD 2> /dev/null) || return;
  echo " [GIT:"${ref#refs/heads/}"] ";
}

function whatismyip {
  wget http://automation.whatismyip.com/n09230945.asp -O - -q
  echo
}

# Easily extract all compressed file types
extract () {
   if [ -f "$1" ] ; then
       case $1 in
           *.tar.bz2)   tar xvjf -- "$1"    ;;
           *.tar.gz)    tar xvzf -- "$1"    ;;
           *.bz2)       bunzip2 -- "$1"     ;;
           *.rar)       unrar x -- "$1"     ;;
           *.gz)        gunzip -- "$1"      ;;
           *.tar)       tar xvf -- "$1"     ;;
           *.tbz2)      tar xvjf -- "$1"    ;;
           *.tgz)       tar xvzf -- "$1"    ;;
           *.zip)       unzip -- "$1"       ;;
           *.Z)         uncompress -- "$1"  ;;
           *.7z)        7z x -- "$1"        ;;
           *)           echo "don't know how to extract '$1'..." ;;
       esac
   else
       echo "'$1' is not a valid file"
   fi
}

# Epoch time conversion
epoch() {
  TESTREG="[\d{10}]"
  if [[ "$1" =~ $TESTREG ]]; then
    # is epoch
    date -r $*
  else
    # is date
    if [ $# -gt 0 ]; then
      date +%s --date="$*"
    else
      date +%s
    fi
  fi
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

# if want mysql on login
# ln -sfv /usr/local/opt/mysql/*.plist ~/Library/LaunchAgents
# launchctl load ~/Library/LaunchAgents/homebrew.mxcl.mysql.plist

# if want redis on login
# ln -sfv /usr/local/opt/redis/*.plist ~/Library/LaunchAgents
# launchctl load ~/Library/LaunchAgents/homebrew.mxcl.redis.plist
# redis-server /usr/local/etc/redis.conf

# emacs change mac file to utf : set-buffer-file-coding-system
