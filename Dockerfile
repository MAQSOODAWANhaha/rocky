FROM rockylinux:9.3

LABEL maintainer="zhanglei520sl@126.com" \
      description="Rocky Linux 9.3 基础镜像，配置中国源" \
      version="1.0"

# 设置时区为中国时区
ENV TZ=Asia/Shanghai
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN dnf clean all && \
    sed -i 's|^mirrorlist=|#mirrorlist=|g' /etc/yum.repos.d/rocky*.repo && \
    sed -i 's|^#baseurl=http://dl.rockylinux.org/$contentdir|baseurl=https://mirrors.aliyun.com/rockylinux|g' /etc/yum.repos.d/rocky*.repo && \
    dnf makecache && \
    dnf update -y && \
    dnf install -y epel-release && \
    dnf install -y procps iproute dumb-init && \
    dnf clean all && \
    rm -rf /var/cache/dnf

# 设置容器启动命令
ENTRYPOINT ["dumb-init", "--"]

CMD ["bash"]
