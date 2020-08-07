#!/bin/bash

# Check if tmux already installed
if [ $(tmux -V | grep "tmux 3.*" | wc -l) -gt 0 ]; then
    echo "$(tmux -V) already installed"
    exit 0
else
    echo "tmux version smaller than 3"
fi

# Install dependencies
sudo apt-get install git make build-essential libssl-dev

# Installing tmux locally

rm -rf tmux_temp_installation_dir 2> /dev/null
mkdir tmux_temp_installation_dir
cd tmux_temp_installation_dir
pwd

# echo "Please visit http://libevent.org/ and copy the latest stable version's .tar.gz url"
# echo "Paste URL"
# read libeventurl
libeventurl="https://github.com/libevent/libevent/releases/download/release-2.1.12-stable/libevent-2.1.12-stable.tar.gz"

# echo "Please visit http://invisible-island.net/ncurses/ and copy the latest stable version's .tar.gz url"
# echo "Paste URL"
# read ncursesurl
ncursesurl="https://invisible-island.net/datafiles/release/ncurses.tar.gz"

# echo "Please visit https://github.com/tmux/tmux/releases and copy the latest stable version's .tar.gz url"
# echo Paste URL
# read tmuxurl
tmuxurl="https://github.com/tmux/tmux/releases/download/3.1b/tmux-3.1b.tar.gz"

echo "Installing tmux into your ~/local/bin/tmux"

wget $libeventurl -O libevent.tar.gz
wget $ncursesurl -O ncurses.tar.gz
wget $tmuxurl -O tmux.tar.gz

echo "Installing libevent..."
rm -rf libevent_install && mkdir libevent_install
tar -zxf libevent.tar.gz -C libevent_install --strip-components=1
cd libevent_install
./configure --prefix=$HOME/local --enable-shared
make && make install
cd .. && rm -rf libevent_install

echo "Installing ncurses..."
rm -rf ncurses_install && mkdir ncurses_install
tar -zxf ncurses.tar.gz -C ncurses_install --strip-components=1
cd ncurses_install
./configure --prefix=$HOME/local --with-shared --with-termlib --enable-pc-files --with-pkg-config-libdir=$HOME/local/lib/pkgconfig
make && make install
cd .. && rm -rf ncurses_install

echo "Installing tmux..."
rm -rf tmux_install && mkdir tmux_install
tar -zxf tmux.tar.gz -C tmux_install --strip-components=1
cd tmux_install
PKG_CONFIG_PATH=$HOME/local/lib/pkgconfig ./configure --prefix=$HOME/local
make && make install
cd .. && rm -rf tmux_install

cd ..

echo "Append following line to your .zshrc or .bashrc or .bash_profile file"
echo export PATH="$HOME/local/bin:\$PATH"
