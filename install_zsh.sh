#!/bin/bash

# Check if zsh already installed
if [ $(echo $SHELL | grep "zsh" | wc -l) -gt 0 ]; then
    echo "zsh already installed"
    exit 0
else
    echo "zsh not installed"
fi

sudo apt-get update

sudo apt-get install -y zsh

chsh -s $(which zsh)
