### Overview
This is my first attempt at creating resuable dotfiles I can check into version control in order to copy to any new machine.  For now, it works with symlinks. I'm thinking about a better solution. 

### Setup
Do not create .bash_profile or .bashrc files in your home directory. Rather:
* `git clone` this repo into your home directory
* In your home directory, run: `ln -s .dotfiles/.bash_profile .` and `ln -s .dotfiles/.bashrc.`
* Open a new terminal tab or `source ~/.bash_profile`
* Optionally create a `.secretsrc` file in your home directory. This is to avoid version controlling any sensitive text such as API keys. 

### Dependencies
You need to have the XCode Command Line Tools installed. In OSX 10.9+, open up a terminal, type `xcode-select --install` and follow the prompts.

The script depends on OSX Homebrew. It will then detect or automatically install the below formulae:
* coreutils
* fzf
* node
* the_silver_searcher
* yarn
