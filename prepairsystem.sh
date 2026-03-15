#!/bin/bash

#get sudo creds and fail if not given or incorrect. 
sudo -v || { echo "sudo authentication failed, exiting."; exit 1; } 

#ask some questions. System specfics, want docker, etc. 
echo "which Version do you want to use?"
echo " 1) VM"
echo " 2) LXC"
echo "" 
read -p "Enter choice [1-2]: " choice


if [[ "$choice" == "1" ]]; then 
     read -p "Do you want to install docker in this VM? (yes or no): " answer
     if [[ "$answer" == "yes" || "$answer" == "y" ]]; then
          # Add Docker's official GPG key:
sudo apt update
sudo apt install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:
sudo tee /etc/apt/sources.list.d/docker.sources <<EOF
Types: deb
URIs: https://download.docker.com/linux/ubuntu
Suites: $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}")
Components: stable
Signed-By: /etc/apt/keyrings/docker.asc
EOF

sudo apt update
#install docker
sudo apt install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y 

sleep 2
sudo systemctl enable --now docker
sudo mkdir -p /opt/docker/
     fi

# Expand LVM to use full disk
sudo lvextend -l +100%FREE /dev/ubuntu-vg/ubuntu-lv
sudo resize2fs /dev/ubuntu-vg/ubuntu-lv

# Update the VM Ubuntu and install qemu-guest-agent & tailscale, ETC. 
sudo apt update && sudo apt upgrade -y
sudo apt install curl -y

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
#----------------------------------------------------
sudo apt remove borgbackup -y
BORG_VERSION=$(curl -s https://api.github.com/repos/borgbackup/borg/releases/latest | grep '"tag_name"' | cut -d'"' -f4)
wget https://github.com/borgbackup/borg/releases/download/${BORG_VERSION}/borg-linux-glibc231-x86_64
sudo mv borg-linux-glibc231-x86_64 /usr/local/bin/borg
sudo chmod +x /usr/local/bin/borg
echo 'export PATH="/usr/local/bin:$PATH"' >> ~/.bashrc

# Harden SSH
sudo cp ./sshd_config /etc/ssh/sshd_config
sudo systemctl daemon-reload
sudo systemctl restart ssh

echo "System prepaired for VM!! :}"
elif [[ "$choice" == "2" ]]; then

# Update the VM Ubuntu and install tailscale and what not. 
sudo apt update && sudo apt upgrade -y
sudo apt install curl -y
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
sudo systemctl enable --now ssh
echo "System prepaired for LXC!! :}"

else 
    echo "invalid choice, exiting."
    exit 1
fi

