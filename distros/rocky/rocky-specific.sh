#!/bin/bash
# shellcheck disable=SC2154


docker_override(){
	# Makes the directory if it isn't already
	sudo mkdir -p /etc/systemd/system/docker.service.d
	# Copies over the override into the override.conf.
	cp ./distros/rocky/docker-override.conf /etc/systemd/system/docker.service.d/override.conf
	# Reloads the daemon to make sure it applied.  
	sudo systemctl daemon-reload
}

sshd_override(){
	# Makes the directory if it isn't already
	sudo mkdir -p /etc/systemd/system/sshd.service.d
	# Copies over the override into the override.conf.
	sudo cp ./distros/rocky/sshd-override.conf /etc/systemd/system/sshd.service.d/override.conf
	# Reloads the daemon to make sure it applied.  
	sudo systemctl daemon-reload
}

rocky_specific(){
	docker_override
	sshd_override
}