#!/bin/bash
source ./common.sh

sudo -v || { echo "sudo authentication failed, exiting."; exit 1; }

 
 echo "What do you want todo with this system?"
echo " 1) Only Debloat system"
echo " 2) Prepare system?"
echo ""
read -rp "Enter choice [1-2] (type anything to cancel whole script): " doingtype
sleep 2
read -rp "What type of system is this, LXC or VM?: " systemtype
sleep 2