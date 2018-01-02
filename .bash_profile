
#  Adam Barcan
#  ---------------------------------------------------------------------------
#
#  Description:  This file holds all my BASH configurations and aliases

#  The format is inspired by Nate Landau's ./bash_profile. I have also copied some of his content. 
#  https://natelandau.com/my-mac-osx-bash_profile/

#  Some content is also taken from https://github.com/agibralter/dotselfi

#  Sections:
#  1.  Environment Configuration
#  2.  Make Terminal Better 
#  3.  File and Folder Management
#  4.  Searching
#  5.  Process Management
#  6.  Networking
#  7.  System Operations & Information
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
function bbb () {
  brew update; brew upgrade; brew cleanup
}

brew_check_or_install() {
	for package in "$@"
	do
		if brew ls --versions $package > /dev/null; then 
			echo "$package is installed"
		else
			echo "Installing $package..."
			brew install $package
		fi
	done
}

brew_check_or_install coreutils fzf node the_silver_searcher yarn

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
mcd() { mkdir -p "$1" && cd "$1"; }        # mcd:          Makes new Dir and jumps inside

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

#   -------------------------------
#   3. FILE AND FOLDER MANAGEMENT
#   -------------------------------

#   extract:  Extract most know archives with one command
#   ---------------------------------------------------------
    extract () {
        if [ -f $1 ] ; then
          case $1 in
            *.tar.bz2)   tar xjf $1     ;;
            *.tar.gz)    tar xzf $1     ;;
            *.bz2)       bunzip2 $1     ;;
            *.rar)       unrar e $1     ;;
            *.gz)        gunzip $1      ;;
            *.tar)       tar xf $1      ;;
            *.tbz2)      tar xjf $1     ;;
            *.tgz)       tar xzf $1     ;;
            *.zip)       unzip $1       ;;
            *.Z)         uncompress $1  ;;
            *.7z)        7z x $1        ;;
            *)     echo "'$1' cannot be extracted via extract()" ;;
             esac
         else
             echo "'$1' is not a valid file"
         fi
    }


#   ---------------------------
#   4. Searching
#   ---------------------------

git_ff () { git co $(git branch | fzf); }    # git_ff    Pull up a scrollable dropdown of git branches
ff () { /usr/bin/find . -name "$@" | fzf; }              # ff:       Find file under the current directory
ffs () { /usr/bin/find . -name "$@"'*' | fzf; }          # ffs:      Find file whose name starts with a given string

# fuzzy grep open via ag
# See https://github.com/junegunn/fzf/wiki/examples#opening-files
open_ff() {
  local file

  file="$(ag --nobreak --noheading $@ | fzf -0 -1 | awk -F: '{print $1 " +" $2}')"

  if [[ -n $file ]]
  then
     $EDITOR $file
  fi
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

#   ---------------------------
#   6. NETWORKING
#   ---------------------------

alias my_public_ip='dig +short myip.opendns.com @resolver1.opendns.com'   # myip:   Public facing IP Address
alias my_ip='ipconfig getifaddr en0'                                      # myip:   Machine IP Address
alias net_cons='lsof -i'                                                  # net_cons:     Show all open TCP/IP sockets
alias lsock='sudo /usr/sbin/lsof -i -P'                                   # lsock:        Display open sockets
alias ip_info0='ipconfig getpacket en0'                                   # ip_info0:     Get info on connections for en0
alias ip_info1='ipconfig getpacket en1'                                   # ip_info1:     Get info on connections for en1

#   ii:  display useful host related informaton
#   -------------------------------------------------------------------
    host_info() {
        echo -e "\nYou are logged on $HOSTNAME"
        echo -e "\nAdditionnal information:$NC " ; uname -a
        echo -e "\n${RED}Users logged on:$NC " ; w -h
        echo -e "\n${RED}Current date :$NC " ; date
        echo -e "\n${RED}Machine stats :$NC " ; uptime
        echo -e "\n${RED}Current network location :$NC " ; scselect
        echo -e "\n${RED}Public facing IP Address :$NC " ; my_public_ip
    }

# Source third-party config files
test -e "$HOME/.iterm2_shell_integration.bash" && source "$HOME/.iterm2_shell_integration.bash"
