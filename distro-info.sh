#!/bin/bash

source /etc/os-release 

case "$ID" in
    rocky)
        distro="rocky"
        ;;
    ubuntu)
    # shellcheck disable=SC2034
        distro="ubuntu"
        ;;
    *)
        echo "This distro doesn't work, canceling script..."
        exit 1
        ;;
esac

case "$ID" in
    rocky)
        pk="dnf"
        ;;
    ubuntu)
        # shellcheck disable=SC2034
        pk="apt"
        ;;
    *)
        echo "Something Went Wrong with the packagemanager detection script... Canceling.."
        exit 1
        ;;
esac

