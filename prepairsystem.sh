#!/bin/bash

#get sudo creds and fail if not given or incorrect. 
sudo -v || { echo "sudo authentication failed, exiting."; exit 1; } 

echo "which Version do you want to use?"
echo " 1) VM"
echo " 2) LXC"
echo "" 
read -p "Enter choice [1-2]: " choice

if [[ "$choice" == "1" ]]; then 

# Expand LVM to use full disk
sudo lvextend -l +100%FREE /dev/ubuntu-vg/ubuntu-lv
sudo resize2fs /dev/ubuntu-vg/ubuntu-lv

# Update the VM Ubuntu and install qemu-guest-agent & tailscale, ETC. 
sudo apt update && sudo apt upgrade -y
sudo apt install curl git -y

sudo apt install qemu-guest-agent -y 
#----------------------------------------------------
curl -fsSL https://tailscale.com/install.sh | sudo sh
sudo systemctl enable --now tailscaled
sleep 2
sudo tailscale set --operator=$USER
#----------------------------------------------------
curl -s https://packagecloud.io/install/repositories/crowdsec/crowdsec/script.deb.sh | sudo bash
sudo apt install crowdsec -y
sleep 2
sudo systemctl enable --now crowdsec

# Harden SSH
sudo cp ./sshd_config /etc/ssh/sshd_config
sudo systemctl daemon-reload
sudo systemctl restart ssh

echo "System prepaired for VM!! :}"

elif [[ "$choice" == "2" ]]; then

# Update the VM Ubuntu and install tailscale and what not. 
sudo apt update && sudo apt upgrade -y
sudo apt install curl git -y
#----------------------------------------------------
curl -fsSL https://tailscale.com/install.sh | sudo sh
sudo systemctl enable --now tailscaled
sleep 2
sudo tailscale set --operator=$USER
#----------------------------------------------------
curl -s https://packagecloud.io/install/repositories/crowdsec/crowdsec/script.deb.sh | sudo bash
sudo apt install crowdsec -y
sleep 2
sudo systemctl enable --now crowdsec

# Harden SSH
sudo cp ./sshd_config /etc/ssh/sshd_config
sudo systemctl daemon-reload
sudo systemctl restart ssh
echo "System prepaired for LXC!! :}"
else 
    echo "invalid choice, exiting."
    exit 1
fi

