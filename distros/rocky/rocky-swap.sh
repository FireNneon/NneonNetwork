#!/bin/bash

sudo swapoff -a


sed -i.bak '/^[^#].*[[:space:]]swap[[:space:]]/ { /swapfile/!d }' /etc/fstab

sudo grubby --update-kernel=ALL --remove-args="resume"
sudo grubby --update-kernel=ALL --remove-args="rd.lvm.lv=rl/swap"
