################################
#DO NOT RUN THIS SCRIPT AS ROOT#
################################
#Disable Swap
sudo sed -i '/ swap / s/^\(.*\)$/#\1/g' /etc/fstab
sudo swapoff -a
#Set hostname 
#sudo nano /etc/hostname
#Set hosts
#sudo nano /etc/hosts
#127.0.0.1 localhost 
#ip.address.master master-hostname
#ip.address.worker1 worker1-hostname
#ip.address.worker2 worker2-hostname
#sudo reboot
#########################################
#You need to reboot to apply this change#
#########################################