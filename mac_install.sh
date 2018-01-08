#!/bin/bash
export DOTFILES_DIR="$HOME/.dotfiles"

# Write symlinks to home directory

ln -sfv "$DOTFILES_DIR/.bash_profile" ~
ln -sfv "$DOTFILES_DIR/.bashrc" ~
ln -sfv "$DOTFILES_DIR/.editorconfig" ~
ln -sfv "$DOTFILES_DIR/.gitconfig" ~
ln -sfv "$DOTFILES_DIR/.gitignore_global" ~
ln -sfv "$DOTFILES_DIR/.vimrc" ~

# Install brew packages
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

# Make Mac update functions available

# Update Homebrew itself and all formulae. Then upgrade ALL your outdated, unpinned formulae
# Careful with this one! 
bbb () {
  brew update; brew upgrade; brew cleanup
}

# Finds list of recommended Mac updates, installs and reboots
# Run `softwareupdate -l` just to list available updates
update_mac () { 
  sudo sh -c "softwareupdate -ir && reboot";
}
