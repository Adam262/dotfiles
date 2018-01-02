
#  Adam Barcan
#  ---------------------------------------------------------------------------
#
#  Description:  This file holds all my BASH configurations and aliases

#	 The format is inspired by Nate Landau's ./bash_profile. I have also copied some of his content. 
#  https://natelandau.com/my-mac-osx-bash_profile/

#  Some content is also taken from https://github.com/agibralter/dotselfi

#  Sections:
#  1.  Environment Configuration
#  2.  Make Terminal Better (remapping defaults and adding functionality)
#  3.  File and Folder Management
#  4.  Searching
#  5.  Process Management
#  6.  Networking
#  7.  System Operations & Information
#  8.  Web Development
#  9.  Reminders & Notes
#
#  ---------------------------------------------------------------------------

#   -------------------------------
#   1. ENVIRONMENT CONFIGURATION
#   -------------------------------

#   Source own config files (source third-party config files at end of bash profile)
test -e "$HOME/.bashrc" && source "$HOME/.bashrc"
#   Store secrets locally so this .bash_profile can be version tracked
test -e "$HOME/.secretsrc" && source "$HOME/.secretsrc"

#   Set paths
export PATH="/usr/local/opt/icu4c/bin:/usr/local/opt/icu4c/sbin:$PATH"
export PATH="$PATH:`yarn global bin`"
export NVM_DIR="$HOME/.nvm"

#   Set default editors
export EDITOR="vim"
export GIT_EDITOR='vim'
export GEMEDITOR="vim"

#   Install Brew dependencies
if brew ls --versions coreutils > /dev/null; then 
	echo 'coreutils is installed'
else
	echo 'Installing coreutils...'
	brew install coreutils
fi

#   -----------------------------
#   2. MAKE TERMINAL BETTER
#   -----------------------------

#   Shell builtins
alias ~="cd ~"                              # ~:            Go Home
alias ..="cd ~"                              # ..:           Go back 1 directory level
alias ..="cd ../"
cd() { builtin cd "$@"; ll; }               # Always list directory contents upon 'cd'

alias cp='cp -iv'                           # Preferred 'cp' implementation
alias mv='mv -iv'                           # Preferred 'mv' implementation
alias rm='rm -iv'                           # Preferred 'rm' implementation
alias mkdir='mkdir -pv'                     # Preferred 'mkdir' implementation
mcd () { mkdir -p "$1" && cd "$1"; }        # mcd:          Makes new Dir and jumps inside

alias la='ls -a'
alias ls='ls -GF'
alias ll='ls -FGlAhp'                       # Preferred 'ls' implementation

alias less='less -FSRXc'                    # Preferred 'less' implementation

alias sizes="du -hs * | gsort -hr"          # Depends on GNU Coreutils for `gsort`

alias which='type -all'                     # which:        Find executables
alias cic='set completion-ignore-case On'   # cic:          Make tab-completion case-insensitive

alias c='clear'                             # c:            Clear terminal display
alias fix_stty='stty sane'                  # fix_stty:     Restore terminal settings when screwed up
trash () { command mv "$@" ~/.Trash ; }     # trash:        Moves a file to the MacOS trash

alias path='echo -e ${PATH//:/\\n}'         # path:         Echo all executable Paths
alias show_options='shopt'                  # Show_options: display bash options settings

alias f='open -a Finder ./'                 # f:            Opens current directory in MacOS Finder
ql () { qlmanage -p "$*" >& /dev/null; }    # ql:           Opens any file in MacOS Quicklook Preview
alias DT='tee ~/Desktop/terminalOut.txt'    # DT:           Pipe content to file on MacOS Desktop

#   Bash prompt
parse_git_branch() {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}
export PS1="\u@\h \[\033[32m\]\w\[\033[33m\]\$(parse_git_branch)\[\033[00m\] $ "


# Rails
alias be="bundle exec"

#   ---------------------------
#   4. Searching
#   ---------------------------

git_ff() { 
  if [ -s `which fzf` ]; then git co `git branch | fzf`; fi 
}

#   ---------------------------
#   5. PROCESS MANAGEMENT
#   ---------------------------

#   mem_hogs:  Find memory hogs
#   -----------------------------------------------------
alias mem_hogs='top -l 1 -o rsize | head -20 | less'

#   cpu_hogs:  Find CPU hogs
#   -----------------------------------------------------
alias cpu_hogs='ps wwaxr -o pid,stat,%cpu,time,command | head -10 | less'

#   ttop:  Recommended 'top' invocation to minimize resources
alias ttop="top -R -F -s 10 -o rsize | less"

#   my_ps: List processes owned by my user:
#   ------------------------------------------------------------
my_ps() { ps $@ -u $USER -o pid,%cpu,%mem,start,time,bsdtime,command ; }

# Source third-party config files
test -e "$HOME/.iterm2_shell_integration.bash" && source "$HOME/.iterm2_shell_integration.bash"
