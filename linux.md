# Linux系统
## Linux启动过程
1. BIOS: BIOS位于主板上的Rom芯片中，会检查硬件和加载执行MBR中的Bootloader
2. MBR: Master Boot  Record，主引导记录，存储于磁盘的头部，存储BootLoader程序和分区表信息，加载并执行GRUB
3. GRUB: 执行/etc/grub.conf 加载内核镜像到内存
4. Kernel: Kernel运行后会挂载根文件系统rootfs，rootfs主要包含目录 /etc/,  /bin/,  /sbin/,  /lib/,  /dev/
5. Init: 启动系统初始化进程，Centos7 采用systemd
6. Runlevel: 不同的运行级别启动不同的服务

## SSH登录原理
### 密码口令 登录流程
1. 客户端连接服务器后，服务器把公钥传给客户端
2. 客户端输入服务器密码，密码通过公钥加密后传给服务器
3. 服务器根据自己的私钥解密登录密码，如果正确就允许客户端登录

### 秘钥 登录流程
1. 客户端生成RSA（非对称加密算法）公钥 ~/.ssh/id_rsa.pub 和私钥 ~/.ssh/id_rsa
2. 把客户端的公钥文件内容存放到服务器 ~/.ssh/authorized_keys 文件中
3. 客户端请求连接服务器，服务器将一个随机字符串发给客户端
4. 客户端用客户端的私钥加密这个随机字符串之后发给服务器
5. 服务器接收到加密后的字符串，用客户端的公钥解密，如果正确就让客户端登录，这样就不需要密码了


# Linux 内核优化

Linux内核优化需要根据服务器角色的不同按需优化

## 1. 常用的内核优化参数分类和解释

1.1 配置文件 /etc/sysctl.conf
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

1.2 配置文件 /etc/security/limits.conf
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

2.1 配置文件 /etc/sysctl.conf 阿里云Centos7默认配置
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

2.2  配置文件 /etc/security/limits.conf 阿里云Centos7默认配置
```
# End of file
root soft nofile 65535
root hard nofile 65535
* soft nofile 65535
* hard nofile 65535
```
2.3  配置文件 /etc/sysctl.conf 某生产环境mysql8 数据库服务器 
```
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

#阿里云默认配置后增加如下配置
kernel.shmall=4294967296
net.core.rmem_default=126976
net.core.wmem_default=126976
net.core.wmem_max=16777216
net.core.rmem_max=16777216
net.ipv4.tcp_mem=8192 87380 16777216
net.ipv4.tcp_wmem=8192 65536 16777216
net.ipv4.tcp_rmem=8192 87380 16777216

net.ipv4.tcp_no_metrics_save=0
net.ipv4.tcp_moderate_rcvbuf=1
net.ipv4.tcp_fin_timeout=5
net.ipv4.tcp_keepalive_time=300
net.ipv4.tcp_syncookies=0
net.ipv4.tcp_sack=1
net.ipv4.tcp_tw_reuse=1
net.ipv4.ip_local_port_range=10250 65000
net.ipv4.tcp_max_syn_backlog=81920
net.ipv4.tcp_max_tw_buckets=1600000
net.ipv4.tcp_synack_retries=2
net.ipv4.tcp_syn_retries=2
net.ipv4.tcp_retries2=2
net.ipv4.tcp_window_scaling=1
net.ipv4.tcp_timestamps=1
fs.file-max=1000000
vm.swappiness=0
vm.max_map_count=262144

# mongodb
vm.dirty_ratio=100
vm.dirty_background_ratio=10
vm.dirty_expire_centisecs=5000
vm.vfs_cache_pressure=200

# redis
vm.overcommit_memory=1
net.core.somaxconn=32768
```
2.4 配置文件 /etc/sysctl.conf 某生产环境 mysql5.7 数据库服务器
```

net.ipv6.conf.all.disable_ipv6 = 1
net.ipv6.conf.default.disable_ipv6 = 1
net.ipv6.conf.lo.disable_ipv6 = 1

vm.swappiness = 0
net.ipv4.neigh.default.gc_stale_time=120


# see details in https://help.aliyun.com/knowledge_detail/39428.html
net.ipv4.conf.all.rp_filter=0
net.ipv4.conf.default.rp_filter=0
net.ipv4.conf.default.arp_announce = 2
net.ipv4.conf.lo.arp_announce=2
net.ipv4.conf.all.arp_announce=2


# see details in https://help.aliyun.com/knowledge_detail/41334.html
net.ipv4.tcp_max_tw_buckets = 5000
net.ipv4.tcp_syncookies = 1
net.ipv4.tcp_max_syn_backlog = 1024
net.ipv4.tcp_synack_retries = 2


#阿里云默认配置后增加如下配置
#共享内存最大大小，单位：字节
kernel.shmall = 34359738368
kernel.shmmax = 34359738368
#共享内存段最大数量
kernel.shmmni = 4096
#异步I/O的最大数量
fs.aio-max-nr = 1048576
#打开最大文件数
fs.file-max = 6815744
#IPv4端口范围
net.ipv4.ip_local_port_range = 1024 65500
#套接字接收缓冲区大小
net.core.rmem_default = 262144
net.core.rmem_max = 4194304
net.core.wmem_default = 262144
net.core.wmem_max = 1048586
kernel.sem = 1010 129280 1010 128
kernel.sem = 2010 257280 2010 128
vm.swappiness = 0
vm.zone_reclaim_mode = 0
vm.drop_caches=3
net.ipv4.tcp_max_syn_backlog = 819200
net.core.netdev_max_backlog = 400000
net.core.somaxconn = 4096
net.ipv4.tcp_tw_reuse=1
net.ipv4.tcp_tw_recycle=0

'''

参考文档：
* [Linux实例常用内核网络参数介绍与常见问题处理](https://help.aliyun.com/knowledge_detail/41334.html)
* [新服务器上架与LINUX操作系统内核参数调优](https://www.cnblogs.com/hai-better/p/10368475.html)
* [Nginx10m+高并发内核优化详解]https://zhuanlan.zhihu.com/p/59720083
