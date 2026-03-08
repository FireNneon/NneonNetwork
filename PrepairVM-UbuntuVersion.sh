#!/bin/bash

# Update the VM Ubuntu and install qemu-guest-agent & tailscale, ETC. 
sudo apt update && apt upgrade -y

sudo apt install qemu-guest-agent -y 
#----------------------------------------------------
curl -fsSL https://tailscale.com/install.sh | sudo sh
sudo systemctl enable --now tailscaled
sudo tailscale set --operator=$USER
#----------------------------------------------------
curl -s https://packagecloud.io/install/repositories/crowdsec/crowdsec/script.deb.sh | sudo bash
sudo apt install crowdsec -y

# Harden SSH
sudo cp ./sshd_config /etc/ssh/sshd_config
sudo systemctl restart ssh
