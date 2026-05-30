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

