# Docker 简介
* Docker 是基于 LXC（Linux Container）技术的容器引擎，把应用和依赖环境打包到容器镜像，运行镜像可以生成容器，适合动态扩容和微服务架构。
* Docker 可以看做轻量的虚拟化，容器共享宿主机内核，启动快，资源占用少。
* 操作系统启动内核后会挂载 root 文件系统，docker 镜像就相当于一个 root 文件系统
* 镜像使用 Union Fs 分层存储，每一层构建完不再发生改变，后一层的删除动作也不会真的删除上一层的文件，只做删除标记

# Docker最佳实践
* 不要安装不必要的包，安装包后清理缓存，减少镜像大小和构建时间
* 用最少的层构建镜像，目前只有RUN，COPY，ADD会创建新的层，其他命令会创建临时的镜像
* 合理使用父镜像和缓存
* 长命令的参数使用多行分开，使命令清晰易读
* Dockerfile 常用指令：FROM，RUN，EXPOSE，ENV，COPY，ENTRYPOINT，VOLUME，USER

# Docker 生产环境的使用
