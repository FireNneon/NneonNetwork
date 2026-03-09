#!/bin/bash

#Ask for password for sudo
sudo -v

# Update the VM Ubuntu and install qemu-guest-agent & tailscale, ETC. 
sudo apt update && sudo apt upgrade -y
# Expand LVM to use full disk
sudo lvextend -l +100%FREE /dev/ubuntu-vg/ubuntu-lv
sudo resize2fs /dev/ubuntu-vg/ubuntu-lv

sudo apt install qemu-guest-agent -y 
#----------------------------------------------------
curl -fsSL https://tailscale.com/install.sh | sudo sh
sudo systemctl enable --now tailscaled
sleep 2
sudo tailscale set --operator=$USER
#----------------------------------------------------
curl -s https://packagecloud.io/install/repositories/crowdsec/crowdsec/script.deb.sh | sudo bash
sudo apt install crowdsec -y

# Harden SSH
sudo cp ./sshd_config /etc/ssh/sshd_config
sudo systemctl restart sshd ssh ssh.socket

