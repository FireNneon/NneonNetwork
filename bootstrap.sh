#!/bin/bash
source ./common.sh

sudo -v || { echo "sudo authentication failed, exiting."; exit 1; }

echo "Starting Bootstrap.sh...."
sleep 3
echo "Welcome...."
sleep 3 
echo "One moment, detecting System...."
sleep 2
echo "Detected System is $distro"