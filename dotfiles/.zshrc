source ~/.zplug/zplug

zplug "themes/sunrise", from:oh-my-zsh  # Theme
zplug "zsh-users/zsh-syntax-highlighting"  # Syntax highlighting
zplug "zsh-users/zsh-history-substring-search"  # Search history based on input
zplug "hchbaw/opp.zsh", if:"! is-at-least 5.0.8"  # Improved Vim text objects

# Install plugins if there are ones that haven't been installed
if ! zplug check; then
    zplug install
fi

zplug load

# Configuration
eval "$(dircolors ~/.dircolors)"  # Setup dircolors (used in ls)
export EDITOR=vim  # Default editor
export KEYTIMEOUT=1  # 0.01s delay for key sequences (remove escape key delay)
export TERM=xterm-256color  # Allow 256 color support in terminal programs
set -o vi  # Vi mode

# Keybindings
bindkey "^?" backward-delete-char  # Allow backspace to work in insert mode
bindkey -M menuselect "^[[Z" reverse-menu-complete  # Shift-tab completion
bindkey -M vicmd "/" history-incremental-search-backward  # Normal mode search
bindkey -M vicmd "^r" redo  # Multi-level redo
bindkey -M vicmd "u" undo  # Multi-level undo

# Emacs keybindings with vi mode
bindkey "^a" beginning-of-line
bindkey "^e" end-of-line
bindkey "^k" kill-line
bindkey "^r" history-incremental-pattern-search-backward
bindkey "^s" history-incremental-pattern-search-forward
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

# More useful versions of commands
alias ag="ag -A 2 -B 2"  # Show lines surrounding matches
alias du="du -sh"  # Display total directory sizes in a human readable format
alias ls="ls -v --color=auto --hide='*.pyc'"  # Natural sort, hide filetypes
alias sudo="sudo "  # Allow sudo to work with aliases
cd() { builtin cd "$@" && ls; }  # Show files after changing directories

# Abbreviated commands
alias untar="tar -xvf"
o() { xdg-open "$1" > /dev/null 2>&1 &; }  # Open file with the default program
p() { pass "$@" -c; }  # Copy passwords to clipboard
compdef p=pass

# Apt commands
alias aa="add-apt-repository"
alias ad="aptitude update"
alias ai="aptitude install"
alias ap="aptitude upgrade"
alias ar="aptitude remove"

# Python commands
alias pi="pip install"
alias pu="pip uninstall"
alias py="ptipython"
source /usr/local/bin/virtualenvwrapper.sh  # Virtual environment management

# Git abbreviated commands
alias ga="git add"
alias gb="git branch"
alias gc="git commit"
alias gm="git merge"
alias go="git checkout"
alias gp="git pull"
alias gpu="git push"
alias gr="git reset"
alias gs="git status"
alias gw="git show"

# Customized Git commands
alias gd="git diff --diff-filter=M --color-words"  # Diff tracked files by word
alias gl="git log --graph"  # Show log as a graph

# More advanced Git commands
alias gca="gc --amend --no-edit"  # Amend commit with same message
alias gdh="gd HEAD^"  # Diff current commit
alias gds="gd --staged"  # Diff staged files
alias gpuo="gpu -u origin \$(git symbolic-ref --short HEAD)"  # Push new branch
alias gro="gr --hard @{u}"  # Undo all local changes to current branch
alias gu="gr --soft HEAD^"  # Undo current commit
gdc() { gd "$1^" "$1"; }  # Diff a certain commit
gdo() { gb -d "$1" && gpu origin ":$1"; }  # Delete branch locally and remotely
compdef _git gdo=git-branch

# Git stash commands
alias ghl="git stash list"
alias ghs="git stash save -u"  # Stash (including untracked files) with message
gha() { git stash apply "stash@{$1}"; }
ghd() { git stash show "stash@{$1}"; }
ghdrop() { git stash drop "stash@{$1}"; }
ghp() { git stash pop "stash@{$1}"; }
