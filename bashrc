# Extend PATH
export PATH="~/.local/bin:$PATH"

# Git prompt
. /usr/share/git/git-prompt.sh
GIT_PS1_DESCRIBE_STYLE='contains'
GIT_PS1_SHOWCOLORHINTS='y'
GIT_PS1_SHOWDIRTYSTATE='y'
GIT_PS1_SHOWSTASHSTATE='y'
GIT_PS1_SHOWUNTRACKEDFILES='y'
GIT_PS1_SHOWUPSTREAM='auto'

# Colored prompt
PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[01;33m\]$(__git_ps1)\[\033[34m\] \$\[\033[00m\] '

# Handy aliases
alias ls='ls --color=auto'
alias ll='ls --color=auto -la'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias pacman='sudo pacman --color=auto'
alias update='sudo pacman --color=auto -Syyu'

# Make pretty

neofetch

