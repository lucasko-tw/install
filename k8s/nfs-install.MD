
### NFS Server
```
yum install nfs-utils


#設定分享的目錄, 以下是 /var/nfsshare:
mkdir /var/nfsshare
chmod -R 777 /var/nfsshare/


## 開啟 /etc/exports 檔案, 加入以下內容:
vim /etc/exports 

/var/nfsshare 192.168.0.0/16(rw,sync,no_root_squash,no_all_squash)

#啟動 NFS Server, 設定開機自動執行及在 firewalld 開放 NFS:
systemctl enable rpcbind
systemctl enable nfs-server
systemctl enable nfs-lock
systemctl enable nfs-idmap
systemctl start rpcbind
systemctl start nfs-server
systemctl start nfs-lock
systemctl start nfs-idmap
firewall-cmd --permanent --zone=public --add-service=nfs
firewall-cmd --reload
```



```
yum install nfs-utils -y

(1/16): libbasicobjects-0.1.1-32.el7.x86_64.rpm                                                                                         |  26 kB  00:00:00     
(2/16): libcollection-0.7.0-32.el7.x86_64.rpm                                                                                           |  42 kB  00:00:00     
(3/16): gssproxy-0.7.0-30.el7_9.x86_64.rpm                                                                                              | 111 kB  00:00:00     
(4/16): keyutils-1.5.8-3.el7.x86_64.rpm                                                                                                 |  54 kB  00:00:00     
(5/16): libnfsidmap-0.25-19.el7.x86_64.rpm                                                                                              |  50 kB  00:00:00     
(6/16): libini_config-1.3.1-32.el7.x86_64.rpm                                                                                           |  64 kB  00:00:00     
(7/16): libevent-2.0.21-4.el7.x86_64.rpm                                                                                                | 214 kB  00:00:00     
(8/16): libpath_utils-0.2.1-32.el7.x86_64.rpm                                                                                           |  28 kB  00:00:00     
(9/16): libref_array-0.1.5-32.el7.x86_64.rpm                                                                                            |  27 kB  00:00:00     
(10/16): libverto-libevent-0.2.5-4.el7.x86_64.rpm                                                                                       | 8.9 kB  00:00:00     
(11/16): libtirpc-0.2.4-0.16.el7.x86_64.rpm                                                                                             |  89 kB  00:00:00     
(12/16): quota-4.01-19.el7.x86_64.rpm                                                                                                   | 179 kB  00:00:00     
(13/16): nfs-utils-1.3.0-0.68.el7.x86_64.rpm                                                                                            | 412 kB  00:00:00     
(14/16): quota-nls-4.01-19.el7.noarch.rpm                                                                                               |  90 kB  00:00:00     
(15/16): tcp_wrappers-7.6-77.el7.x86_64.rpm                                                                                             |  78 kB  00:00:00     
(16/16): rpcbind-0.2.0-49.el7.x86_64.rpm  

```