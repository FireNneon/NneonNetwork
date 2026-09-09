#!/bin/bash
rocky_swap() {
	#disable swap
	sudo swapoff -a
	#remove the swap referance from fstab
	sudo sed -i.bak '/^[^#].*[[:space:]]swap[[:space:]]/ { /swapfile/!d }' /etc/fstab

	#Makeing sure no Kernals referance the old swap volume
	sudo grubby --update-kernel=ALL --remove-args="resume"
	sudo grubby --update-kernel=ALL --remove-args="rd.lvm.lv=rl/swap"

	#remove the swap volume
	sudo lvremove /dev/rl/swap -y

	clear
	currentmem=$(free -h | grep Mem)
	
	echo "------------NneonNetwork-----------------"
	echo "Nix: Before I can continue with this step Of the swapfile, I need to know what size to use...."
	echo "-----------------------------------------"
	sleep 2.0
	clear
	while true; do
		echo "------------NneonNetwork-----------------"
		echo "1) I want 1G for the size"
		echo "2) I want 2G for the size"
		echo "3) I want 3G for the size"
		echo "4) I want 8G for the size (Default)"
		echo "5) I want to tell you specifically what I want"
		echo ""
		echo "Nix: current memory: $currentmem"
		read -rp "Nix: From these options what would you like todo? 1-5: " swapoption
		swapanswer="$swapoption"

		case "$swapanswer" in
			1)
				swapSize=1G
				sleep 1.5
				;;
			2) 
				swapSize=2G
				sleep 1.5
				;;
			3) 
				swapSize=3G
				sleep 1.5
				;;
			4) 
				swapSize=8G
				sleep 1.5
				;;
			5)

				sleep 1.5
				while true; do
					clear
					echo "------------NneonNetwork-----------------"
					echo "Nix: current memory: $currentmem"
					read -rp "Nix: You decide to make your own choice, please type the size you want for the swap file?: (e.g. 4G, 512M): " typesize
					if [ -z "$typesize" ]; then
						clear
						echo "------------NneonNetwork-----------------"
						echo "Nix: Sorry I didn't catch that, please try again"
						echo "-----------------------------------------"
						continue
					fi
					swapSize="$typesize"
					break
				done
				;;
			*)
				echo "------------NneonNetwork-----------------"
				echo "Nix: Sorry I don't understand what you inputed, please try again" 
				echo "-----------------------------------------"
				clear
				sleep 1.5
				continue
				;;
		esac
		while true; do
			clear
			echo "-----------------------------------------"
			read -rp "Nix: Just to confirm, you chose '$swapSize', is this correct? (yes or no): " swapcorrect
			echo "-----------------------------------------"
			case "$swapcorrect" in
				Y | y | Yes | yes | YES)
		
					echo "------------NneonNetwork-----------------"
					echo "Nix: Thank you for confirming, now continuing." 
					echo "-----------------------------------------"
					sleep 2.1
					clear
					break 2
					;;
				N | n | No | no | NO)
					echo "------------NneonNetwork-----------------"
					echo "Nix: Sorry that I got it wrong, Lets try again..."
					echo "-----------------------------------------"
					clear
					break 1
					;;
			esac
		done
	done


	#make the swap file.
	sudo fallocate -l "$swapSize" /swapfile
	#set the the right permissions
	sudo chmod 600 /swapfile

	#activate the swap file
	sudo mkswap /swapfile
	#turn on swap
	sudo swapon /swapfile
	#Add the swap file to fstab
	echo "/swapfile none swap defaults 0 0" | sudo tee -a /etc/fstab
	#regenerate dracut
	sudo dracut -f --regenerate-all
}
