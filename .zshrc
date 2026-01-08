# Interactive check
[[ -o interactive ]] || return

#======================================
# HISTORY
#======================================
HISTSIZE=1000
SAVEHIST=2000
HISTFILE=~/.zsh_history
setopt SHARE_HISTORY          # Share history between sessions
setopt HIST_IGNORE_DUPS       # Don't record duplicate commands
setopt HIST_IGNORE_SPACE      # Don't record commands starting with space
setopt EXTENDED_HISTORY       # Save timestamp with history
setopt INC_APPEND_HISTORY     # Add commands immediately, not at shell exit
setopt HIST_FIND_NO_DUPS      # Don't show duplicates when searching
setopt HIST_REDUCE_BLANKS     # Remove extra blanks from commands

#======================================
# SHELL OPTIONS
#======================================
setopt AUTO_CD                # cd by typing directory name
setopt AUTO_PUSHD             # cd pushes to directory stack (use popd to go back)
setopt PUSHD_IGNORE_DUPS      # Don't push duplicate directories
setopt CORRECT                # Spell correction for commands
setopt EXTENDED_GLOB          # Powerful globs: **/*.ts~node_modules/*
setopt GLOBDOTS               # Include dotfiles in globs
setopt CDABLE_VARS            # cd into named variables (cd GOPATH)

#======================================
# KEY BINDINGS
#======================================
bindkey -v                    # Vi mode
bindkey '^R' history-incremental-search-backward  # Ctrl+R history search
bindkey '^[[A' up-line-or-search     # Up arrow searches history
bindkey '^[[B' down-line-or-search   # Down arrow searches history

#======================================
# PROMPT
#======================================
autoload -Uz vcs_info
precmd() { vcs_info }
zstyle ':vcs_info:git:*' formats '%F{red}(%b)%f '
setopt PROMPT_SUBST
PROMPT='%F{green}%n@%m%f:%F{blue}%2~%f ${vcs_info_msg_0_}%# '

#======================================
# ALIASES
#======================================
alias ll='ls -alFG'
alias la='ls -AG'
alias l='ls -CFG'
alias grep='grep --color=auto'
alias git-lg="git log --graph --pretty=format:'%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ar) %C(bold blue)<%an>%Creset' --abbrev-commit"

# Git global alias
if command -v git >/dev/null 2>&1; then
	git config --global alias.lg "log --graph --pretty=format:'%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ar) %C(bold blue)<%an>%Creset' --abbrev-commit"
fi

# Claude CLI
[[ -f "$HOME/.claude/local/claude" ]] && alias claude="$HOME/.claude/local/claude"

#======================================
# PATH CONFIGURATION
#======================================
# Homebrew (Apple Silicon vs Intel)
if [[ -d "/opt/homebrew" ]]; then
	eval "$(/opt/homebrew/bin/brew shellenv)"
elif [[ -d "/usr/local/Homebrew" ]]; then
	eval "$(/usr/local/bin/brew shellenv)"
fi

# User bin
[[ -d "$HOME/bin" ]] && export PATH="$HOME/bin:$PATH"

# Go
if [[ -d "/usr/local/go" ]] || command -v go >/dev/null 2>&1; then
	mkdir -p "$HOME/go"
	export GOPATH="$HOME/go"
	[[ -d "/usr/local/go/bin" ]] && export PATH="$PATH:/usr/local/go/bin"
	export PATH="$PATH:$GOPATH/bin"
fi

# Rust
[[ -d "$HOME/.cargo/bin" ]] && export PATH="$HOME/.cargo/bin:$PATH"

# Node.js - npm global packages
mkdir -p "$HOME/.npm-global"
export NPM_CONFIG_PREFIX="$HOME/.npm-global"
export PATH="$HOME/.npm-global/bin:$PATH"

# Yarn
[[ -d "$HOME/.yarn/bin" ]] && export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

# pnpm (macOS location)
if [[ -d "$HOME/Library/pnpm" ]]; then
	export PNPM_HOME="$HOME/Library/pnpm"
	export PATH="$PNPM_HOME:$PATH"
fi

# Bun
if [[ -d "$HOME/.bun" ]]; then
	export BUN_INSTALL="$HOME/.bun"
	export PATH="$BUN_INSTALL/bin:$PATH"
fi

#======================================
# COMPLETIONS
#======================================
autoload -Uz compinit && compinit
zstyle ':completion:*' menu select                    # Arrow-key menu selection
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'   # Case-insensitive completion
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"  # Colorize completions

# SSH hostname completion from ~/.ssh/config
if [[ -e "$HOME/.ssh/config" ]]; then
	_ssh_hosts() {
		compadd $(grep "^Host" ~/.ssh/config | grep -v "[?*]" | cut -d " " -f2)
	}
	compdef _ssh_hosts ssh scp sftp
fi

# Local customizations
[[ -f "$HOME/.zshrc.local" ]] && source "$HOME/.zshrc.local"
