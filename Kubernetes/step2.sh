################################
#DO NOT RUN THIS SCRIPT AS ROOT#
################################
#Install Docker and Docker-Compose
sudo apt update
sudo apt install -y curl gnupg2 software-properties-common apt-transport-https ca-certificates
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt update
sudo apt install -y containerd.io docker-ce docker-ce-cli
sudo curl -L "https://github.com/docker/compose/releases/download/1.23.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
# Create required directories
sudo mkdir -p /etc/systemd/system/docker.service.d
# Create daemon json config file
sudo tee /etc/docker/daemon.json <<EOF
{
  "exec-opts": ["native.cgroupdriver=systemd"],
  "log-driver": "json-file",
  "log-opts": {
    "max-size": "100m"
  },
  "storage-driver": "overlay2"
}
EOF
#Config proxy for docker
sudo tee /etc/systemd/system/docker.service.d/http-proxy.conf <<EOF
[Service]
Environment="http_proxy=http://proxy.ctu.edu.vn:3128"
Environment="https_proxy=http://proxy.ctu.edu.vn:3128"
Environment="ftp_proxy=http://proxy.ctu.edu.vn:3128"
Environment="no_proxy=localhost,127.0.0.1,192.168.0.0/16,10.0.0.0/24"
EOF
#Start and enable Services
sudo systemctl daemon-reload 
sudo systemctl restart docker
sudo systemctl enable docker
#Run docker without sudo
sudo usermod -aG docker $USER
reboot
#########################################
#You need to reboot to apply this change#
#########################################


