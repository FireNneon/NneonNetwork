#!/bin/bash
sudo -v || { echo "sudo authentication failed, exiting."; exit 1; }
source ./common.sh
echo "------NneonNetwork--------"
echo "Starting Bootstrap.sh...."
echo "--------------------------"

LoadingAnimation

echo ""
echo "------------NneonNetwork-----------------"
echo "Unknown: Welcome. My name is Nix, I'm so happy to meet you. One moment, While I detect the system."
sleep 2.3
echo ""
echo "Detecting System...."
echo "-----------------------------------------"
sleep 2.3
echo "------------NneonNetwork-----------------"
echo "Nix: The System I've detected is $distro"
read -rp "Nix: Is this correct? (Yes or No?): " correctdistro
echo ""
echo "------------NneonNetwork-----------------"
case "$correctdistro" in
    Yes|yes|Y|y)
        echo "-----------------------------------------"
        echo "Thank you for confirming that it was correct, I'll now proceed with setting up this system..."
        echo ""
        sleep 2.3
        ;;
    No|no|N|n)
        clear
        echo "1) Manual override"
        echo "2) Detection was Correct After All"
        echo "3) Cancel"
        echo "-----------------------------------------"
        read -rp "Nix: You have told me that the distro detected was wrong. Sorry to Hear this. Please Select an option to proceed..(1-3): " distrochoice 
        echo ""
        echo "------------NneonNetwork-----------------"
        case "$distrochoice" in
            1)
                clear
                echo "------------NneonNetwork-----------------"
                echo "Nix: Manual Override Has been Selected..."
                sleep 2.2
                echo ""
                read -rp "Nix: Please Tell me Which Distro You are using?: " manual
                distro="$manual"
                echo ""
                while true; do 
                read -rp "Nix: You have entered $distro, is this correct? (Yes | No): " correct
                case "$correct" in
                
                    Yes|yes|Y|y)
                        clear
                        echo "------------NneonNetwork-----------------"
                        echo "Nix: Thanks for confirming that I understood what you typed was correct. Now proceeding with setup..."
                        sleep 2.3
                        break
                        ;;
                    No|no|N|n)
                        clear
                        echo "------------NneonNetwork-----------------"
                        read -rp "Nix: Please Retype what distro you are using? Sorry that got it wrong.: " manual
                        distro="$manual"
                        ;;
                esac
                done

                sleep 2.2
                echo "1) Uses dnf"
                echo " 2) Uses apt"
                echo " 3) other (doesn't use either)"
                read -rp "Nix: Does $distro use dnf or apt? Please Select an Option. (1-3): " pkinfo
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

                echo "Nix: Ah I see, mistakes happen, proceeding..."
                sleep 2.3
                ;;
            *) 
                echo "Nix: Canceling script..."
                exit 1
                ;;

        
        esac
            ;;
esac

echo "This message is for testing, the distro currently set is $distro and the PackageManager is $pk"
sleep 2.3
echo "This is to test if the functions changed" 
first_steps