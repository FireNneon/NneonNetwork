#!/bin/bash
sudo -v || { echo "sudo authentication failed, exiting."; exit 1; }
source ./common.sh
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
echo "------------NneonNetwork-----------------"
echo "Welcome. One moment, detecting System...."
echo "-----------------------------------------"
sleep 2.3
echo ""
echo "------NneonNetwork--------"
echo "Detected System is $distro"
echo "--------------------------"
read -rp "Is this correct? (Yes or No?)" correctdistro
case "$correctdistro" in
    Yes|yes|Y|y)
    echo "Thank you for confirming that it was correct, now proceeding..."
    sleep 2.3
        ;;
    No|no|N|n)
        echo "1) Rocky"
        echo "2) Ubuntu"
        echo "3) Detection was Correct After All? "
        echo "4) Cancel"
        read -rp "You have told use that the distro detected is wrong, out of these options which is correct? (1-4)" distrochoice 
        case "$distrochoice" in
            1)
                distro="rocky"
                ;;
            2)
            # shellcheck disable=SC2034
                distro="ubuntu"
                ;;
            3) 
                echo "Ah I see, mistakes happen, proceeding..."
                sleep 2.3
                ;;
            *)
                echo "Canceling script..."
                exit 1
                ;;
        esac

        case "$distrochoice" in
            1)
                pk="dnf"
                ;;
            2)
                # shellcheck disable=SC2034
                pk="apt"
                ;;
        esac
            ;;
esac

echo "This message is for testing, the distro currently set is $distro and the PackageManager is $pk"