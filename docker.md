## Docker 简介
* Docker 是基于 LXC（Linux Container）技术的容器引擎，把应用和依赖环境打包到容器镜像，运行镜像可以生成容器，适合动态扩容和微服务架构。
* Docker 可以看做轻量的虚拟化，容器共享宿主机内核，启动快，资源占用少。
* 操作系统启动内核后会挂载 root 文件系统，docker 镜像就相当于一个 root 文件系统
* 镜像使用 Union Fs 分层存储，每一层构建完不再发生改变，后一层的删除动作也不会真的删除上一层的文件，只做删除标记

## Docker最佳实践
* 不要安装不必要的包，安装包后清理缓存，减少镜像大小和构建时间
* 用最少的层构建镜像，目前只有RUN，COPY，ADD会创建新的层，其他命令会创建临时的镜像
* 合理使用父镜像和缓存
* 长命令的参数使用多行分开，使命令清晰易读
* Dockerfile 常用指令：FROM，RUN，EXPOSE，ENV，COPY，ENTRYPOINT，VOLUME，USER

## Docker 生产环境的使用

## docker compose
使用 Docker Compose 可以轻松、高效的管理容器，它是一个用于定义和运行多容器 Docker 的应用程序工具，通常用于开发环境、自动化测试、单节点部署
下面是一个gitlab编排文件docker-compose-gitlab.yml

```
version: '3'

services:
  gitlab:
    image: "sameersbn/gitlab:10.2.2"
    container_name: gitlab
    hostname: gitlab
    ports:
      - "10888:80"
      - "10222:22"
    environment:
      - DB_ADAPTER=postgresql
      - DB_HOST=postgresql
      - DB_PORT=5432
      - DB_USER=gitlab
      - DB_PASS=password
      - DB_NAME=gitlabhq_production

      - REDIS_HOST=redis
      - REDIS_PORT=6379

      - TZ=Asia/Shanghai
      - SMTP_ENABLED=false
      - SMTP_DOMAIN=www.example.com
      - SMTP_HOST=smtp.gmail.com
      - SMTP_PORT=587
      - SMTP_USER=mailer@example.com
      - SMTP_PASS=password
      - SMTP_STARTTLS=true
      - SMTP_AUTHENTICATION=login
      - GITLAB_TIMEZONE=Kolkata
      - GITLAB_HOST=gitlab.kuaidaoapp.com
      - GITLAB_PORT=80
      - GITLAB_SSH_PORT=22
      - GITLAB_EMAIL=admin@example.com
      - GITLAB_EMAIL_REPLY_TO=noreply@example.com
      - GITLAB_BACKUPS=daily
      - GITLAB_BACKUP_TIME=01:00
      - GITLAB_SECRETS_DB_KEY_BASE=long-and-random-alphanumeric-string
      - GITLAB_SECRETS_SECRET_KEY_BASE=long-and-random-alpha-numeric-string
      - GITLAB_SECRETS_OTP_KEY_BASE=long-and-random-alpha-numeric-string
    restart: always
    volumes:
      - /data/gitlab/gitlab_data:/home/git/data
    links:
      - gitlab-redis:redisio
      - gitlab-postgresql:postgresql
    depends_on:
      - gitlab-postgresql
  gitlab-postgresql:
    image: "registry.cn-hangzhou.aliyuncs.com/acs-sample/postgresql-sameersbn:9.4-24"
    container_name: postgresql
    hostname: postgresql
    environment:
      - DB_USER=gitlab
      - DB_PASS=password
      - DB_NAME=gitlabhq_production
      - DB_EXTENSION=pg_trgm
    restart: always
    volumes:
      - /data/gitlab/postgresql:/var/lib/postgresql

  gitlab-redis:
    image: "registry.cn-hangzhou.aliyuncs.com/acs-sample/redis-sameersbn:latest"
    container_name: redis
    hostname: redis
    restart: always
    volumes:
      - /data/gitlab/redis:/var/lib/redis
```





参考文档：
* [Docker Compose 官方文档](https://docs.docker.com/compose/)
* [sameersbn/docker-gitlab's docker-compose file](https://raw.githubusercontent.com/sameersbn/docker-gitlab/master/docker-compose.yml)