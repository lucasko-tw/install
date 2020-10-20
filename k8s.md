### https://docs.docker.com/engine/install/centos/

### Disable
```
vim /etc/fstab
    ## comment swap

vim /etc/selinux/config
    SELINUX=disabled

reboot 

sudo firewall-cmd --state
sudo systemctl stop firewalld
sudo systemctl disable firewalld
#sudo systemctl disable iptables
#sudo systemctl stop iptables
sudo swapoff -a

```

### Install Docker

```
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

```

### Install Kubernetes on Master

```

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


kubeadm init --pod-network-cidr=10.244.0.0/16

#kubeadm init --pod-network-cidr=192.168.0.0/16 --ignore-preflight-errors=Swap --upload-certs
#kubeadm init --apiserver-advertise-address=100.0.0.1 --pod-network-cidr=10.244.0.0/16

mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

```

### Installation for Worker

```

## Install kubelet kubeadm kubectl on worker, then 

kubeadm join 192.168.228.129:6443 --token a06ywl.rok8hzmbcgq0oq5n \
    --discovery-token-ca-cert-hash sha256:8309a44df2e10e031c363577782293073a04b801f579265f4aba15b95d57a0e4 

```


### Installation for Offline Machine

```
### Offline On-Premise Kubernetes Installation 
yum install --downloadonly --downloaddir=/data/k8s kubelet kubeadm kubectl --disableexcludes=kubernetes
```

### Debug

```
journalctl -f -u kubelet.service
systemctl status kubelet.service
#kubeadm reset 
kubectl get pods --all-namespaces

```


### Install Pod-Network

```
kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml

kubectl get nodes	
```

You will see, the node get ready.

### Metallb Installation
 
```

kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.4/manifests/namespace.yaml
cat <<EOF | kubectl apply -f -
apiVersion: v1
kind: ConfigMap
metadata:
  namespace: metallb-system
  name: config
data:
  config: |
    address-pools:
    - name: default
      protocol: layer2
      auto-assign: true
      addresses:
      - 172.22.132.150-172.22.132.200
EOF


kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.4/manifests/metallb.yaml
kubectl create secret generic -n metallb-system memberlist --from-literal=secretkey="$(openssl rand -base64 128)"

```
 



