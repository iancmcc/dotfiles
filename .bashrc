case $- in
    *i*) ;;
    *) return;;
esac

export XKB_DEFAULT_OPTIONS=ctrl:nocaps

# check window size after each command and, if necessary,
# update the values of LINES and COLUMNS
shopt -s checkwinsize

alias ls='ls --color=auto'
alias dir='dir --color=auto'
alias vdir='vdir --color=auto'

alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

if [[ -f $HOME/.bash_profile ]]; then
    source $HOME/.bash_profile
fi

export PATH=${HOME}/bin:${HOME}/.local/bin:$PATH

[[ -s "/home/ian/.gvm/scripts/gvm" ]] && source "/home/ian/.gvm/scripts/gvm"

#if [ -n "$DISPLAY" ]; then
#	export TERM=rxvt-256color
#    /usr/bin/xmodmap ~/.Xmodmap
#fi

export GOPATH=~
export JIGROOT=~/src

#source /usr/local/google/google-cloud-sdk/completion.bash.inc
#source /usr/local/google/google-cloud-sdk/path.bash.inc

export PATH=/usr/local/node/bin:${PATH}

#source <(kubectl completion bash)

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$HOME/bin:$PATH"


#[ -f ~/.fzf.bash ] && source ~/.fzf.bash

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
