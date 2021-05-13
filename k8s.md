### https://docs.docker.com/engine/install/centos/



### Create a network for Vmware/VirtualBox

The network range is from 192.168.56.0/16


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



kubeadm init


kubeadm token create --print-join-command

mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

kubectl get nodes

# Untaint master node
# kubectl taint nodes --all node-role.kubernetes.io/master-
```

### Install Network Plugin (Calico)

```
curl https://docs.projectcalico.org/manifests/calico.yaml -O

kubectl apply -f calico.yaml
```

You will see, the node get ready.

### Metallb Installation from Master Node
 
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
      - 192.168.56.150-192.168.56.200
EOF


kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.4/manifests/metallb.yaml
kubectl create secret generic -n metallb-system memberlist --from-literal=secretkey="$(openssl rand -base64 128)"

```
 

### Deploy test App

```
kubectl create deployment --image=nginx nginx-app
kubectl expose deploy nginx-app --port 8080 --target-port 80 --type LoadBalancer

curl 192.168.56.150:8080


curl
NAME                 TYPE           CLUSTER-IP      EXTERNAL-IP      PORT(S)          AGE
service/kubernetes   ClusterIP      10.96.0.1       <none>           443/TCP          7h12m
service/nginx-app    LoadBalancer   10.105.92.222   192.168.56.150   8080:30808/TCP   18s
```


### Installation for Worker

```

## Install kubelet kubeadm kubectl on worker, then 

kubeadm join 192.168.228.129:6443 --token a06ywl.rok8hzmbcgq0oq5n \
    --discovery-token-ca-cert-hash sha256:8309a44df2e10e031c363577782293073a04b801f579265f4aba15b95d57a0e4 

export KUBECONFIG=/etc/kubernetes/kubelet.conf 
kubectl get nodes
```


### DNS

```
# dns server ip is set to 192.168.56.12
# You can replcae dns ip with yours for following files.
# ./k8s/dns/ingress-controller/service.yml:  - 192.168.56.12
# ./k8s/dns/dns/coredns/service-udp.yml:  - 192.168.56.12
# ./k8s/dns/dns/coredns/service-tcp.yml:  - 192.168.56.12

kubectl apply -f  k8s/dns/dns/namespace.yaml
kubectl apply -f  k8s/dns/dns/coredns
kubectl apply -f  k8s/dns/dns/etcd
kubectl apply -f  k8s/dns/dns/externaldns
kubectl apply -f  k8s/dns/ingress-controller
kubectl apply -f  k8s/dns/ingress-controller


kubectl apply -f  k8s/dns/ingress-controller

curl test.k8s.lucasko.tw:80

```


### Dumping Required packages for Offline Installation

```
### Dump RPM files of kubernetes from Online machine
yum install --downloadonly --downloaddir=/data/k8s kubelet kubeadm kubectl --disableexcludes=kubernetes
```


