################################
#DO NOT RUN THIS SCRIPT AS ROOT#
################################
#Install Kubernetes on master and workers
sudo apt update
sudo apt -y install curl apt-transport-https
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list
sudo apt update
sudo apt -y install kubelet kubeadm kubectl
sudo apt-mark hold kubelet kubeadm kubectl
#Configure sysctl on master and workers
sudo modprobe overlay
sudo modprobe br_netfilter
sudo tee /etc/sysctl.d/kubernetes.conf<<EOF
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
net.ipv4.ip_forward = 1
EOF
#Enable kubelet service on master and workers
sudo systemctl enable kubelet
#Pull container images on master
sudo kubeadm config images pull
#Create cluster on master
sudo kubeadm init --pod-network-cidr=10.244.0.0/16 
#Configure kubectl on master
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config
#Check cluster version
#kubeadm version
#Print join command on master
#kubeadm token create --print-join-command
#Install network plugin on master (Recommend flannel)
#kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml 
#kubectl apply -f https://docs.projectcalico.org/manifests/calico.yaml

