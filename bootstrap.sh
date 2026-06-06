#!/bin/bash
source ./common.sh

sudo -v || { echo "sudo authentication failed, exiting."; exit 1; }
echo "------NneonNetwork--------"
echo "Starting Bootstrap.sh...."
echo "--------------------------"
sleep 2.3
clear
echo "."
sleep 2.2
clear
echo ".."
sleep 2.2
clear
echo "..."
sleep 2.3
clear
echo ""
echo "------------NneonNetwork-----------------"
echo "Welcome. One moment, detecting System...."
echo "-----------------------------------------"
echo ""
sleep 2.3
echo ""
echo "------NneonNetwork--------"
echo "Detected System is $distro"
echo "--------------------------"
echo ""