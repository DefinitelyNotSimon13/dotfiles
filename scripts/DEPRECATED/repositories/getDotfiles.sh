#! /usr/bin/bash

echo "Starting \"getDotfiles.sh\" script"
echo "Due to the experimental state of all the scripts, I've opted to add an increaed amount of confirmations (\"Press enter to continue\"). This will be changed (an option added to remove) later."
  
read -p "Are you sure? This script will remove all existing config files that clash with new configs! (nvim, hypr, waybar, etc...)" -n 1 -r
rm -rf ~/.installCache/dotfiles/main>/dev/null 2>&1
echo "Cleared ~/.installCache/dotfiles/main if it existed"
mkdir ~/.installCache/dotfiles/main>/dev/null 2>&1
echo "Created ~/.installCache/dotfiles/main"
cd ~/.installCache/dotfiles/main
echo "Cloning git repo..."
git clone --recurse-submodules "https://github.com/DefinitelyNotSimon13/Catppuccin-Dotfiles.git"
echo "Git repo cloned!"
read -p "Press enter to continue"
# Backup all files that'll be deleted
mkdir ~/.backup >/dev/null 2>&1
echo "Created ~/.backup if it didn't exist before"
read -p "Press enter to continue"
tar -zcvf ~/.backup/configBackup.tar.gz \
  ~/.config/hypr \
  ~/.config/waybar \
  ~/.config/dunst \
  ~/.config/alacritty \
  ~/.config/kitty \
  ~/.config/neofetch \
  ~/.config/nvim \
  ~/.config/rofi \
  ~/.config/tmux \
  ~/.zsh \
  ~/.zshrc \
  ~/.p10k.zsh \
  >/dev/null 2>&1
echo "Created backup of all files that will be deleted."
read -p "Press enter to continue"
# Remove existing configs
rm -r ~/.config/hypr >/dev/null 2>&1
rm -r ~/.config/waybar>/dev/null 2>&1
rm -r ~/.config/dunst>/dev/null 2>&1
rm -r ~/.config/alacritty>/dev/null 2>&1
rm -r ~/.config/kitty>/dev/null 2>&1
rm -r ~/.config/neofetch>/dev/null 2>&1
rm -r ~/.config/nvim>/dev/null 2>&1
rm -r ~/.config/rofi>/dev/null 2>&1
rm -r ~/.config/tmux>/dev/null 2>&1
rm -r ~/.zsh/>/dev/null 2>&1
rm ~/.zshrc>/dev/null 2>&1
rm .p10k.zsh>/dev/null 2>&1
echo "Removed existing configs!"
read -p "Press enter to continue"
# Finally move new files

cp Catppuccin-Dotfiles/.* ~ -r -f
cp Catppuccin-Dotfiles/* ~ -r -f
echo "Moved files from repository."
echo "Main repository installation complete"

echo "\"getDotfiles.sh\" script completed."
read -p "Press enter to continue"
