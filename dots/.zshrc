if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="powerlevel10k/powerlevel10k"
ENABLE_CORRECTION="true"
COMPLETION_WAITING_DOTS="true"

# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

source $ZSH/oh-my-zsh.sh
#
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

####### User configuration ####### 

export XDG_CONFIG_HOME=$HOME/.config
export NVIM_CONFIG_HOME=$XDG_CONFIG_HOME/nvim
export GOPATH=~/go
export GOROOT=/usr/local/go
export GOBIN="$GOPATH/bin"

####### Customization #######

set -o vi
bindkey "jj" vi-cmd-mode

####### Alias & Function #######
alias tmpalias="source $XDG_CONFIG_HOME/tmpalias.sh"
alias eiv="vim $NVIM_CONFIG_HOME/init.vim"
alias edc="vim $NVIM_CONFIG_HOME/dein.toml"
alias edl="vim $NVIM_CONFIG_HOME/dein_lazy.toml"
alias pj="cd ~/repo"
ggs () { /opt/google/chrome/google-chrome "https://google.co.jp/search?q=$1" & ; }
godir () { cd "$GOPATH/src/$1" ; }

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

test $XDG_CONFIG_HOME/tempalias.sh && tmpalias
