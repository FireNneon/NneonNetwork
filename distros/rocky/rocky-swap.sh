#!/bin/bash
rocky_swap(){
sudo swapoff -a

sed -i.bak '/^[^#].*[[:space:]]swap[[:space:]]/ { /swapfile/!d }' /etc/fstab

sudo grubby --update-kernel=ALL --remove-args="resume"
sudo grubby --update-kernel=ALL --remove-args="rd.lvm.lv=rl/swap"

sudo lvremove /dev/rl/swap
#make the swap file. 
sudo fallocate -l 8G /swapfile
sudo chmod 600 /swapfile
sudo mkswap /swapfile

sudo swapon /swapfile

echo "/swapfile none swap defaults 0 0" | sudo tee -a /etc/fstab
sudo dracut -f --regenerate-all
}
