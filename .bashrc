# --- Interactive shell check ---
# Don't do anything if not running interactively
case $- in
    *i*) ;;
      *) return;;
esac

# --- History settings ---
HISTSIZE=10000
HISTFILESIZE=20000
HISTCONTROL=ignoreboth  # ignore duplicates and lines starting with space
shopt -s histappend     # append to history, don't overwrite

# --- Shell options ---
shopt -s checkwinsize   # update LINES and COLUMNS after each command
shopt -s globstar       # enable ** recursive glob (if bash 4+)

# --- Better tab completion ---
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi

# --- Prompt (PS1) ---
PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '

# --- Navigation functions ---
dotf() { cd ~/dotfiles; }

# git aliases
alias gs='git status'
alias ga='git add'
alias gcm='git commit -m'
alias gp='git push'
alias gl='git pull'

# --- Directory navigation ---
alias ..='cd ..'
alias ...='cd ../..'
alias .3='cd ../../..'
alias .4='cd ../../../..'
alias .5='cd ../../../../..'

# --- eza aliases (if installed) ---
if command -v eza &> /dev/null; then
    alias ls='eza -al --color=always --group-directories-first'
    alias la='eza -a --color=always --group-directories-first'
    alias ll='eza -l --color=always --group-directories-first'
    alias lt='eza -aT --color=always --group-directories-first'
    alias l.='eza -al --color=always --group-directories-first ../'
    alias l..='eza -al --color=always --group-directories-first ../../'
    alias l...='eza -al --color=always --group-directories-first ../../../'
fi