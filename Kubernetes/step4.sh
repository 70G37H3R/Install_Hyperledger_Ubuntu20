################################
#DO NOT RUN THIS SCRIPT AS ROOT#
################################
#Setup An NFS 
#Setup an NFS on master
sudo apt-get install nfs-kernel-server -y
#Setup an NFS on workers
sudo apt-get install nfs-common -y
#On master and workers
sudo mkdir -p /opt/share
sudo chown nobody:nogroup /opt/share
sudo chmod 777 /opt/share
#On master
sudo tee /etc/exports <<EOF
/opt/share      *(rw,sync,no_subtree_check,no_root_squash)
EOF
sudo exportfs -a
sudo systemctl restart nfs-kernel-server
#On worker node
sudo mount <ip.master>:/opt/share /opt/share
sudo tee /etc/fstab <<EOF
<ip-master>:/opt/share /opt/share auto,nofail,noatime,nolock,intr,tcp,actimeo=1800 0 0
EOF

