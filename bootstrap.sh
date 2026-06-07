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
echo "Welcome. My name is Nix, One moment, While I detect the system."
sleep 2.2
echo "Detecting System...."
echo "-----------------------------------------"
sleep 2.3
echo ""
echo "------NneonNetwork--------"
echo "The System I've detected is $distro"
echo "--------------------------"
read -rp "Is this correct? (Yes or No?)" correctdistro
echo ""
case "$correctdistro" in
    Yes|yes|Y|y)
        echo "Thank you for confirming that it was correct, I'll now proceed with setting up this system..."
        sleep 2.3
        ;;
    No|no|N|n)
        echo "1) Manual override"
        echo "2) Detection was Correct After All? "
        echo "3) Cancel"
        read -rp "You have told me that the distro detected was wrong. Sorry to Hear this. Please Select an option to proceed..(1-3)" distrochoice 
        case "$distrochoice" in
            1)
                echo "Manual Override Has been Selected..."
                sleep 2.2
                echo ""
                read -rp "Please Tell me Which Distro You are using?" manual
                distro="$manual"
                echo ""
                while true; do 
                read -rp "You have entered $distro, is this correct? (Yes | No)" correct
                case "$correct" in
                
                    Yes|yes|Y|y)
                        echo "Thanks for confirming that I understood what you typed was correct. Now proceeding with setup..."
                        sleep 2.3
                        break
                        ;;
                    No|no|N|n)
                        read -rp "Please Retype what distro you are using? Sorry that got it wrong." manual
                        distro="$manual"
                        ;;
                esac
                done

                sleep 2.2
                echo "1) Uses dnf"
                echo " 2) Uses apt"
                echo " 3) other (doesn't use either)"
                read -rp "Does $distro use dnf or apt? Please Select an Option. (1-3)" pkinfo
                case "$pkinfo" in
                    1 | Rocky | rocky | Fedora | fedora | RHEL | rhel)
                        pk="dnf"
                        ;;
                    2 | Ubuntu | ubuntu | Debian | debian)
                        pk="apt"
                        ;;
            *)
            echo "PlaceHolder Command"
            ;;
        esac
                ;;
            2)

                echo "Ah I see, mistakes happen, proceeding..."
                sleep 2.3
                ;;
            *) 
                echo "Canceling script..."
                exit 1
                ;;

        
        esac
            ;;
esac

echo "This message is for testing, the distro currently set is $distro and the PackageManager is $pk"
sleep 2.3
echo "This is to test if the functions changed" 
first_steps