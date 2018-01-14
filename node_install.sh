#!/bin/bash
export NVM_DIR="$HOME/.nvm"
export YARN_DIR="$HOME/.yarn"
export NVM_VERSION='v0.33.8'
export NODE_VERSION=9
 
# Install nvm 
if test -d "$NVM_DIR" > /dev/null; then 
  echo "nvm is installed"
else
  echo "Installing nvm..."
  curl -o- "https://raw.githubusercontent.com/creationix/nvm/$NVM_VERSION/install.sh" | bash
fi

[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Install Node
nvm install $NODE_VERSION
nvm alias default $NODE_VERSION

# Install yarn
if test -d "$YARN_DIR" > /dev/null; then 
  echo "yarn is installed"
else
  echo "Installing yarn..."
  curl -o- -L https://yarnpkg.com/install.sh | bash
fi

# Globally install packages
yarn global add create-react-app --prefix /usr/local
