#!/bin/bash
# shellcheck disable=SC2154
source ./distros/rocky/rocky-swap.sh
harden_ssh() {
	#Harden SSH
	sudo cp ./distros/"$distro"/sshd_config /etc/ssh/sshd_config
	sudo chown root:root /etc/ssh/sshd_config && sudo chmod 644 /etc/ssh/sshd_config
	sudo systemctl daemon-reload
	if [[ "$distro" = rocky ]]; then
		sudo systemctl restart sshd
		sudo systemctl enable --now sshd
	elif [[ "$distro" = ubuntu ]]; then
		sudo systemctl restart ssh
		sudo systemctl enable --now ssh
	fi
}
first_steps() {
	if [[ $distro = rocky ]]; then 
		sudo "$pk" update -y
	elif [[ "$distro" = ubuntu ]]; then
		sudo "$pk" update && sudo apt upgrade -y
	fi
	sudo "$pk" install curl git nano -y
	sudo "$pk" install qemu-guest-agent -y 
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
	sudo tailscale set --operator="$USER"
	sleep 2
	#----------------------------------------------------
	clear
	echo "------------NneonNetwork-----------------"
	read -rp "Nix: Okay I gotta stop the setup for now, I need know if you want me to setup Tailscale automatically for you or do you want todo it manually? (yes or no?): " tailscale_auto
		if [[$tailscale_auto = yes]]
			clear
			echo "------------NneonNetwork-----------------"
			echo "Nix: Okay, you want me to set it up for you, before I can do that, you need to answer some questions for me. :]: "
			echo "-----------------------------------------"
			sleep 2.1
			clear
			echo "------------NneonNetwork-----------------"
			read -rsp "Nix: Alright, First up, Please provide your pre-authkey_token from either headscale or tailscale: " ts_authkey
			clear
			echo "------------NneonNetwork-----------------"
			echo "Nix: Thank you for providing me with the token, now for the next question"
			echo "-----------------------------------------"
			sleep 2.3
			clear
			echo "------------NneonNetwork-----------------"
			read -rp "Nix: Next up, could you provide me with the address of your Tailscale or headscale control server? (https://headscale.example.com): " ts_server
			clear
			echo "------------NneonNetwork-----------------"
			echo "Nix: alright, thank you again, I'll now use the provided answers to setup tailscale for you..."
			echo "-----------------------------------------"
			sleep 2.3
			clear
			sudo tailscale up --login-server="$ts_server" --authkey="$ts_authkey"
			
		elif [[$tailscale_auto = no]]
			clear
			echo "------------NneonNetwork-----------------"
			echo "Nix: okay you want todo it manually. Continuing..."
			echo "-----------------------------------------"
		fi; 
}

install_defaults() {
	install_crowdsec
	install_tailscale
	harden_ssh
}

disable_swap (){
rocky_swap
}