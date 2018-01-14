### Overview
This is my first attempt at creating resuable dotfiles I can check into version control in order to copy to any new macOS machine.  

### Setup
* The install script will create symlinks in your `$HOME` directory for several config files. Make sure you do not already have these files in your `$HOME` directory - the script will raise an error when trying to write link.
  * `.bash_profile`
  * `.bashrc`
  * `.editorconfig`
  * `.gitconfig`
  * `.gitignore_global`
  * `.vimrc`

* `git clone` this repo into your home directory
* From anywhere, run `mac_install.sh`. This will create the symlinks and find or install several Homebrew formulae
* Open a new terminal tab or `source ~/.bash_profile`
* Optionally create a `.secretsrc` file in your home directory. This is to avoid version controlling any sensitive text such as API keys. 

### Dependencies
* XCode Command Line Tools installed. In OSX 10.9+, open up a terminal, type `xcode-select --install` and follow the prompts.
* OSX Homebrew

### Installed Formulae and Packages
The script will detect or automatically install the below Homebrew formulae:
* coreutils
* fzf
* node
* the_silver_searcher

It will also install `nvm`, set a Node version, install `yarn` and add select few global packages (for now, only `create-react-app`) 

### TODO
* ~~Install Node ecosystem, including nvm, Node version, yarn and any global packages~~
* Install rbenv and set version
* Install Sublime Text packages
* Allow script to detect and adapt to the OS; eg, it can install the appropriate package manager. 

