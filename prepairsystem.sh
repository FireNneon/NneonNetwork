#!/bin/bash
#get sudo creds and fail if not given or incorrect. 
sudo -v || { echo "sudo authentication failed, exiting."; exit 1; } 

first_steps() {
	sudo apt update && sudo apt upgrade -y
	sudo apt install curl -y
}

disable_swap() {
	# Disable swap
	sudo swapoff -a
	sudo rm -f /swap.img
	sudo sed -i '/swap/s/^/#/' /etc/fstab
}

debloat_ubuntu() {
	# Stop multipathd and its socket first
	sudo systemctl stop multipathd multipathd.socket

	# Then disable everything
	sudo systemctl disable --now ModemManager multipathd multipathd.socket udisks2 upower

	# Remove unnecessary packages
	sudo apt remove -y modemmanager
	sudo apt autoremove -y
}

harden_ssh() {
	#Harden SSH
	sudo cp ./sshd_config /etc/ssh/sshd_config
	sudo systemctl daemon-reload
	sudo systemctl restart ssh
	sudo systemctl enable --now ssh
}

install_docker() {
	# Add Docker's official GPG key:
    sudo apt install ca-certificates
    sudo install -m 0755 -d /etc/apt/keyrings
    sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
    sudo chmod a+r /etc/apt/keyrings/docker.asc

    # Add the repository to Apt sources:
    sudo tee /etc/apt/sources.list.d/docker.sources <<-EOF
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
}

install_crowdsec() {
 	#----------------------------------------------------
 	curl -s https://packagecloud.io/install/repositories/crowdsec/crowdsec/script.deb.sh | sudo bash
 	sudo apt install crowdsec -y
 	sleep 2
 	sudo systemctl enable --now crowdsec
 	#----------------------------------------------------
}

install_tailscale() {
	#----------------------------------------------------
	curl -fsSL https://tailscale.com/install.sh | sudo sh
	sudo systemctl enable --now tailscaled
	sleep 2
	sudo tailscale set --operator="$USER"
	#----------------------------------------------------
}

install_borg() {
	#----------------------------------------------------
	sudo apt remove borgbackup -y 2>/dev/null
	BORG_VERSION=$(curl -s https://api.github.com/repos/borgbackup/borg/releases/latest | grep '"tag_name"' | cut -d'"' -f4)
	wget https://github.com/borgbackup/borg/releases/download/"${BORG_VERSION}"/borg-linux-glibc231-x86_64
	sudo mv borg-linux-glibc231-x86_64 /usr/local/bin/borg
	sudo chmod +x /usr/local/bin/borg
	echo 'export PATH="/usr/local/bin:$PATH"' >> ~/.bashrc
	#----------------------------------------------------
}

install_defaults() {
	debloat_ubuntu
	install_crowdsec
	install_tailscale
	harden_ssh
}

VM_Specfics () {
	# Expand LVM to use full disk
	sudo lvextend -l +100%FREE /dev/ubuntu-vg/ubuntu-lv

	sudo resize2fs /dev/ubuntu-vg/ubuntu-lv

	#install qemu-guest-agent, tailscale, etc. 

	sudo apt install qemu-guest-agent -y 
}
#--------------------------------------------------
#DEV Saved commands

#--------------------------------------------------

echo "What do you want todo with this system?"
echo " 1) Only Debloat system"
echo " 2) Prepare system?"
echo ""
read -rp "Enter choice [1-2] (type anything to cancel whole script): " doingtype
sleep 4
read -rp "What type of system is this, LXC or VM?: " systemtype
sleep 2

case "$doingtype" in 

	1)
		if [[ "$systemtype" == "VM" ]]; then
			debloat_ubuntu
			disable_swap
		elif [[ "$systemtype" == "LXC" ]]; then
			debloat_ubuntu
		else
			clear
			echo "Canceling whole script..."
			exit 1
		fi
		;;

	2)
		case "$systemtype" in
		#VM
		1) 
			read -rp "Do you want this VM stripped? (Yes|yes|Y|y or No|no|N|n)" stripped #doesn't install docker, borg, crowdsec, and removes bloatware
			case "$stripped" in
			Yes|yes|Y|y)
							VM_Specfics
							debloat_ubuntu
							disable_swap
							install_tailscale
							;;
			No|no|N|n)
				
						#asking if you want to install some extra bits. 
						echo "Extras: What do you want to install with the defaults?"
						echo " 1) Just Docker." #install just docker with the defaults
						echo " 2) Just borgbackups. " #install just borgBackups
						echo " 3) ALL)" #install all options listed. 
						echo " 4) no extras" #no extra bits just the defaults will be installed. 
						echo ""
						read -rp "Enter Choice (1-5) (type anything to cancel whole script): " extras
					case "$extras" in 

					1)
						first_steps
						install_docker
						;;
					2) 
						first_steps
						install_borg
						;;
					3)
						first_steps
						install_docker
						sleep 3
						install_borg
						;;
					4)
						echo "No extras selected."
						sleep 3
						first_steps
						;;
					*)
						clear
						echo "Canceling whole script..."
						exit 1
						;;
					esac
					sleep 2
					VM_Specfics
					sleep 2
					install_defaults
					disable_swap
					clear
					echo "System prepaired for VM!! :}"
					sleep 4
					;;
			esac
			;;
    	#LXC
		2) 
			# Update the VM Ubuntu and install tailscale, Crowdsec, and remove bloatware. 
			first_steps
			#----------------------------------------------------
			install_defaults
			clear
			echo "System prepaired for LXC!! :}"
			sleep 4
			;;
    	*)
			clear
			echo "Canceling whole script..."
			sleep 3
			exit 1
			;;
		esac
		;;
	*)
		clear
		echo "Canceling whole script..."
		exit 1
		;;
esac
