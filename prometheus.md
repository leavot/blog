# Prometheus 概述
Prometheus是有SoundCLoud开发的开源监控告警系统并且带时序数据库，是Kubernetes容器监控的标配，也可用于服务器、中间件等监控

# Prometheus架构图和工作原理
Prometheus Server通过HTTP定时抓取（pull）目标的metrics（指标）数据，如果触发prometheus中配置的告警规则便会推送告警信息到AlertManager，Alertmanager支持多种发送报警的方式如邮件、钉钉、微信

![prometheus architecture](https://prometheus.io/assets/architecture.png) 

# Prometheus的缺点
* 只针对性能和可用性监控，不具备日志监控功能
* 不适合存储大量历史数据，如果需要报表之类的历史数据，建议使用远端存储如OpenTSDB
* Prometheus的监控数据没有对单位进行定义，需要使用者自己区分或者事先定义好所有监控数据单位。
# Prometheus Operator
# Prometheus 监控Kubernetes之服务配置
# Prometheus 监控Kubernetes之监控对象
# Prometheus 监控Kubernetes之数据展现


