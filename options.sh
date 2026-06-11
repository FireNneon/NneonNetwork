#!/bin/bash
source ./loadinganimation.sh
options_distro_specfics (){

    LoadingAnimation

    echo ""
    echo "------------NneonNetwork-----------------"
    echo "Welcome. My name is Nix, I'm so happy to meet you. One moment, While I detect the system."
    sleep 2.5
    echo ""
    echo "Detecting System...."
    echo ""
    sleep 2.4
    clear
    echo ""
    echo "------------NneonNetwork-----------------"
    echo "Nix: The System I've detected is $distro"
    echo ""
    echo "-----------------------------------------"
    read -rp "Nix: Is this correct? (Yes or No?): " correctdistro

    #Logic for is this correct question. yes = just proceed, no = Ask to do a manual override. Which will allow you to manually type a distro name (can be anything), and then will ask if said distro uses DNF, APT, or other. 
    case "$correctdistro" in
        Yes|yes|Y|y)
            echo "-----------------------------------------"
            echo "Thank you for confirming that it was correct, I'll now proceed with setting up this system..."
            echo ""
            sleep 2.3
            clear
            ;;
        No|no|N|n)
            clear
            echo ""
            echo "------------NneonNetwork-----------------"
            echo "1) Manual override"
            echo "2) Detection was Correct After All"
            echo "3) Cancel"
            echo "-----------------------------------------"
            read -rp "Nix: You have told me that the distro detected was wrong. Sorry to Hear this. Please Select an option to proceed..(1-3): " distrochoice 
            echo ""
            echo "------------NneonNetwork-----------------"
            #Manual Overide Logic
            case "$distrochoice" in
                1)
                    clear
                    echo ""
                    echo "------------NneonNetwork-----------------"
                    echo "Nix: Manual Override Has been Selected..."
                    echo "-----------------------------------------"
                    sleep 2.2
                    read -rp "Nix: Please Tell me Which Distro You are using?: " manual
                    distro="$manual"
                    echo ""
                    #A true loop, which asks if the manual typed distro is correct. Yes = proceeds with the new distro and ends the loop. No = asks you to type it again, and then asks again if it was typed correctly, begining the loop again. 
                    while true; do 
                        read -rp "Nix: You have entered $distro, is this correct? (Yes | No): " correct
                        case "$correct" in
                
                            Yes|yes|Y|y)
                            clear
                            echo ""
                            echo "------------NneonNetwork-----------------"
                            echo "Nix: Thanks for confirming that I understood what you typed was correct. Now proceeding with setup..."
                            sleep 2.3
                            break
                            ;;
                            No|no|N|n)
                            clear
                            echo ""
                            echo "------------NneonNetwork-----------------"
                            read -rp "Nix: Please Retype what distro you are using? Sorry that got it wrong.: " manual
                            distro="$manual"
                            ;;
                        esac
                    done
                    # This Asks about if the manual distro that was typed uses DNF, apt, or other. Important override. 
                    echo ""
                    echo "------------NneonNetwork-----------------"
                    echo "1) Uses dnf (Example: Fedora)"
                    echo " 2) Uses apt (Example: Ubuntu)"
                    echo " 3) other (doesn't use either)"
                    echo "-----------------------------------------"
                    read -rp "Nix: Does $distro use dnf or apt? Please Select an Option. (1-3): " pkinfo
                    #logic for to change PackageManger
                    case "$pkinfo" in
                        1 | Rocky | rocky | Fedora | fedora | RHEL | rhel)
                            pk="dnf"
                            ;;
                        2 | Ubuntu | ubuntu | Debian | debian)
                            pk="apt"
                            ;;
                        3)
                        echo ""
                        echo "------------NneonNetwork-----------------"
                        echo "Nix: At this time I only understand Dnf and Apt. Sorry... Canceling Process.."
                        echo "-----------------------------------------"
                        ;;
                    esac
                    ;;
                2)
                    echo ""
                    echo "------------NneonNetwork-----------------"
                    echo "Nix: Ah I see, mistakes happen, proceeding with $distro...."
                    echo "-----------------------------------------"
                    sleep 2.3
                    ;;
                *) 
                    echo ""
                    echo "------------NneonNetwork-----------------"
                    echo "Nix: Canceling Process.."
                    echo "-----------------------------------------"
                    sleep 2.1
                    exit 1
                    ;;

        
            esac
                ;;
    esac
}

options_VM_OR_LXC(){
    systemtype=true #default value

    echo ""
    echo "------------NneonNetwork-----------------"
    echo "Nix: Alright now that we have finished setting up"
    echo "-----------------------------------------"

    case "$systemtype" in

        true)
            echo "true"
            ;;
        false) 
            echo "false"
            ;;
    esac





}
