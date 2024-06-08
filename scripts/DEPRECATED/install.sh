#! /usr/bin/bash
LOCK_FILE=~/.installCache/dotfiles/INSTALLATION_RUNNING.lock
LOC=~/scripts

# Check if running/smth wrong
if test -f "$LOCK_FILE"; then
  echo "$LOCK_FILE exists!"
  echo
  echo "If you are sure, that no other installation is running, you can remove that file and try again."
  echo
  echo "Exiting..."
  exit
fi

# Warning
echo "EXPERIMENTAL - VERY EXPERIMENTAL" 
read -p "Enter to continue"

# Welcome
clear
echo "Welcome to the install script for my dotfiles!"
echo "As you have already been warned, this script is very experimental."
echo "This means a few things:"
echo "1. Any sorts of errors and bugs may occur"
echo "  - Please feel free to open an issue if you find any!"
echo "2. You'll get prompted to \"Press enter\" a lot"
echo "  - Once everything is more stable, this will be changed"
echo "3. Files can get left behind because I forgot to delete them"
echo "  - Every script, should delete everything uneeded after its done. \
  The main script, should in the end then delete ~/.installCache/dotfiles \
  However for debugging purposes it does not currently do that, so go check \
  there after the script is done."
echo "4. The terminology etc. could and should be improved!"
echo "5. If you don't want to continue <Ctrl-c>"
printf "\n"
echo "Logs can be found in ~/.installCache/dotfiles/log - another reason why \
  it doesnt get deleted currently."
echo "And that's all for my prelude!"
read -p "Enter to continue"

echo "Making preperations..."
mkdir ~/.installCache
echo "~/.installCache dir created"
mkdir ~/.installCache/dotfiles
echo "~/.installCache/dotfiles dir created"
cd ~/.installCache/dotfiles
mkdir log
echo "changed dir do ~/.installCache/dotfiles"
touch INSTALLATION_RUNNING.lock
echo "INSTALLATION_RUNNING.lock created"
echo "Preparations complete!"
read -p "Enter to continue"

read -p "Updating system (pacman -Syu), please press enter to continue"
sudo pacman -Syu
echo "Finished!"
read -p "Enter to continue"

# Install Pacman Packages
echo "Installing pacman packages..."
sleep 0.5
${LOC}/packages/installPacmanPackages.sh \
  >log/logPacman.txt \
  1>/dev/tty
  2>log/errorLogPacman.txt
if [ -s log/errorLogPacman.txt ]; then
  echo "Errors found!"
  echo "Content of errorLogPacman.txt:"
  cat log/errorLogPacman.txt
  read -p "Press enter if you want to continue anyway!"
  fi
echo "Installed Pacman packages!"
read -p "Enter to continue"

# enable sddm
sudo systemctl enable sddm.service
echo "Enabled sddm.service"
read -p "Enter to continue"

# install libtmux
pip install libtmux --break-system-packages

# Install Yay
echo "Installing Yay..."
chmod +x ${LOC}/packages/installYay.sh
sleep 0.5
${LOC}/packages/installYay.sh \
  >log/logYayInstall.txt \
  1>/dev/tty
  2>log/errorLogYayInstall.txt
if [ -s log/errorLogYayInstall.txt ]; then
  echo "Errors found!"
  echo "Content of errorLogYayInstall.txt:"
  cat log/errorLogYayInstall.txt
  read -p "Press enter if you want to continue anyway!"
  fi
echo "Installed Yay!"
read -p "Enter to continue"

# Install Yay packages
echo "Installing Yay packages..."
chmod +x ${LOC}/packages/installYayPackages.sh
sleep 0.5
${LOC}/packages/installYayPackages.sh \
  >log/logYayPackages.txt \
  1>/dev/tty
  2>log/errorLogYayPackages.txt
if [ -s log/errorLogYayPackages.txt ]; then
  echo "Errors found!"
  echo "Content of errorLogYayPackages.txt:"
  cat log/errorLogYayPackages.txt
  read -p "Press enter if you want to continue anyway!"
  fi
echo "Installed YayPackages!"
echo "Installing packages completed!"
read -p "Enter to continue"

echo "Now installing from GitHub repositories"
sleep 1
printf "\n"

# Install dotfiles
echo "Install main dotfiles..."
chmod +x ${LOC}/repositories/getDotfiles.sh
sleep 0.5
${LOC}/repositories/getDotfiles.sh \ 
  >log/logMain.txt \
  1>/dev/tty
  2>log/errorLogMain.txt
if [ -s log/errorLogMain.txt ]; then
  echo "Errors found!"
  echo "Content of errorLogMain.txt:"
  cat log/errorLogMain.txt
  read -p "Press enter if you want to continue anyway!"
  fi
echo "Installed main dotfiles!"
read -p "Enter to continue"

# Install other
echo "Installing other..."
chmod +x ${LOC}/repositories/getOther.sh
sleep 0.5
${LOC}/repositories/getOther.sh \ 
  >log/logOther.txt \
  1>/dev/tty
  2>log/errorLogOther.txt
if [ -s log/errorLogOther.txt ]; then
  echo "Errors found!"
  echo "Content of errorLogOther.txt:"
  cat log/errorLogOther.txt
  read -p "Press enter if you want to continue anyway!"
  fi
echo "Installed other!"
read -p "Enter to continue"

rm INSTALLATION_RUNNING.lock

echo "The script is now completed!"
echo "Maybe reboot? idk if needed, but probably not a bad idea"
read -p "Enter to reboot - <Ctrl-c> to not"
sudo reboot now
# rm -rf ~/.installCache/dotfiles
