#!/bin/bash

# Update package list and install zsh and neovim
sudo apt update && sudo apt install -y zsh neovim nodejs npm fzf

# # Clone your dotfiles repository if not already present
# if [ ! -d "$HOME/dotfiles" ]; then
#   git clone https://your-dotfiles-repo-url.git $HOME/dotfiles
# fi

# Symlink .zshrc and .bashrc to your home directory
ln -sf $HOME/dotfiles/.zshrc $HOME/.zshrc
ln -sf $HOME/dotfiles/.bashrc $HOME/.bashrc
ln -sf $HOME/dotfiles/.aliases $HOME/.aliases
ln -sf $HOME/dotfiles/.vimrc $HOME/.vimrc

# Set zsh as the default shell
chsh -s $(which zsh)

# Neovim configuration setup
mkdir -p $HOME/.config/nvim
ln -sf $HOME/dotfiles/init.vim $HOME/.config/nvim/init.vim

# Install Vundle
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

# Install plugins automatically
nvim +PluginInstall +qall

# LSP setup
gem install solargraph
sudo npm install -g typescript typescript-language-server

echo "Environment setup complete."