### RPM
```

cd /data/rpm 

wget http://mirror.centos.org/centos/8/BaseOS/x86_64/os/Packages/checkpolicy-2.9-1.el8.x86_64.rpm
wget https://download.docker.com/linux/centos/7/x86_64/stable/Packages/containerd.io-1.3.7-3.1.el7.x86_64.rpm
wget https://download.docker.com/linux/centos/8/x86_64/test/Packages/docker-ce-19.03.13-3.el8.x86_64.rpm
wget https://download.docker.com/linux/centos/8/x86_64/test/Packages/docker-ce-cli-19.03.13-3.el8.x86_64.rpm
wget http://mirror.centos.org/centos/8/BaseOS/x86_64/os/Packages/libcgroup-0.41-19.el8.x86_64.rpm
wget http://mirror.centos.org/centos/8/BaseOS/x86_64/os/Packages/libseccomp-2.4.1-1.el8.x86_64.rpm
wget http://mirror.centos.org/centos/8/BaseOS/x86_64/os/Packages/python3-libsemanage-2.9-2.el8.x86_64.rpm
wget http://mirror.centos.org/centos/8/BaseOS/x86_64/os/Packages/policycoreutils-2.9-9.el8.x86_64.rpm
wget http://mirror.centos.org/centos/7/os/x86_64/Packages/python-IPy-0.75-6.el7.noarch.rpm


ls -ls 

checkpolicy-2.9-1.el8.x86_64.rpm
containerd.io-1.3.7-3.1.el7.x86_64.rpm
docker-ce-19.03.13-3.el8.x86_64.rpm
docker-ce-cli-19.03.13-3.el8.x86_64.rpm
libcgroup-0.41-19.el8.x86_64.rpm
libseccomp-2.4.1-1.el8.x86_64.rpm
policycoreutils-2.9-9.el8.x86_64.rpm
python3-libsemanage-2.9-2.el8.x86_64.rpm
python-IPy-0.75-6.el7.noarch.rpm

yum --disablerepo=\* --enablerepo=c8-media-BaseOS,c8-media-AppStream install container-selinux libsemanage audit-libs policycoreutils python36 python2

rpm -ivh --replacefiles --replacepkgs *.rpm
```



### Debug

```
journalctl -f -u kubelet.service
systemctl status kubelet.service
#kubeadm reset 
kubectl get pods --all-namespaces

```


```sh
# https://www.centlinux.com/2019/02/install-docker-ce-on-offline-centos-7-machine.html#point6
```

yum install -y yum-utils device-mapper-persistent-data lvm2

(1/16): audit-libs-python-2.8.5-4.el7.x86_64.rpm                                                                       |  76 kB  00:00:00     
(2/16): checkpolicy-2.5-8.el7.x86_64.rpm                                                                               | 295 kB  00:00:00     
(3/16): container-selinux-2.119.2-1.911c772.el7_8.noarch.rpm                                                           |  40 kB  00:00:00     
warning: /var/cache/yum/x86_64/7/docker-ce-stable/packages/containerd.io-1.4.4-3.1.el7.x86_64.rpm: Header V4 RSA/SHA512 Signature, key ID 621e9f35: NOKEY
Public key for containerd.io-1.4.4-3.1.el7.x86_64.rpm is not installed
(4/16): containerd.io-1.4.4-3.1.el7.x86_64.rpm                                                                         |  33 MB  00:00:04     
(5/16): docker-ce-20.10.6-3.el7.x86_64.rpm                                                                             |  27 MB  00:00:06     
(6/16): docker-ce-rootless-extras-20.10.6-3.el7.x86_64.rpm                                                             | 9.2 MB  00:00:01     
(7/16): fuse3-libs-3.6.1-4.el7.x86_64.rpm                                                                              |  82 kB  00:00:00     
(8/16): fuse-overlayfs-0.7.2-6.el7_8.x86_64.rpm                                                                        |  54 kB  00:00:00     
(9/16): libsemanage-python-2.5-14.el7.x86_64.rpm                                                                       | 113 kB  00:00:00     
(10/16): docker-ce-cli-20.10.6-3.el7.x86_64.rpm                                                                        |  33 MB  00:00:04     
(11/16): python-IPy-0.75-6.el7.noarch.rpm                                                                              |  32 kB  00:00:00     
(12/16): docker-scan-plugin-0.7.0-3.el7.x86_64.rpm                                                                     | 4.2 MB  00:00:00     
(13/16): policycoreutils-python-2.5-34.el7.x86_64.rpm                                                                  | 457 kB  00:00:00     
(14/16): slirp4netns-0.4.3-4.el7_8.x86_64.rpm                                                                          |  81 kB  00:00:00     
(15/16): setools-libs-3.3.8-4.el7.x86_64.rpm                                                                           | 620 kB  00:00:00     
(16/16): libcgroup-0.41-21.el7.x86_64.rpm           
