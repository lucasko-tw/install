

```
vim /etc/kubernetes/manifests/kube-apiserver.yaml

- command:
 - kube-apiserver
 - --feature-gates=RemoveSelfLink=false

```