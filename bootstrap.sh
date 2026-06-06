#!/bin/bash
source ./common.sh

sudo -v || { echo "sudo authentication failed, exiting."; exit 1; }
echo "--------------------------"
echo "Starting Bootstrap.sh...."
echo "--------------------------"
sleep 2.3
echo "-----"
echo "..."
echo "-----"
sleep 2.3
echo "-----"
echo "...."
echo "-----"
sleep 2.3
echo "-----------------------------------------"
echo "Welcome. One moment, detecting System...."
echo "-----------------------------------------"
sleep 2.3
echo "--------------------------"
echo "Detected System is $distro"
echo "--------------------------"