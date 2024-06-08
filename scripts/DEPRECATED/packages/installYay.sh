#! /usr/bin/bash
echo "Starting \"installYay.sh\" script"
echo "Due to the experimental state of all the scripts, I've opted to add an increaed amount of confirmations (\"Press enter to continue\"). This will be changed (an option added to remove) later."
  
read -p "Press enter to continue"

rm -rf ~/.installCache/dotfiles/yay
mkdir ~/.installCache/dotfiles/yay
mkdir ~/.installCache/dotfiles/log >/dev/null 2>&1
cd ~/.installCache/dotfiles/yay
git clone https://aur.archlinux.org/yay.git \
  >../log/logYayInstall.txt \
  2>../log/errorLogYayInstall.txt
cd yay
makepkg -si
printf "Finished installing yay!\n\n"
read -p "Press enter to continue"
echo "Setting up yay..."
yay -Y --gendb \
  >../log/logYayInstall.txt
  2>../log/errorLogYayInstall.txt
yay -Syu --devel \
  >../log/logYayInstall.txt
  2>../log/errorLogYayInstall.txt
printf "Finished setting up yay!\n"
#rm -r ~/.installCache/dotfiles/yay
echo "\"installYay.sh\" script completed."
read -p "Press enter to continue"
