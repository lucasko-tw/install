### https://docs.docker.com/engine/install/centos/

vim /etc/fstab

#uncomment swape 

 vim /etc/selinux/config
SELINUX=disabled




sudo yum install -y yum-utils

sudo yum-config-manager \
    --add-repo \
    https://download.docker.com/linux/centos/docker-ce.repo

sudo yum-config-manager --enable docker-ce-nightly

sudo yum-config-manager --enable docker-ce-test


sudo yum list docker-ce --showduplicates | sort -r

sudo yum install -y docker-ce-3:19.03.13-3.el8 docker-ce-cli-19.03.13  containerd.io

sudo systemctl start docker

sudo systemctl enable docker


 sudo swapoff -a


cat <<EOF | sudo tee /etc/yum.repos.d/kubernetes.repo
[kubernetes]
name=Kubernetes
baseurl=https://packages.cloud.google.com/yum/repos/kubernetes-el7-\$basearch
enabled=1
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://packages.cloud.google.com/yum/doc/yum-key.gpg https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg
exclude=kubelet kubeadm kubectl
EOF

# Set SELinux in permissive mode (effectively disabling it)
sudo setenforce 0
sudo sed -i 's/^SELINUX=enforcing$/SELINUX=permissive/' /etc/selinux/config

sudo yum install -y kubelet kubeadm kubectl --disableexcludes=kubernetes

sudo systemctl enable --now kubelet

sudo firewall-cmd --state
sudo systemctl stop firewalld
sudo systemctl disable firewalld
#sudo systemctl disable iptables
#sudo systemctl stop iptables

kubeadm init
sudo kubeadm init --pod-network-cidr=10.244.0.0/16
#kubeadm init --pod-network-cidr=192.168.0.0/16 --ignore-preflight-errors=Swap --upload-certs


#sudo kubeadm init --apiserver-advertise-address=100.0.0.1 --pod-network-cidr=10.244.0.0/16

kubeadm join 192.168.228.129:6443 --token a06ywl.rok8hzmbcgq0oq5n \
    --discovery-token-ca-cert-hash sha256:8309a44df2e10e031c363577782293073a04b801f579265f4aba15b95d57a0e4 




mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

kubectl get nodes	

journalctl -f -u kubelet.service

kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml





systemctl status kubelet.service
kubeadm reset 
kubectl get pods


