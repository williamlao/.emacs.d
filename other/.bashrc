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
alias folderdu="du -sh *"


# project specific
alias cdadk='cd /Applications/adt-bundle-mac-x86_64-20131030/sdk'
alias cdviscosity='cd ~/Library/Application\ Support/Viscosity/OpenVPN'
alias cdbitcoin='cd ~/Library/Application\ Support/Bitcoin'

alias jsontotab='ruby ~/code/batch_clipper_app/extract/misc/json_to_tsv.rb'
alias tabtojson='ruby ~/code/batch_clipper_app/extract/misc/tab_to_json.rb'
alias csvtotab='ruby ~/code/batch_clipper_app/extract/misc/csv_to_tab.rb'

alias python_server='python -m SimpleHTTPServer'

alias javadoc='java -jar /Applications/javadocjarviewer-0.2.0.jar '
alias stunnelstart="stunnel /usr/local/etc/stunnel/stunnel.conf"

alias useproxy='http_proxy=10.0.10.1:3128'
alias lhotsetunnel='ssh -N -D 7070 lhotse'
alias hktunnel='sudo ssh -i ~/.ssh/will -L 2222:54.249.125.27:22 root@119.9.74.16'
alias vpntunnel='sudo ssh -i ~/.ssh/will -p 2222 -L 2223:172.31.23.80:22 -L 2224:172.31.10.54:22 will@localhost'
alias vg1tunnel='sudo ssh -i ~/.ssh/will -p 2223 will@localhost'
alias m1tunnel='sudo ssh -i ~/.ssh/will -p 2224 will@localhost'
alias emaillog='/Applications/MAMP/bin/php/php5.4.10/bin/php application/bin/cli.php email printemail'
alias emailsender='/Applications/MAMP/bin/php/php5.4.10/bin/php application/bin/cli.php email mailsender'


#Exports
export EDITOR=emacs
export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8" 
export CLICOLOR=1
export LSCOLORS=gxfxcxdxbxegedabagacad
export LS_COLORS=$LSCOLORS
export JAVA_HOME=/Library/Java/Home
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

#export DYLD_LIBRARY_PATH="/usr/local/lib/temp" #:/Users/Will/factual/re2" # adding re2 and its jni path
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
source ~/code/bitcoin/contrib/bitcoind.bash-completion


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
