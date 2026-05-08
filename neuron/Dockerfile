FROM ubuntu:20.04

# Set working directory
WORKDIR /app

ENV DEBIAN_FRONTEND=noninteractive

#  预设时区信息（可选，如果不设置通常默认为 UTC）
RUN ln -fs /usr/share/zoneinfo/Asia/Shanghai /etc/localetime && \
    echo "Asia/Shanghai" > /etc/timezone

RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    git \
    curl \
    wget \
    pkg-config \
    autoconf \
    automake \
    libtool \
    ca-certificates \
    apt-utils \
    && rm -rf /var/lib/apt/lists/*

# Copy the dependencies script first to cache the layer
COPY emqx-neuron/install_dependencies.sh /app/

# The script uses sudo, which is fine since we installed it.
# We also need to fix potential issues with cloning if git is not configured, but it should be fine.
RUN chmod +x install_dependencies.sh && ./install_dependencies.sh

ENTRYPOINT ["bash"]
