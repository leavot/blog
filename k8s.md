# Kuberntes 概述
Kubernetes是Google开源的一个容器编排引擎，它支持自动化部署、大规模可伸缩、应用容器化管理。在生产环境中部署一个应用程序时，通常要部署该应用的多个实例以便对应用请求进行负载均衡。

# Master节点
Kubernetes master节点是指管理集群状态的一组进程的集合，使用如 kubectl 的命令行工具，就可以直接与 Kubernetes master 节点进行通信，主要组件如下：
* kube-apiserver
* kube-controller-manager
* kube-scheduler

# Node节点
Node节点用来运行应用，主要运行的进程如下：
* kubelet， 和 master 节点进行通信
* kube-proxy， 一种网络代理，将 Kubernetes 的网络服务代理到每个节点上

# Kubernetes 对象
kuberntes内部的抽象用来表示系统状态，主要对象如下：
* Pod
* Service
* Volume
* Namespace

## Kubernetes 控制器 (controllers)
kubernetes内部的高级抽象，控制器基于基本对象构建并提供额外的功能和方便使用的特性，主要控制器如下：
* ReplicaSet 
* Deployment
* StatefulSet
* Job
