#!/bin/bash
harden_ssh() {
	#Harden SSH
	sudo cp ./sshd_config /etc/ssh/sshd_config
	sudo systemctl daemon-reload
	sudo systemctl restart ssh
	sudo systemctl enable --now ssh
}
first_steps() {
	sudo apt update && sudo apt upgrade -y
	sudo apt install curl -y
}
