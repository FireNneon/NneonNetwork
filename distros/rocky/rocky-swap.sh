#!/bin/bash
rocky_swap(){
#disable swap
sudo swapoff -a
#remove the swap referance from fstab
sudo sed -i.bak '/^[^#].*[[:space:]]swap[[:space:]]/ { /swapfile/!d }' /etc/fstab

#Makeing sure no Kernals referance the old swap volume
sudo grubby --update-kernel=ALL --remove-args="resume"
sudo grubby --update-kernel=ALL --remove-args="rd.lvm.lv=rl/swap"

#remove the swap volume
sudo lvremove /dev/rl/swap -y

#make the swap file. 
sudo fallocate -l 8G /swapfile
#set the the right permissions
sudo chmod 600 /swapfile

#activate the swap file
sudo mkswap /swapfile
#turn on swap
sudo swapon /swapfile
#Add the swap file to fstab
echo "/swapfile none swap defaults 0 0" | sudo tee -a /etc/fstab
#regenerate dracut
sudo dracut -f --regenerate-all
}
