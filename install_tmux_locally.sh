#!/bin/bash

# Check if tmux already installed
if [ $(tmux -V | grep "tmux 3.*" | wc -l) -gt 0 ]; then
    echo "$(tmux -V) already installed"
    exit 0
else
    echo "tmux version smaller than 3"
fi

# Install dependencies
sudo apt-get install -y git make build-essential libssl-dev libevent-dev ncurses-dev

# Installing tmux locally

rm -rf tmux_temp_installation_dir 2> /dev/null
mkdir tmux_temp_installation_dir
cd tmux_temp_installation_dir
pwd

# echo "Please visit https://github.com/tmux/tmux/releases and copy the latest stable version's .tar.gz url"
# echo Paste URL
# read tmuxurl
tmuxurl="https://github.com/tmux/tmux/releases/download/3.1b/tmux-3.1b.tar.gz"

echo "Installing tmux into your ~/.local/bin/tmux"

wget $tmuxurl -O tmux.tar.gz

rm -rf tmux_install && mkdir tmux_install
tar -zxf tmux.tar.gz -C tmux_install --strip-components=1
cd tmux_install
PKG_CONFIG_PATH=$HOME/.local/lib/pkgconfig ./configure --prefix=$HOME/.local
make && make install
cd .. && rm -rf tmux_install

cd ..

echo "Append following line to your .zshrc or .bashrc or .bash_profile file"
echo export PATH="$HOME/local/bin:\$PATH"
