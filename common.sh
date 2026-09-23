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
		sudo "$pk" update && sudo "$pk" upgrade -y
	fi
	sudo "$pk" install curl git nano -y

	if [[ $systemtype = VM ]]; then 
		sudo "$pk" install qemu-guest-agent -y
	elif [[ $systemtype = LXC ]]; then
		sudo dnf install nano git openssh-server chrony policycoreutils-python-utils curl
	fi
}

autoremove(){
	if [[ $distro = rocky ]]; then 
		sudo "$pk" autoremove -y
	elif [[ "$distro" = ubuntu ]]; then
		sudo "$pk" autoremove
	fi
}

install_crowdsec() {
 	#----------------------------------------------------
 	curl -s https://install.crowdsec.net | sudo sh
 	sudo "$pk" install crowdsec -y
 	sleep 2
 	sudo systemctl enable --now crowdsec
	sleep 2.5
	
	
	sudo cscli setup detect | sudo tee /tmp/crowdsecdetection.txt > /dev/null
	sleep 1.5
	
	sudo cscli setup cscli setup install-acquisition /tmp/crowdsecdetection.txt
	sleep 1.5
	
	cscli setup install-hub /tmp/crowdsecdetection.txt
	sleep 1.5
	
	sudo dnf install -y crowdsec-firewall-bouncer-iptables
	sudo systemctl enable --now crowdsec-firewall-bouncer
	sudo systemctl daemon-reload
	sleep 2.5
	sudo systemctl restart crowdsec
	sleep 2.5
	machineid=$(sudo journalctl -u crowdsec | awk '/machine/ {for (i=1; i<=NF; i++) if ($i == "machine") print $(i+1)}' | awk 'NR == 1 {print}')
	sleep 2.0
	clear
	echo "------------NneonNetwork-----------------"
	read -rp "Nix: Okay I gotta stop the setup for now, I need you to use $machineid to validate this crowdsec instance, go to your main crowdsec machine and validate it, I'll wait :] (press to continue)"	
	sleep 2.3
	clear
}

install_tailscale() {
	echo "------------NneonNetwork-----------------"
	read -rp "Nix: Okay I gotta stop the setup for now, I need know if you want me to setup Tailscale automatically for you or do you want todo it manually? once I know this I'll install tailscale client either way. (yes or no?): " tailscale_auto
	case "$tailscale_auto" in
		Yes | yes | y)
			
			clear
			echo "------------NneonNetwork-----------------"
			echo "Nix: Okay, you want me to set it up for you, before I can do that, you need to answer some questions for me. :]"
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
			read -rp "Nix: alright, thank you again, I'll now use the provided answers to setup tailscale for you... but to confirm you still want me to do it automaically for you? (Yes or No): " tailconfirm
			echo "-----------------------------------------"
			clear
			sleep 2.3
			if [[ $tailconfirm = Yes ]]; then 
				echo "------------NneonNetwork-----------------"
				echo "Nix: Okay, You decided you want me set it up still, I'll continue install tailscale and set it up for you. :}"
				echo "-----------------------------------------"
				sleep 2.4
			elif [[ "$tailconfirm" = No ]]; then
				echo "------------NneonNetwork-----------------"
				echo "Nix: Okay, You decided you want to set it up manually instead, I'll continue install tailscale and you can do that. :}"
				echo "-----------------------------------------"
				sleep 2.4
			fi
			clear
			#----------------------------------------------------
			curl -fsSL https://tailscale.com/install.sh | sudo sh
			sudo systemctl enable --now tailscaled
			sudo tailscale set --operator="$USER"
			sleep 2
			#----------------------------------------------------
			
			if [[ $tailconfirm = Yes ]]; then 
				sudo tailscale up --login-server="$ts_server" --authkey="$ts_authkey"
			fi
			
			sleep 2.3
			clear
			;;
		No | no | n)
			
			clear
			echo "------------NneonNetwork-----------------"
			echo "Nix: okay you want todo it manually. Continuing..."
			echo "-----------------------------------------"
			sleep 2.0
			clear
			echo "------------NneonNetwork-----------------"
			echo "Nix: Do note, manual will break SSHD service. delete or edit SSH override file to fix, the ExecStartPre line is the conflicting factor, sense it requires tailscale to be connected and running. Possibly docker override file as well needs editing..."
			echo "-----------------------------------------"
			sleep 3.2
			clear
			#----------------------------------------------------
			curl -fsSL https://tailscale.com/install.sh | sudo sh
			sudo systemctl enable --now tailscaled
			sudo tailscale set --operator="$USER"
			sleep 2
			#---------------------------------------------------
			sleep 2.3
			clear
			;;
		*)
			echo "------------NneonNetwork-----------------"
			echo "Nix: Sadly I don't understand..., I'll just default to Manual and continue the script since we are so close to done...."
			echo "-----------------------------------------"
			sleep 2.3
			clear
			#----------------------------------------------------
			curl -fsSL https://tailscale.com/install.sh | sudo sh
			sudo systemctl enable --now tailscaled
			sudo tailscale set --operator="$USER"
			sleep 2
			#----------------------------------------------------
			;;
	esac
}

install_defaults() {
	install_tailscale
	install_crowdsec
	harden_ssh
}

disable_swap (){
	rocky_swap
}