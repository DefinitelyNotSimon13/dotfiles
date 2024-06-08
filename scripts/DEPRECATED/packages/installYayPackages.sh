#! /usr/bin/bash

echo "Starting \"installYayPackages.sh\" script"
echo "Due to the experimental state of all the scripts, I've opted to add an increaed amount of confirmations (\"Press enter to continue\"). This will be changed (an option added to remove) later."
  
read -p "Press enter to continue"

yay -S hyprpicker
yay -S ddcci-driver-linux
yay -S catppuccin-gtk-theme-mocha 

echo "Finished \"installYayPackages.sh\" script"
read -p "Press enter to continue"
