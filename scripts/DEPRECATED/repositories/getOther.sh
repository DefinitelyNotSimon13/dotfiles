#! /usr/bin/bash

echo "Starting \"getOther.sh\" script"
echo "Due to the experimental state of all the scripts, I've opted to add an increaed amount of confirmations (\"Press enter to continue\"). This will be changed (an option added to remove) later."
read -p "Press enter to continue"

echo "Making preparations..."
rm -rf ~/.installCache/dotfiles/other
echo "Cleared ~/.installCache/other if it existed"
mkdir ~/.installCache
echo "Created ~/.installCache if it didnt exist before"
mkdir ~/.installCache/dotfiles
echo "Created ~/.installCache/dotfiles if it didnt exist before"
mkdir ~/.installCache/dotfiles/other
echo "Created ~/.installCache/dotfiles/other if it didnt exist before"
cd ~/.installCache/dotfiles/other
read -p "Press enter to continue"

# Catpuccin qt5 theme -worked the first time at least
echo "Installing Catppuccin Qt5 theme..."
git clone "https://github.com/catppuccin/qt5ct.git"
mkdir ~/.config/qt5ct
mkdir ~/.config/qt5ct/colors
mv qt5ct/themes/Catppuccin-Mocha.conf ~/.config/qt5ct/colors/ -f
echo "The script will continue once you close qt5ct"
echo "This wont work if you are installing first time with no window manager or so, so do later"
read -p "Please set the theme in qt5ct - if it isnt there, thats an issue lol - Press enter to open qt5ct!"
qt5ct
rm -rf qt5ct
echo "Installed Catppuccin Qt5 theme!"
read -p "Press enter to continue"

# catppuccin cursor (mocha dark)
echo "Installing Catppuccin-Mocha-Dark-Cursors..."
git clone https://github.com/catppuccin/cursors.git
unzip cursors/cursors/Catppuccin-Mocha-Dark-Cursors.zip
sudo cp Catppuccin-Mocha-Dark-Cursors ~/.icons -r 
sudo cp Catppuccin-Mocha-Dark-Cursors /usr/share/icons -r 
rm -rf cursors
rm -rf Catppuccin-Mocha-Dark-Cursors
echo "Installed Catppuccin-Mocha-Dark-Cursors!"
read -p "Press enter to continue"

# catppuccin grub theme
echo "Installing Catppuccin grub theme..."
git clone https://github.com/catppuccin/grub.git
sudo cp -r grub/src/* /usr/share/grub/themes/
rm -rf grub
echo "Added theme to grub!"
echo "You will now need to edit the grub config!"
echo "nvim will open automatically, please uncomment and edit the following line:"
echo "GRUB_THEME=\"/usr/share/grub/themes/catppuccin-mocha-grub-theme/theme.txt\""
sleep 0.5
echo "If you have antoher operating such as window running, please also find and add/edit the following line:"
echo "GRUB_DISABLE_OS_PROBER=false"
echo "Note: Some further configuration may be necessary to have grub appear before windows."
sleep 0.5
echo "Opening nvim..."
sudo nvim /etc/default/grub
read -p "Press enter to continue!"
sudo grub-mkconfig -o /boot/grub/grub.cfg
sudo grub-mkconfig -o /boot/efi/EFI/arch/grub.cfg
echo "Grub config has been outputted to \"/boot/grub/grub.cfg\""
echo "If you need the config somewhere else, please manually run"
echo "\"sudo grub-mkconfig -o [path/to/grub.cfg]\""
printf "\n"
echo "Catppuccin grub theme installed!"
read -p "Press enter to continue"

# catppuccin sddm theme
echo "Installing Catppuccin sddm theme..."
echo "Making sure depencies are intsalled..."
pacman -Syu qt5-graphicaleffects qt5-svg qt5-quickcontrols2
git clone https://github.com/catppuccin/sddm.git
sudo cp sddm/src/catppuccin-mocha /usr/share/sddm/themes/ -r 
echo "The config file will need to be edited as well!"
echo "nvim will open automatically, please add the following two lines to the file:"
echo "[Theme]"
echo "Current=catppuccin-flavour"
sleep 0.5
read -p "Press enter to continue!"
sudo nvim /etc/sddm.conf
echo "Catppuccin sddm theme installed!"
read -p "Press enter to continue"

# Git Credential Manager
echo "Installing Git-credential-manager..."
curl -L https://aka.ms/gcm/linux-install-source.sh | sh
git-credential-manager configure
git config -- credential.credentialStore cache
echo "Cache has been automatically been set as credential store."
echo "To change that run \"git config --global credential.credentialStore [option]\""
echo "Git-credential-manager installed!"
read -p "Press enter to continue"

# Oh my zsh
echo "Installing oh-my-zsh..."
curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh
echo "Installed oh-my-zsh!"
read -p "Press enter to continue"

# powerlevel10k zsh theme
echo "Installing powerlevel10k theme for oh-my-zsh"
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
echo "Installed powerlevel10k theme"
read -p "Press enter to continue"

# zsh-autosuggenstions
echo "Installing zsh-autosuggenstions..."
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
echo "Installed zsh-autosuggenstions!"
read -p "Press enter to continue"

# zsh-syntax-highlighting
echo "Installing zsh-syntax-highlighting..."
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
echo "Installed zsh-syntax-highlighting!"
read -p "Press enter to continue"

# Catppuccin zsh-syntax-highlighting theme
echo "Installing Catppuccin zsh-syntax-highlighting theme..."
git clone https://github.com/catppuccin/zsh-syntax-highlighting.git
cp -v zsh-syntax-highlighting/theme/catppuccin_mocha-zsh-syntax-highlighting.zsh ~/.zsh/
echo "Installed Catppuccin zsh-syntax-highlighting theme!"
read -p "Press enter to continue"

# tmux tpm
echo "Installing tmux tpm..."
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
echo "You'll need to install the plugins later! <Leader+I>"
echo "Installed tmux tpm!"
read -p "Press enter to continue"

echo "\"getOther.sh\" script complete"
read -p "Press enter to continue"
