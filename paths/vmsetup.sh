#!/bin/bash
source ../paths/strippedsetup.sh
source ../distros/rocky/rocky-specific.sh
source ../distros/ubuntu/ubuntu-specific.sh
source ../install-docker.sh
# shellcheck disable=SC2154

SetupVM(){
	echo ""
	echo "------------NneonNetwork-----------------"
	echo "Nix: Before we Start Setting up the VM I have Some Questions for you."
	echo "-----------------------------------------"
	sleep 2.3
	clear
	Vm_Options


	case "$stripped" in
		Yes|yes|Y|y)
			SetupStripped
			;;
		No|no|N|n)
			case "$extras" in 

				1)
					first_steps
					install_docker
					;;
				2) 
					first_steps
					#install_borg #WIP
					;;
				3)
					first_steps
					install_docker
					sleep 2.1
					#install_borg #WIP
					;;
				4)
					clear
					echo "------------NneonNetwork-----------------"
					echo "Nix: You have selected No extras. now proceeding with setup.."
					echo "-----------------------------------------"
					sleep 2.1
					first_steps
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
							
			if [[ "$distro" = ubuntu ]]; then
				debloat_ubuntu
			fi
					
			if [[ "$distro" = rocky ]]; then
				rocky-specific
			elif [[ "$distro" = ubuntu ]]; then
				ubuntu_specifics
			fi
					
			sleep 2.1
			install_defaults
					
			if [[ "$distro" = rocky ]]; then
			rocky_swap
			#elif [[ "$distro" = ubuntu ]]; then  #maybe future placement.
			#ubuntu_swap 
			fi
					
			clear
			echo "------------NneonNetwork-----------------"
			echo "Nix: This VM is now ready for you, it's been a pleasure. Farewell Tell we meet again o/"
			echo ""
			echo "   .     . "
			echo " {_________} "
			echo "-----------------------------------------"
			sleep 2.3
			;;
		*)
			clear
			echo "------------NneonNetwork-----------------"
			echo "Nix: I don't understand.. Sorry, I'll have to cancel the process and the script o/."
			echo "-----------------------------------------"

			exit 1
			;;
	esac
}

