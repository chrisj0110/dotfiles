#!/bin/sh

ln -s ~/dotfiles/.zshrc ~/.zshrc

brew install eza fzf go joshmedeski/sesh/sesh lazygit ripgrep zoxide
brew install --cask maccy

$(brew --prefix)/opt/fzf/install

git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions

mkdir ~/.config
ln -s ~/dotfiles/nvim ~/.config/nvim

mkdir -p ~/.config/zsh-syntax-highlighting/themes
curl -L https://raw.githubusercontent.com/catppuccin/zsh-syntax-highlighting/main/themes/catppuccin_mocha-zsh-syntax-highlighting.zsh \
  -o ~/.config/zsh-syntax-highlighting/themes/catppuccin_mocha-zsh-syntax-highlighting.zsh
ln -s ~/.config/zsh-syntax-highlighting/themes/catppuccin_mocha-zsh-syntax-highlighting.zsh ~/.zsh/catppuccin_mocha-zsh-syntax-highlighting.zsh

brew install starship
ln -s ~/dotfiles/starship.toml ~/.config/starship.toml

mkdir -p ~/Library/Application\ Support/com.mitchellh.ghostty/
mv ~/Library/Application\ Support/com.mitchellh.ghostty/config{,-bak}
ln -s ~/dotfiles/ghosty_config.toml ~/Library/Application\ Support/com.mitchellh.ghostty/config

brew install tmux
mkdir -p ~/.config/tmux/
# ln -s ~/dotfiles/tmux.conf ~/.tmux.conf
ln -s ~/dotfiles/tmux.conf ~/.config/tmux/tmux.conf

mkdir -p ~/.config/sesh
ln -s ~/dotfiles/sesh.toml ~/.config/sesh/sesh.toml

mkdir -p ~/.config/lazygit/
echo "showCommandLog: false" > ~/.config/lazygit/config.yml

mkdir -p ~/.config/tmux/plugins/catppuccin
git clone -b v2.1.3 https://github.com/catppuccin/tmux.git ~/.config/tmux/plugins/catppuccin/tmux

git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# not sure if this actually works:
git clone https://github.com/eza-community/eza-themes.git
mkdir -p ~/.config/eza
ln -sf "$(pwd)/eza-themes/themes/catppuccin.yml" ~/.config/eza/theme.yml

# setup hammerspoon: https://www.hammerspoon.org/go/
# then:
# ln -s ~/dotfiles/hammerspoon_init.lua ~/.hammerspoon/init.lua
