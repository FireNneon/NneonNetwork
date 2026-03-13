#!/bin/bash

#Ask for password for sudo
sudo -v

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
