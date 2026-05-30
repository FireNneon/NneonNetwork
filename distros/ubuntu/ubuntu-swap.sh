#!/bin/bash

# Disable swap
sudo swapoff -a
sudo rm -f /swap.img
sudo sed -i '/swap/s/^/#/' /etc/fstab