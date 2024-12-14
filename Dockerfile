FROM rockylinux:9.3

LABEL maintainer="zhanglei520sl@126.com" \
      description="Rocky Linux 9.3 基础镜像，配置中国源" \
      version="1.0"

# 设置时区为中国时区
ENV TZ=Asia/Shanghai
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# 配置中国镜像源并安装必要软件
RUN cd /etc/yum.repos.d/ && \
    sed -i -e 's|^mirrorlist=|#mirrorlist=|g' \
           -e 's|^#baseurl=http://dl.rockylinux.org/$contentdir|baseurl=https://mirrors.tuna.tsinghua.edu.cn/rockylinux|g' \
           /etc/yum.repos.d/rocky*.repo && \
    dnf clean all && \
    dnf makecache && \
    dnf update -y && \
    dnf install -y epel-release && \
    dnf install -y procps iproute dumb-init && \
    dnf clean all && \
    rm -rf /var/cache/dnf

# 设置容器启动命令
ENTRYPOINT ["dumb-init", "--"]

CMD ["bash"]
