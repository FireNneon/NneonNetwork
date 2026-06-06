#!/bin/bash
source ./common.sh

sudo -v || { echo "sudo authentication failed, exiting."; exit 1; }

echo "Starting Bootstrap.sh...."
sleep 2.5
echo "..."
sleep 2.5
echo "...."
sleep 2.5
echo "Welcome...."
sleep 2.5 
echo "One moment, detecting System...."
sleep 2.5
echo "Detected System is $distro"