#
# ~/.bashrc
#
export PATH=$PATH:~/bin
export PATH=$PATH:~/.config/i3blocks/scripts
export PATH=$PATH:~/.cargo/bin
export PATH=$PATH:~/bin/flac2mp3
export OPENER=rifle
export EDITOR=nvim
export BROWSER=chromium
export MANPAGER="/bin/sh -c \"col -b | nvim -c 'set ft=man ts=8 nomod nolist nonu noma' -\""
# JAVA
export JAVA_HOME="/usr/lib/jvm/java-11-openjdk"
export PATH=$PATH:$JAVA_HOME/bin

HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

# Check if zplug is installed
if [[ ! -d ~/.zplug ]]; then
  git clone https://github.com/zplug/zplug ~/.zplug
  source ~/.zplug/init.zsh && zplug update --self
fi

source ~/.zplug/init.zsh

# install plugins
zplug "zsh-users/zsh-autosuggestions"
zplug "zsh-users/zsh-completions"
zplug "zsh-users/zsh-syntax-highlighting", defer:2
zplug "plugins/rust", from:oh-my-zsh
zplug "plugins/cargo", from:oh-my-zsh

# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

# prompt
eval "$(starship init zsh)"

# Then, source plugins and add commands to $PATH
zplug load

# vim mode
bindkey -v
bindkey "^?" backward-delete-char

# Change cursor shape for different vi modes.
function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]] ||
     [[ $1 = 'block' ]]; then
    echo -ne '\e[1 q'
  elif [[ ${KEYMAP} == main ]] ||
       [[ ${KEYMAP} == viins ]] ||
       [[ ${KEYMAP} = '' ]] ||
       [[ $1 = 'beam' ]]; then
    echo -ne '\e[5 q'
  fi
}
zle -N zle-keymap-select
zle-line-init() {
    zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
    echo -ne "\e[5 q"
}
zle -N zle-line-init
echo -ne '\e[5 q' # Use beam shape cursor on startup.
preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.

zstyle :compinstall filename '$HOME/.zshrc'

# autocomplete
zstyle ':completion:*' menu select
autoload -Uz compinit && compinit
_comp_options+=(globdots)           # Include hidden files.


setopt hist_ignore_all_dups
setopt hist_reduce_blanks
setopt extended_history
setopt complete_aliases

# aliases
alias la='ls --group-directories-first -a --color=auto'
alias ls='ls --group-directories-first --color=auto'
alias ll='ls --group-directories-first -al --color=auto'
alias grep='grep --color=auto'
alias shutdown='shutdown now'
alias suspend='systemctl suspend'
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
alias vim='nvim'
alias pac='sudo pacman'
alias r='ranger'
alias mkd='mkdir -pv'
alias cp='cp -i'
alias df='df -h'

# fzf with fd for super fast fuzzy searching
export FZF_DEFAULT_COMMAND='fd --hidden --type f --exclude={.git,.cache,Music}'
# export FZF_DEFAULT_OPTS='--ansi'
export FZF_CTRL_T_COMMAND='fd --hidden --type f --exclude ".git"'

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
