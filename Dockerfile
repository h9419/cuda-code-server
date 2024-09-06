FROM nvidia/cuda:12.6.1-cudnn-devel-ubuntu24.04
# FROM pytorch/pytorch:2.4.1-cuda12.4-cudnn9-devel
# FROM pytorch/pytorch:2.0.1-cuda11.7-cudnn8-devel

# Install dependencies
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get update -y \
  && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
  curl \
  ca-certificates \
  dumb-init \
  nvtop htop btop \
  sudo \
  git \
  bzip2 \
  libx11-6 \
  locales \
  man \
  nano \
  git \
  procps \
  openssh-client \
  vim \
  lsb-release \
  libomp-dev \
  mpich \
  libmpich-dev \
  build-essential \
  && rm -rf /var/lib/apt/lists/*

RUN sed -i "s/# en_US.UTF-8/en_US.UTF-8/" /etc/locale.gen \
  && locale-gen
ENV LANG=en_US.UTF-8 \
    USER=coder \
    HOME=/home/coder \
    ARCH=amd64 \
    # EXTENSIONS_GALLERY="{\"serviceUrl\":\"https://marketplace.visualstudio.com/_apis/public/gallery\",\"itemUrl\":\"https://marketplace.visualstudio.com/items\"}" \
    CODE_SERVER_VERSION=4.92.2

# Create project directory
RUN mkdir /projects

# Create a non-root user
RUN adduser --disabled-password --gecos '' --shell /bin/bash coder \
  && chown -R coder:coder /projects \
  && echo "coder ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/90-coder

# Install fixuid
RUN curl -fsSL "https://github.com/boxboat/fixuid/releases/download/v0.4.1/fixuid-0.4.1-linux-$ARCH.tar.gz" | tar -C /usr/local/bin -xzf - && \
  chown root:root /usr/local/bin/fixuid && \
  chmod 4755 /usr/local/bin/fixuid && \
  mkdir -p /etc/fixuid && \
  printf "user: coder\ngroup: coder\n" > /etc/fixuid/config.yml

# Install code-server
WORKDIR /tmp
RUN curl -fOL https://github.com/cdr/code-server/releases/download/v${CODE_SERVER_VERSION}/code-server_${CODE_SERVER_VERSION}_${ARCH}.deb \
  && dpkg -i ./code-server_${CODE_SERVER_VERSION}_${ARCH}.deb && rm ./code-server_${CODE_SERVER_VERSION}_${ARCH}.deb
COPY ./entrypoint.sh /usr/bin/entrypoint.sh

# Switch to default user
USER coder
WORKDIR /projects

EXPOSE 8080
ENTRYPOINT ["/usr/bin/entrypoint.sh", "--bind-addr", "0.0.0.0:8080", "--disable-telemetry", "."]