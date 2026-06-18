#!/bin/bash
 







#--------------------------------------------------
#DEV Saved commands

#--------------------------------------------------

echo "What do you want todo with this system?"
echo " 1) Only Debloat system"
echo " 2) Prepare system?"
echo ""
read -rp "Enter choice [1-2] (type anything to cancel whole script): " doingtype
sleep 2
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
			echo "Invalid input, Canceling whole script..."
			exit 1
		fi
		;;

	2)
		case "$systemtype" in
		#VM
		VM) 
			read -rp "Do you want this VM stripped? (Yes|yes|Y|y or No|no|N|n) " stripped #doesn't install docker, borg, crowdsec, and removes bloatware
			sleep 2
			case "$stripped" in
			Yes|yes|Y|y)
							first_steps
							VM_Specifics
							debloat_ubuntu
							disable_swap
							install_tailscale
							harden_ssh
							;;
			No|no|N|n)
				
						#asking if you want to install some extra bits. 
						echo "Extras: What do you want to install with the defaults?"
						echo " 1) Just Docker." #install just docker with the defaults
						echo " 2) Just borgbackups. " #install just borgBackups
						echo " 3) ALL)" #install all options listed. 
						echo " 4) no extras" #no extra bits just the defaults will be installed. 
						echo ""
						read -rp "Enter Choice (1-4) (type anything to cancel whole script): " extras
						sleep 2
						
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
						sleep 2
						install_borg
						;;
					4)
						echo "No extras selected."
						sleep 2
						first_steps
						;;
					*)
						clear
						echo "Invalid input, Canceling whole script..."
						sleep 2
						exit 1
						;;
					esac
					sleep 2
					VM_Specifics
					sleep 2
					install_defaults
					disable_swap
					clear
					echo "System prepaired for VM!! :}"
					sleep 3
					;;
			*)
				clear
				echo "Invalid input, Canceling whole script..."
				exit 1
				;;

			esac
			;;
		#LXC
		LXC) 
			# Update the VM Ubuntu and install tailscale, Crowdsec, and remove bloatware. 
			first_steps
			#----------------------------------------------------
			install_defaults
			clear
			echo "System prepaired for LXC!! :}"
			sleep 3
			;;
		*)
			clear
			echo "Invalid input, Canceling whole script..."
			sleep 2
			exit 1
			;;
		esac
		;;
	*)
		clear
		echo "Invalid input, Canceling whole script..."
		sleep 2
		exit 1
		;;
esac
