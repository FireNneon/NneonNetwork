#!/bin/bash
# shellcheck disable=SC1091
source ./distros/rocky/rocky-specific.sh
source ./distros/ubuntu/ubuntu-specific.sh
# shellcheck disable=SC2154

SetupLXC(){
	echo ""
	echo "------------NneonNetwork-----------------"
	echo "Nix: Before we Start Setting up the LXC I have Some Questions for you."
	echo "-----------------------------------------"
	sleep 2.5
	sleep 2.1
	clear
	LXC_Options
	sudo chronyc -a makestep

	case "$stripped" in
		Yes|yes|Y|y)
			SetupStripped
			;;
		No|no|N|n)
			case "$extras" in 

				1) 
					first_steps
					#install_borg #WIP
					;;
				2)
					first_steps
					sleep 2.1
					;;
				*)
					clear
					echo "------------NneonNetwork-----------------"
					echo "Nix: I don't understand.. Sorry, I'll have to cancel the process and the script o/."
					echo "-----------------------------------------"
					sleep 2
					exit 1
					;;
			esac
			sleep 2.1
			
			if [[ "$distro" = rocky ]]; then
				rocky_LXC_specific
			elif [[ "$distro" = ubuntu ]]; then
				debloat_ubuntu
				ubuntu_specifics
			fi
					
			sleep 2.1
			install_defaults
			autoremove
			
			clear
			echo "------------NneonNetwork-----------------"
			echo "Nix: This LXC is now ready for you, it's been a pleasure. Farewell Tell we meet again o/"
			echo ""
			echo "   .     . "
			echo " {_________} "
			echo "-----------------------------------------"
			sleep 2.3
			;;
		*)
			clear
			echo "------------NneonNetwork-----------------"
			echo "Nix: Umm, something went wrong. Sorry, I'll have to cancel the process and the script o/."
			echo "-----------------------------------------"

			exit 1
			;;
	esac
}