https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/install-kubeadm/
```
===========================================================================================================================================================
 Package                                       Arch                          Version                               Repository                         Size
===========================================================================================================================================================
Installing:
 kubeadm                                       x86_64                        1.21.1-0                              kubernetes                        9.5 M
 kubectl                                       x86_64                        1.21.1-0                              kubernetes                        9.8 M
 kubelet                                       x86_64                        1.21.1-0                              kubernetes                         20 M
Installing for dependencies:
 conntrack-tools                               x86_64                        1.4.4-7.el7                           base                              187 k
 cri-tools                                     x86_64                        1.13.0-0                              kubernetes                        5.1 M
 kubernetes-cni                                x86_64                        0.8.7-0                               kubernetes                         19 M
 libnetfilter_cthelper                         x86_64                        1.0.0-11.el7                          base                               18 k
 libnetfilter_cttimeout                        x86_64                        1.0.0-7.el7                           base                               18 k
 libnetfilter_queue                            x86_64                        1.0.2-2.el7_2                         base                               23 k
 socat                                         x86_64                        1.7.3.2-2.el7                         base                              290 k



```


```

cat <<EOF | sudo tee /etc/modules-load.d/k8s.conf
br_netfilter
EOF

cat <<EOF | sudo tee /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
EOF
sudo sysctl --system


```