#!/bin/bash
source ./distro-info.sh

harden_ssh() {
	#Harden SSH
	sudo cp /"$distro"/sshd_config /etc/ssh/sshd_config
	sudo chown root:root /etc/ssh/sshd_config && sudo chmod 644 /etc/ssh/sshd_config
	sudo systemctl daemon-reload
	sudo systemctl restart ssh
	sudo systemctl enable --now ssh
}
first_steps() {
	if [ "$distro" = rocky ]; then 
		sudo dnf update -y
		sudo dnf install curl git -y 
	elif [ "$distro" = ubuntu ]; then
		sudo apt update && sudo apt upgrade -y
		sudo apt install curl -y
	fi

	if [ "$distro" = rocky ]; then 
		sudo apt install qemu-guest-agent -y 
	elif [ "$distro" = ubuntu ]; then
		sudo dnf install qemu-guest-agent -y
	fi
	if [ "$distro" = rocky ]; then 
		sudo apt install curl -y
	elif [ "$distro" = ubuntu ]; then
		sudo dnf install curl
	fi

}

install_crowdsec() {
 	#----------------------------------------------------
 	curl -s https://install.crowdsec.net | sudo sh
 	sudo "$pk" install crowdsec -y
 	sleep 2
 	sudo systemctl enable --now crowdsec
 	#----------------------------------------------------
}

install_tailscale() {
	#----------------------------------------------------
	curl -fsSL https://tailscale.com/install.sh | sudo sh
	sudo systemctl enable --now tailscaled
	sleep 2
	#----------------------------------------------------
}

install_defaults() {
	install_crowdsec
	install_tailscale
	harden_ssh
}