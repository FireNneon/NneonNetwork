#!/bin/bash

debloat_ubuntu() {
	# Stop multipathd and its socket first
	sudo systemctl stop multipathd multipathd.socket

	# Then disable everything
	sudo systemctl disable --now ModemManager multipathd multipathd.socket udisks2 upower

	# Remove unnecessary packages
	sudo apt remove -y modemmanager
	sudo apt autoremove -y
}

Ubuntu_Specifics() {
	# Expand LVM to use full disk
	sudo lvextend -l +100%FREE /dev/ubuntu-vg/ubuntu-lv

	sudo resize2fs /dev/ubuntu-vg/ubuntu-lv

	sudo lvextend -l +100%FREE /dev/rl_borgbackupserver/root
	sudo xfs_growfs /

	#install qemu-guest-agent, tailscale, etc. 

}