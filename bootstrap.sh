#!/bin/bash
sudo -v || { echo "sudo authentication failed, exiting."; exit 1; }
source ./distro-info.sh
source ./options.sh
source ./common.sh

options_distro_specfics
options_VM_OR_LXC

echo "This message is for testing, the distro currently set is $distro and the PackageManager is $pk"
