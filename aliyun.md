## 阿里云概述

* 云服务平台
* 云资源的自动化管理可以使用 terraform，实现 infrastructure as code

## 云服务器ECS
云服务器ECS（Elastic Compute Service）是一种简单高效、处理能力可弹性伸缩的计算服务。
* 使用不同跳板机管理不同环境的服务器
* 服务器 hostname 命名要规范，例如web01.us-west-2.prod.crittercism.com
* 服务器镜像使用自定义的镜像，方便自定义
* 重要 ECS 服务器定期做快照做备份
* 安全组按服务器角色划分，需要单独设置规则的服务器可以单独建立一个安全组
* 安全组按最小权限原则设置规则

## 容器服务Kubernetes版
阿里云 Kubernetes 容器服务，可以通过容器服务管理控制台创建一个安全高可用的 Kubernetes 集群，整合阿里云虚拟化、存储、网络和安全能力，提供高性能可伸缩的容器应用管理能力
* 容器集群，支持标准专有版集群、托管集群、serverless集群
* 日志管理，可以使用阿里云日志，也可以利用 Log-Pilot + Elasticsearch + Kibana 搭建 kubernetes 日志解决方案
* Ingress 可用于配置提供外部可访问的 URL、负载均衡、SSL、基于名称的虚拟主机等
## NAT网关
NAT网关（ NAT Gateway ）是一款企业级的VPC公网网关，提供NAT代理（ SNAT 和 DNAT ）
* DNAT，将 NAT 网关上的公网 IP 映射给ECS实例使用，使ECS实例能够提供互联网服务。DNAT 支持端口映射和IP映射。
* SNAT，为 VPC 内无公网IP的ECS实例提供访问互联网的代理服务

## 负载均衡
负载均衡（Server Load Balancer）是将访问流量根据转发策略分发到后端多台云服务器（ECS实例）的流量分发控制服务。负载均衡扩展了应用的服务能力，增强了应用的可用性。
* 后端服务器可以使用默认服务器组、虚拟服务器组、主备服务器
* 支持绑定SSL证书

## 阿里云域名DNS
* 不同的环境测试、生产等可以使用不同的域名区分
多个域名指向一个ip，可以使用cname指向同一个A记录
* 域名解析支持批量导入导出，很方便
## API网关

## 专用网络VPC
测试、预生产、生产环境使用VPC做网络隔离,需要时不同 VPC 网络可以使用高速通道打通

## 云数据库redis

## 对象存储OSS

## 弹性公网IP

## 日志服务

## CDN

## WAF防火墙

## NAS


## EDAS
* [制作容器镜像规范](https://helpcdn.aliyun.com/document_detail/84095.html?spm=a2c4g.11186623.6.719.63b75506TR0KKN#section-l2l-spe-ukz)
