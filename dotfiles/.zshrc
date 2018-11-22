source ~/.zplug/init.zsh

zplug "zplug/zplug"  # Plugin manager
zplug "ericdwang/zsh-lightrise"  # Theme
zplug "zsh-users/zsh-syntax-highlighting"  # Syntax highlighting
zplug "zsh-users/zsh-history-substring-search"  # Search history based on input
zplug "tarruda/zsh-autosuggestions"  # Autosuggestions

# Install plugins if there are ones that haven't been installed
if ! zplug check; then
    zplug install
fi

zplug load

# Configuration
eval "$(dircolors ~/.dircolors)"  # Setup dircolors (used in ls)
export EDITOR=vim  # Default editor
export PATH="$PATH:$HOME/.local/bin"  # Python packages
export RIPGREP_CONFIG_PATH=~/.ripgreprc  # ripgrep config
PROMPT_EOL_MARK=""  # Don't show character for partial lines

# Entering commands
bindkey -v  # Vi mode
export KEYTIMEOUT=1  # 0.01s delay for key sequences (remove escape key delay)
setopt INTERACTIVE_COMMENTS  # Allow comments in commands

# History
HISTFILE=~/.zsh_history  # File to use for saving history
HISTSIZE=1000  # Number of commands that a session stores in history
SAVEHIST=$HISTSIZE  # Number of commands saved at the end of a session
setopt HIST_IGNORE_ALL_DUPS  # Remove old duplicate commands from history
setopt HIST_IGNORE_SPACE  # Remove commands with leading space from history

# Completions
zstyle ":completion:*" list-colors "${(s.:.)LS_COLORS}"  # Use dircolors
zstyle ":completion:*" menu "select"  # Change background of current selection
zstyle ":completion:*" use-cache 1  # Use cache
zstyle ":completion:*" users  # Don't show user folders
# Case-insensitive and partial completion
zstyle ":completion:*" matcher-list "m:{a-zA-Z}={A-Za-z}" "+l:|=* r:|=*"

# Keybindings
bindkey "^?" backward-delete-char  # Allow backspace to work in insert mode
bindkey "^[[Z" reverse-menu-complete  # Shift-tab completion
bindkey -M vicmd "/" history-incremental-search-backward  # Normal mode search
bindkey -M vicmd "^r" redo  # Multi-level redo
bindkey -M vicmd "u" undo  # Multi-level undo

# Emacs keybindings with vi mode
bindkey "^a" beginning-of-line
bindkey "^e" end-of-line
bindkey "^k" kill-line
bindkey "^r" history-incremental-search-backward
bindkey "^s" history-incremental-search-forward
bindkey "^y" yank
bindkey "^w" backward-kill-word
bindkey "^u" backward-kill-line
bindkey "\ef" forward-word
bindkey "\eb" backward-word
bindkey "\ed" kill-word

# Vi and Emacs keybindings for history substring search
bindkey -M vicmd "k" history-substring-search-up
bindkey -M vicmd "j" history-substring-search-down
bindkey "^p" history-substring-search-up
bindkey "^n" history-substring-search-down

# Change cursor shape depending on vi mode
function zle-line-init zle-keymap-select {
    case $KEYMAP in
        vicmd) echo -n "\e[2 q";;  # Normal mode: block
        main) echo -n "\e[6 q";;  # Insert mode: line
    esac
}
zle -N zle-line-init
zle -N zle-keymap-select

# Use block cursor after commands are entered
zle-line-finish() { echo -n "\e[2 q"; }
zle -N zle-line-finish

# Enable text objects for quotes and surroundings (zsh 5.0.8+)
autoload -U is-at-least
if is-at-least 5.0.8; then
    autoload -U select-quoted select-bracketed
    zle -N select-quoted
    zle -N select-bracketed

    for m in visual viopp; do
        for c in {a,i}{\',\",\`}; do
            bindkey -M "$m" "$c" select-quoted
        done
        for c in {a,i}${(s..)^:-"()[]{}<>bB"}; do
            bindkey -M "$m" "$c" select-bracketed
        done
    done
fi

# More useful versions of commands
alias bc="bc -ql"  # Start quietly and enable floating point division
alias du="du -sh"  # Display total directory sizes in a human readable format
alias ls="ls -v --color=auto --hide='*.pyc'"  # Natural sort, hide filetypes
alias startx="ssh-agent startx"  # Start/stop ssh-agent along with X
alias sudo="sudo "  # Allow sudo to work with aliases
cd() { builtin cd "$@" && ls; }  # Show files after changing directories
rg() { command rg "$@" | less; }  # Pipe output to pager

# Abbreviated commands
alias py="ptpython"
alias sc="systemctl"
o() { xdg-open "$1" > /dev/null 2>&1 &; }  # Open file with the default program
sa() { ssh-add ~/.ssh/"$1"; }  # Unlock SSH keys
