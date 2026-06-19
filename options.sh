#!/bin/bash
# shellcheck disable=SC2034
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
            sleep 2.4
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
                    read -rp "Nix: Please Tell me Which Distro You are using?: " manualdistro
                    distro="$manualdistro"
                    echo ""
                    #A true loop, which asks if the manual typed distro is correct. Yes = proceeds with the new distro and ends the loop. No = asks you to type it again, and then asks again if it was typed correctly, begining the loop again. 
                    while true; do 
                        read -rp "Nix: You have entered $distro, is this correct? (Yes | No): " distrocorrect
                        case "$distrocorrect" in
                
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
                            read -rp "Nix: Please Retype what distro you are using? Sorry that got it wrong.: " manualdistro
                            distro="$manualdistro"
                            ;;
                        esac
                    done
                    # This Asks about if the manual distro that was typed uses DNF, apt, or other. Important override. 
                    echo ""
                    echo "------------NneonNetwork-----------------"
                    echo "1) Uses dnf (Example: Fedora, Rocky,RHEL )"
                    echo " 2) Uses apt (Example: Ubuntu)"
                    echo " 3) other (doesn't use either)"
                    echo "-----------------------------------------"
                    read -rp "Nix: Does $distro use dnf or apt? Please Select an Option. (1-3): " pkinfo
                    #logic for to change PackageManger
                    case "$pkinfo" in
                        1)
                            pk="dnf"
                            ;;
                        2)
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
                    sleep 2.1
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
    systemtype=VM #default value

    echo ""
    echo "------------NneonNetwork-----------------"
    echo "Nix: Alright now that I have what Distro, Now lets figure which systemtype this is ...."
    echo "-----------------------------------------"
    sleep 3
    clear
    echo ""
    echo "------------NneonNetwork-----------------"
    echo "1) Use Defualt (VM)"
    echo "2) Manual Overide"
    echo "3) Cancel script"
    echo "-----------------------------------------"
    read -rp "Nix: By default I automatically use $systemtype. Tell me, Should I use default? (1-3): " systemtypechoice
    case "$systemtypechoice" in
        1)
            clear
            echo ""
            echo "------------NneonNetwork-----------------"
            echo "Using Default ($systemtype), I'll now proceed with setting up this system..."
            echo "-----------------------------------------"
            sleep 2.3
            clear
            ;;
        2) 
            clear
            echo ""
            echo "------------NneonNetwork-----------------"
            echo "Nix: Manual Override Has been Selected..."
            echo "-----------------------------------------"
            sleep 2.3
            read -rp "Nix: Please Tell me if You are using LXC or VM You are using?: " manualsystemtype
            echo ""
            systemtype="$manualsystemtype"
            while true; do
                read -rp "Nix: You have entered $systemtype, is this correct? (Yes | No): " systemtypecorrect
                case "$systemtypecorrect" in
                    Yes|yes|Y|y)
                        echo "-----------------------------------------"
                        echo "Thank you for confirming that it was correct, I'll now proceed with setting up this system... using $systemtype"
                        echo ""
                        sleep 2.3
                        clear
                        break
                        ;;
                    No|no|N|n)
                        clear
                        echo ""
                        echo "------------NneonNetwork-----------------"
                        read -rp "Nix: Please Retype if this is a LXC or VM? Sorry that got it wrong.: " manualdistro
                        systemtype="$manualsystemtype"
                        ;;
                esac         
            done
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

    

}

Vm_Options(){
    echo "------------NneonNetwork-----------------"
    read -rp "Nix: First Question, Would you like me to stripped this vm to it's core? (No Docker, No Crowdsec, No Borg, bare essensitals) (Yes | No): " stripped
    echo "-----------------------------------------"
    sleep 2.3
    clear
    echo "------------NneonNetwork-----------------"
    echo "Nix: Now for the next question..."
    echo "-----------------------------------------"
    sleep 2.3
    clear
    echo ""
    echo "------------NneonNetwork-----------------"
    echo "1) Install just docker"
    echo "2) Install just Borg (Currently not setup)"
    echo "3) ALL (Install all the bits)"
	echo "4) Non of the above"
    echo "-----------------------------------------"
    read -rp "Nix: Out of these extra bits, what would you like? (1, 3 or 4): " extras
    sleep 2.1
    clear
    echo ""
    echo "------------NneonNetwork-----------------"
    echo "Nix: Alright, thank you for answering my Questions, now proceeding with VM Setup..."
    echo "-----------------------------------------"
    sleep 2.3
    clear
}