#!/bin/bash

source /etc/os-release 

#This script finds out the distro and packagemanager. 

case "$ID" in
    rocky)
        distro="rocky"
        ;;
    ubuntu)
    # shellcheck disable=SC2034
        distro="ubuntu"
        ;;
    *)
        echo ""
        echo "------------NneonNetwork-----------------"
        echo "Nix: Sadly, I don't recognize the Distro that was detected. I'm sorry... Canceling Process.."
        echo "-----------------------------------------"
        sleep 2.1
        exit 1
        ;;
esac

case "$ID" in
    rocky | Rocky | Fedora | fedora | RHEL | rhel)
        pk="dnf"
        ;;
    ubuntu | Ubuntu | Debian | debian)
        # shellcheck disable=SC2034
        pk="apt"
        ;;
    *)
        echo ""
        echo "------------NneonNetwork-----------------"
        echo "Nix: Sadly, I don't recognize the package manager that was detected. I'm sorry... Canceling Process.."
        echo "-----------------------------------------"
        sleep 2.1
        exit 1
        ;;
esac

