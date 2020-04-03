## 硬件 概述
 

目前主流的服务器型号lenovo System x3650 M5， dell 740


VMware vSphere为虚拟机分配的CPU数是指逻辑处理器数。每台主机（服务器）拥有的逻辑处理器总数是不一样的，为物理CPU数量×每CPU的核(Core)数×超线程因子，当硬件支持超线程且在BIOS中开启超线程时，超线程因子为2，否则为1。例如某服务器为4C 8核并且支持超线程时，其CPU内核只有4×8＝32个，插槽数即CPU数＝4，vSphere可分配的该主机逻辑处理器数为4×8×2＝64

























 参考文档：
* [vSphere正确分配虚拟机CPU资源](https://www.iyunv.com/thread-64501-1-1.html)
* [CPU逻辑数量、CPU物理核心、几核几线程简述](https://blog.csdn.net/qq_41800366/article/details/85870767)


