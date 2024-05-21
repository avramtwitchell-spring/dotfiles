#!/bin/bash

echo "Beginning setting up Dotfiles..."
# Update package list and install zsh and neovim
sudo apt update && sudo apt install -y zsh nodejs npm fzf

# Install specific version of neovim
# I'm using v0.9.5
wget -O $HOME/nvim.appimage https://github.com/neovim/neovim/releases/download/v0.9.5/nvim.appimage
chmod 755 $HOME/nvim.appimage
sudo $HOME/nvim.appimage --appimage-extract
sudo mv ./squashfs-root $HOME/nvim
sudo ln $HOME/nvim/usr/bin/nvim /usr/bin/nvim

# asdf
git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.14.0

# Symlink various dotfiles to home directory
export DOTFILES=/workspaces/.codespaces/.persistedshare/dotfiles
ln -sf $DOTFILES/.zshrc $HOME/.zshrc
ln -sf $DOTFILES/.bashrc $HOME/.bashrc
ln -sf $DOTFILES/.aliases $HOME/.aliases
ln -sf $DOTFILES/.work_rc $HOME/.work_rc
ln -sf $DOTFILES/.vimrc $HOME/.vimrc
ln -sf $DOTFILES/.p10k.zsh $HOME/.p10k.zsh

## Neovim configuration setup
mkdir -p $HOME/.config/nvim
ln -sf $DOTFILES/init.vim $HOME/.config/nvim/init.vim

# Set zsh as the default shell
sudo chsh "$(id -un)" --shell "/usr/bin/zsh"

# Install Vundle
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

# Install plugins automatically
nvim --headless +PluginInstall +qall

# LSP setup
gem install solargraph
sudo npm install -g typescript typescript-language-server

echo "export VIMRUNTIME=$HOME/nvim/usr/share/nvim/runtime" >> ~/.zshrc

echo "Dotfile setup complete."
