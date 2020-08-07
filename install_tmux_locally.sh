#!/bin/bash

# Check if tmux already installed
if [ $(tmux -V | grep "tmux 3.*" | wc -l) -gt 0 ]; then
    echo "$(tmux -V) already installed"
    exit 0
else
    echo "tmux version smaller than 3"
fi

# Install dependencies
sudo apt-get install git make build-essential

# Installing tmux locally

# 1. visit: https://github.com/tmux/tmux
# 2. create a local directory to install tmux
# 3. download depencencies
#     1. libevent
#         1. visit: http://libevent.org/
#         2. download the stable version
#     2. ncurses
#         1. visit: http://invisible-island.net/ncurses/
#         2. download the stable version
#     3. tmux
#         1. visit: https://github.com/tmux/tmux/releases
#         2. download the stable .tar.gz
# 4. install all the dependencies first and last tmux by running following commands
#
# 	tar xvf [--file--.tar.gz]
# 	cd [---file--]
# 	./configure --prefix=$HOME/local CPPFLAGS="-P"
# 	make
# 	make install
#
# 5. `export PATH="$HOME/local/bin:$PATH"` into your bashrc file

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

echo "Installing tmux into your ~/.local/bin/tmux"

function installPackage {
    # $1 holds tar.gz
    rm -rf temp_tmux_install_lib_dir 2> /dev/null
    mkdir temp_tmux_install_lib_dir
    tar xvf $1 -C temp_tmux_install_lib_dir --strip-components=1
    cd temp_tmux_install_lib_dir
    ls
    ./configure --prefix=$HOME/local CPPFLAGS="-P"
    make -j 8
    make install
    cd ..
}

wget $libeventurl -O libevent.tar.gz
wget $ncursesurl -O ncurses.tar.gz
wget $tmuxurl -O tmux.tar.gz

echo "Installing libevent..."
installPackage libevent.tar.gz

echo "Installing ncurses..."
installPackage ncurses.tar.gz

echo "Installing tmux..."
installPackage tmux.tar.gz


echo "Append following line to your .zshrc or .bashrc or .bash_profile file"
echo export PATH="$HOME/local/bin:$PATH"
