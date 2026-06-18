#!/bin/bash
# shellcheck disable=SC2154

source ./distros/rocky/rocky-docker.sh
source ./distros/ubuntu/ubuntu-docker.sh

install_docker(){

	case "$distro" in
	rocky | Rocky | RHEL | rhel)
		rocky_docker
		;;
	ubuntu | Ubuntu | Debian | debian)
		ubuntu_docker
		;;
	*)
		echo ""
		echo "------------NneonNetwork-----------------"
		echo "Nix: Sadly, I don't recognize the given distro. I'm sorry... Canceling Process and Canceling docker install.."
		echo "-----------------------------------------"
		sleep 2.1
		exit 1
		;;
	esac
}