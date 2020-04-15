# Mysql 概述

* 生产环境的msql服务器配置实例 16 核 64G 500G， 


## mysql 常用命令

登录
```
/usr/local/mysql/bin/mysql -uroot -p'abcdpassword' -S /data/3306/tmp/mysql.sock
```
抓包
```
tcpdump -i eth0 -s 0 -l -w - dst port 3306 | strings | perl -e ' while(<>) { chomp; next if /^[^ ]+[ ]*$/; if(/^(SELECT|UPDATE|DELETE|INSERT|SET|COMMIT|ROLLBACK|CREATE|DROP|ALTER)/i) { if (defined $q) { print "$qn"; } $q=$_; } else { $_ =~ s/^[ t]+//; $q.=" $_"; } }'
```


