# Linux 内核优化

Linux内核优化需要根据服务器角色的不同按需优化

## 1. 常用的内核优化参数分类和解释

1.1 以下参数都配置在文件 /etc/sysctl.conf 中，系统重启后生效，实际使用时要按需配置
```
#high-concurrency-tcp-tuning
fs.file-max = 5000000
net.core.somaxconn = 65535
net.core.netdev_max_backlog = 16384
net.ipv4.tcp_fin_timeout = 10
net.ipv4.tcp_syncookies = 1
net.ipv4.tcp_synack_retries = 2
net.ipv4.tcp_syn_retries = 2
net.ipv4.tcp_keepalive_time = 600
net.ipv4.tcp_keepalive_probes = 5
net.ipv4.tcp_keepalive_intvl = 15
net.ipv4.tcp_tw_reuse = 1
net.ipv4.tcp_tw_recycle = 0
net.ipv4.ip_local_port_range = 1024  65000
net.ipv4.tcp_max_syn_backlog = 65535
net.ipv4.tcp_max_tw_buckets = 144000
```

1.2 以下参数都配置在文件 /etc/security/limits.conf 中，系统重启后生效,实际使用时要按需配置
```
# End of file
#设置软限制和应限制的 打开文件（Open Files）的限制为65535
root soft nofile 65535
root hard nofile 65535
* soft nofile 65535
* hard nofile 65535

#所有用户允许memlock，通常用于elasticsearch
* hard memlock      unlimited
* soft memlock      unlimited
```


## 2. 内核优化实例

2.1 阿里云Centos7默认内核优化文件 /etc/sysctl.conf 配置如下
```
#vm.swappiness设为0并不会禁止对swap的使用，但会最大限度地降低使用swap的可能性
vm.swappiness = 0
net.ipv4.neigh.default.gc_stale_time = 120

# see details in https://help.aliyun.com/knowledge_detail/39428.html
net.ipv4.conf.all.rp_filter = 0
net.ipv4.conf.default.rp_filter = 0
net.ipv4.conf.default.arp_announce = 2
net.ipv4.conf.lo.arp_announce = 2
net.ipv4.conf.all.arp_announce = 2

# see details in https://help.aliyun.com/knowledge_detail/41334.html
net.ipv4.tcp_max_tw_buckets = 5000
net.ipv4.tcp_syncookies = 1
net.ipv4.tcp_max_syn_backlog = 1024
net.ipv4.tcp_synack_retries = 2

net.ipv6.conf.all.disable_ipv6 = 1
net.ipv6.conf.default.disable_ipv6 = 1
net.ipv6.conf.lo.disable_ipv6 = 1

kernel.sysrq = 1

huixiang8-prod | CHANGED | rc=0 >>
vm.swappiness = 0
net.ipv4.neigh.default.gc_stale_time = 120

# see details in https://help.aliyun.com/knowledge_detail/39428.html
net.ipv4.conf.all.rp_filter = 0
net.ipv4.conf.default.rp_filter = 0
net.ipv4.conf.default.arp_announce = 2
net.ipv4.conf.lo.arp_announce = 2
net.ipv4.conf.all.arp_announce = 2

# see details in https://help.aliyun.com/knowledge_detail/41334.html
net.ipv4.tcp_max_tw_buckets = 5000
net.ipv4.tcp_syncookies = 1
net.ipv4.tcp_max_syn_backlog = 1024
net.ipv4.tcp_synack_retries = 2

net.ipv6.conf.all.disable_ipv6 = 1
net.ipv6.conf.default.disable_ipv6 = 1
net.ipv6.conf.lo.disable_ipv6 = 1

kernel.sysrq = 1

```

2.2 阿里云Centos7默认内核优化文件 /etc/security/limits.conf 配置如下

```
# End of file
root soft nofile 65535
root hard nofile 65535
* soft nofile 65535
* hard nofile 65535
```


参考文档：
* [Linux实例常用内核网络参数介绍与常见问题处理](https://help.aliyun.com/knowledge_detail/41334.html)
* [新服务器上架与LINUX操作系统内核参数调优](https://www.cnblogs.com/hai-better/p/10368475.html)
