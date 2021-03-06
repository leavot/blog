
## 监控的主要分类
*  **服务器监控**，CPU、内存、硬盘、网络I/O
* **应用程序监控（APM）** ，主要是对应用程序监控，包括应用程序的状态监控、性能监控、日志监控及调用连跟踪等，开源APM监控工具有Pinpoint、zipkin，国内商业化APM厂商有听云、OneAPM

*  **中间件监控**，包括消息中间件Rabbitmq、Kafka，web服务中间件Tomcat， 缓存中间件 redis、memcached，数据库中间件Mysql、Postgresql。
* **日志监控**， 常见的日志监控黄金组合。fluentd负责采集日志。kafka负责数据，整理合并，避免突发日志流量，直接冲击logstash。logstash负责日志整理，可以完成日志过滤日志修改等功能。elastic search负责日志存储和日志检索，自带分布式存储，可以将采集的日志进行分片存储。给办公室一个日志查询组件负责日志发现。
*  **网络设备监控**，网络设备的监控通常基于snmp。
*  **存储监控**， 监控存储性能、存储系统、存储设备


## Zabbix 概述
Zabbix是目前比较主流的分布式监控系统


## Zabbix架构图和监控的流程
![Zabbix 架构图](https://img2018.cnblogs.com/blog/1479216/201809/1479216-20180915151433992-154130577.png)
Zabbix Server 根据Item（监控项）的Interval从Zabbix Agent获取数据，当Item受到新的数据时，如果有Trigger（触发器）与之关联，那么Zabbix就会根据item的值检查这个Trigger，得出的结果会生成一个Event（事件），如果有符合要求的Action（报警动作），那么就要进行Action中定义的操作。

## Zabbix的几个核心概念
* 主机（Host）：是Zabbix监控对象的抽象，不限于物理服务器，也可能是虚拟机容器或某个网络设备
* 主机组（Host Group）： 是一组主机的集合，主要用于多用户之间的资源隔离
* 条目（Item）：是一个指标的相关监控数据
* 应用（Application）：是一组条目的集合，一个条目可以属于一个或多个应用
* 模板（Template）：用于快速定义被监控主机的预设条目集合，通常包含条目、触发器、视图，应用及服务发现规则、通过将主机关联模板来避免重复配置主机
* 触发器（Trigger）：是Zabbix的告警规则，用于评估某监控对象在某特定条目内接收到的数据是否匹配阈值，如果匹配，则触发器状态从OK转变为Problem，当数据量再次回到合理范围时，触发器状态又将从Problem转变为OK
* 动作（Action）： 是
Zabbix在某个事件发生后执行的动作。事件主要指告警事件、网络发现新主机加入事件、行为主要包括发送邮件通知、执行远程命令或者执行Zabbix的附加动作

## Zabbix的主要组件
* Zabbix Server，负责接收Agent发送的监控信息，并进行汇总存储
* Zabbix Web，Zabbix的GUI组件，提供监控数据的展现和系统配置，主要配置包括监控模板、告警等
* Proxy，可选组件，常用于分布式监控环境中，代理Server收集部分被监控端的监控数据并按照一定的频率统一发往Server端
* Agent，部署在被监控主机上，负责收集本地数据并发往Server端或Agent端，Agent会启动一个名为Agentd的守护进程

## Zabbix 系统和性能优化
* 调大Item的interval
* 使用多个proxy
* mysql数据库的优化，将history分区，关闭housekeeper