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

# Source shared aliases
if [ -f ~/.shell_aliases ]; then
    . ~/.shell_aliases
fi