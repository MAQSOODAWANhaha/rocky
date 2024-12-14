# 基础镜像
FROM rockylinux:9.3

# 添加元数据
LABEL maintainer="zhanglei520sl@126.com" \
      description="Rocky Linux 9.3 基础镜像，配置中国源" \
      version="1.0"

# 设置时区为中国时区
ENV TZ=Asia/Shanghai
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# 配置中国镜像源并安装必要软件
# 合并多个 RUN 命令以减少镜像层数
RUN sed -i 's|^mirrorlist=|#mirrorlist=|g' /etc/yum.repos.d/rocky.repo && \
    sed -i 's|^#baseurl=http://download.rockylinux.org/pub/rocky/9/BaseOS|baseurl=https://mirrors.tuna.tsinghua.edu.cn/rockylinux/9/BaseOS|g' /etc/yum.repos.d/rocky.repo && \
    sed -i 's|^#baseurl=http://download.rockylinux.org/pub/rocky/9/AppStream|baseurl=https://mirrors.tuna.tsinghua.edu.cn/rockylinux/9/AppStream|g' /etc/yum.repos.d/rocky.repo && \
    dnf update -y && \
    dnf install -y epel-release dump-init && \
    dnf install -y procps curl iproute && \
    dnf clean all && \
    rm -rf /var/cache/dnf

# 设置容器启动命令
ENTRYPOINT ["dump-init"]

CMD ["bash"]
