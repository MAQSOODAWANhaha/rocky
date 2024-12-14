# 基础镜像
FROM rockylinux:9.3

# 添加元数据
LABEL maintainer="zhanglei520sl@126.com" \
      description="Rocky Linux 9.3 基础镜像，配置中国源" \
      version="1.0"

# 设置时区为中国时区
ENV TZ=Asia/Shanghai
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN dnf update -y && \
    dnf install -y epel-release dump-init && \
    dnf install -y procps curl iproute && \
    dnf clean all && \
    rm -rf /var/cache/dnf

# 设置容器启动命令
ENTRYPOINT ["dump-init"]

CMD ["bash"]
