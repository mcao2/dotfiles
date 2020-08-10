#!/bin/bash

# Check if zsh already installed
if [ $(which zsh | wc -l) -gt 0 ]; then
    echo "zsh already installed"
else
    echo "zsh not installed"
    sudo apt-get update && sudo apt-get install -y zsh
fi
