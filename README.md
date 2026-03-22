Personally REPO for my homelab, Includes the Following sshd_config for some default ssh hardening, and my boottrap script made specfically for my homelab that runs proxmox. 

Steps to Pull repo:

  1. apt install git

  2. Git clone https://github.com/FireNneon/NneonNetwork
  3. Type in Username.
  4. Type in API token. 

Steps to run script:

  1. cd ./NneonNetwork
  2. sudo chmod +x prepairsystem.sh
  4. type sudo password. 
  5. ./prepairsystem.sh
  6. enter sudo password. 

Script Will run. 

  What to Expect to happen: 

  The script will ask you which Version you want, the main options are. 
   VM.
   LXC.

VM Path: 
   It will then show/ask some extra install options.  Which are. 
   Install just borg
   Install just docker
   ALL options
   or no extra bits 

   All options will in this path will remove bloatware specfic to me, apt update & apt upgrade, expand the VMS disc to the full size,
   Install Tailscale, Crowdsec, qemu-guest-agent, and Will then harden SSH using the provided sshd_config.


LXC Path: 

This path follows the VM path closely, but doesn't expand the disk, LXC containers don't need that step, and it will also not install qemu-guest-agent. 

so it apt update & apt upgrade, Install Tailscale, Crowdsec and Harden SSH with the provided sshd_config.

 
