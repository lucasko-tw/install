
## Max process of Linux
cat /proc/sys/kernel/threads-max 

#echo 100000 > /proc/sys/kernel/threads-max


## Performance Tuning for JBoss or Wildfly

https://techdocs.broadcom.com/us/en/symantec-security-software/identity-security/identity-manager/14-0/reference/performance-tuning/performance-tuning-for-jboss-or-wildfly.html


The fine-tuned configurations that we recommend for optimizing the performance of the JBoss or Wildfly application server are: 
Recommended JVM Settings
Open Files
Maximum User Processes
Connection Backlog
Set TCP_KEEPALIVE_INTERVAL
Set TCP_KEEPALIVE_PROBES
Allocate Huge Pages for Java Virtual Machine (JVM) Heap
Increase Linux kernel Entropy
Test Entropy
 
 
## JVM 

On a server class computer of today (64-bit), 
JVM normally sets the maximum heap by default to one-fourth of the available memory on the machine. 
For example, on a machine with 16 GB RAM, 
the maximum heap size will be 4 GB.


https://developpaper.com/high-concurrency-tuning-of-linux-server/

## Open files
, a single process can open up to 1024 files, which is far from meeting the high concurrency requirements. The adjustment process is as follows: type in at the ා, prompt:

```
ulimit –n 65535
```

```
# vim /etc/security/limits.conf
* soft nofile 65535
* hard nofile 65535
```


### Connection Pool
https://docs.oracle.com/en/database/oracle/oracle-database/21/jjucp/optimizing-real-world-performance.html#GUID-BC09F045-5D80-4AF5-93F5-FEF0531E0E1D
 Oracle recommends 1-10 connections per CPU core.