#!/bin/bash
sudo -v || { echo "sudo authentication failed, exiting."; exit 1; }

source ./distro-info.sh
source ./options.sh
source ./common.sh
source ./paths.sh

# Stage 1 - Distro and Package Manager
options_distro_specfics
# Stage 2 Are we setting up VM or LXC? (Default VM)
options_VM_OR_LXC

case $systemtype in
	VM)
		SetupVM
		;;
	LXC)
		SetupLXC # not setup yet
		;;
esac
