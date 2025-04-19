#!/bin/bash
# ~/.bashrc: executed by bash(1) for non-login shells.

# If not running interactively, don't do anything
case $- in
	*i*) ;;
*) return;;
esac

#======================================
# HISTORY CONFIGURATION
#======================================
# Don't put duplicate lines or lines starting with space in the history
HISTCONTROL=ignoreboth

# Append to the history file, don't overwrite it
shopt -s histappend

# Set history size
HISTSIZE=1000
HISTFILESIZE=2000

#======================================
# SHELL OPTIONS
#======================================
# Check window size after each command and update LINES and COLUMNS
shopt -s checkwinsize

# Enable vi mode for command line editing
set -o vi

#======================================
# TERMINAL CONFIGURATION
#======================================
# Make less more friendly for non-text input files
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# Set variable identifying the chroot you work in (used in the prompt)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
	debian_chroot=$(cat /etc/debian_chroot)
fi

# Set xterm to 256 colors if needed
if [[ $TERM == xterm ]]; then
	TERM=xterm-256color
fi

#======================================
# PROMPT CONFIGURATION
#======================================
# Force color prompt
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
	if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
		# We have color support
		color_prompt=yes
	else
		color_prompt=
	fi
fi

# Git branch display function for prompt
parse_git_branch() {
	git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}

# Set a nicer prompt with current directory and git branch
if [ "$color_prompt" = yes ]; then
	PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\] $(basename "$(dirname "$PWD")")/$(basename "$PWD") \[\033[01;31m\]$(parse_git_branch)\[\033[00m\]\$ '
else
	PS1='${debian_chroot:+($debian_chroot)}\u@\h: $(basename "$(dirname "$PWD")")/$(basename "$PWD") $(parse_git_branch)\$ '
fi

# Set the terminal title if this is an xterm
case "$TERM" in
	xterm*|rxvt*)
		PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
		;;
	*)
		;;
esac

#======================================
# ALIASES
#======================================
# Color support for common commands
if [ -x /usr/bin/dircolors ]; then
	test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
	alias ls='ls --color=auto'
	alias dir='dir --color=auto'
	alias vdir='vdir --color=auto'
	alias grep='grep --color=auto'
	alias fgrep='fgrep --color=auto'
	alias egrep='egrep --color=auto'
fi

# Convenient ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

#======================================
# GIT ALIASES
#======================================
# Set up git aliases for prettier and more useful output

# Better git log - shows graph with branch decorations, dates, authors
# Can be used with additional flags: git lg --all
alias git-lg="git log --graph --pretty=format:'%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ar) %C(bold blue)<%an>%Creset' --abbrev-commit"

# Global git aliases (can be used as git commands)
if command -v git >/dev/null 2>&1; then
    # Configure git lg command - prettier log with graph and colors
    git config --global alias.lg "log --graph --pretty=format:'%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ar) %C(bold blue)<%an>%Creset' --abbrev-commit"
fi

#======================================
# BASH COMPLETION
#======================================
# Enable programmable completion features
if ! shopt -oq posix; then
	if [ -f /usr/share/bash-completion/bash_completion ]; then
		. /usr/share/bash-completion/bash_completion
	elif [ -f /etc/bash_completion ]; then
		. /etc/bash_completion
	fi
fi

# Add tab completion for SSH hostnames based on ~/.ssh/config
[[ -e "$HOME/.ssh/config" ]] && complete -o "default" \
	-o "nospace" \
	-W "$(grep "^Host" ~/.ssh/config | \
	grep -v "[?*]" | cut -d " " -f2 | \
	tr ' ' '\n')" scp sftp ssh

#======================================
# PATH CONFIGURATION (from .path)
#======================================
# Include user bin in PATH if it exists
if [ -d "$HOME/bin" ]; then
	PATH="$HOME/bin:$PATH"
fi

# Go environment
if [ -d "$HOME/go" ]; then
	export GOPATH="$HOME/go"
	export PATH="$PATH:/usr/local/go/bin:$GOPATH/bin"
fi

# Rust cargo
if [ -d "$HOME/.cargo/bin" ]; then
	export PATH="$HOME/.cargo/bin:$PATH"
fi

# Java path - checks if directory exists before adding
if [ -d "/usr/local/java/jdk1.8.0_161" ]; then
	export JAVA_HOME="/usr/local/java/jdk1.8.0_161"
	export PATH="$PATH:${JAVA_HOME}/bin"
fi

# Android development - checks if directory exists
if [ -d "$HOME/androidsdks" ]; then
	export ANDROID_HOME="$HOME/androidsdks"
	export PATH="$PATH:${ANDROID_HOME}/tools"
	export PATH="$PATH:${ANDROID_HOME}/platform-tools"
fi

# Node.js - npm global packages
if [ -d "$HOME/.npm-global/bin" ]; then
	export PATH="$HOME/.npm-global/bin:$PATH"
fi

# Yarn - checks if directory exists
if [ -d "$HOME/.yarn/bin" ]; then
	export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
fi


if [ -d "$HOME/.bun" ]; then
	export BUN_INSTALL="$HOME/.bun"
	export PATH="$BUN_INSTALL/bin:$PATH"
fi

#======================================
# LOCAL CUSTOMIZATIONS
#======================================
# Source local bash configuration if it exists
if [ -f "$HOME/.bashrc.local" ]; then
	. $HOME/.bashrc.local
fi

