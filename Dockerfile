FROM rockylinux:9.3

LABEL maintainer="zhanglei520sl@126.com" \
      description="Rocky Linux 9.3 基础镜像，配置中国源" \
      version="1.0"

# 设置时区为中国时区
ENV TZ=Asia/Shanghai
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# 安装必要软件包
RUN dnf update -y && \
    dnf install -y epel-release && \
    dnf install -y procps curl iproute dump-init && \
    dnf clean all && \
    rm -rf /var/cache/dnf

# 设置容器启动命令
ENTRYPOINT ["/usr/bin/dump-init", "--"]

CMD ["bash"]
