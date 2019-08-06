
#!/bin/bash

# Install basic command-line utilities
apt-get update
apt-get install -y --no-install-recommends \
  curl \
  dnsutils \
  file \
  ftp \
  iproute2 \
  iputils-ping \
  locales \
  openssh-client \
  rsync \
  shellcheck \
  sudo \
  telnet \
  time \
  unzip \
  wget \
  zip \
  tzdata 
rm -rf /var/lib/apt/lists/*

# Setup the locale
LANG=en_US.UTF-8
LC_ALL=$LANG
locale-gen $LANG
update-locale

# Install essential build tools
apt-get update
apt-get install -y --no-install-recommends build-essential 
rm -rf /var/lib/apt/lists/*

# Install Azure CLI (instructions taken from https://docs.microsoft.com/en-us/cli/azure/install-azure-cli)
AZ_REPO=$(lsb_release -cs)
echo "deb [arch=arm64] https://packages.microsoft.com/repos/azure-cli/ $AZ_REPO main"  | tee /etc/apt/sources.list.d/azure-cli.list
curl -L https://packages.microsoft.com/keys/microsoft.asc | apt-key add -
apt-get update
apt-get install -y --no-install-recommends apt-transport-https azure-cli 
rm -rf /var/lib/apt/lists/*
rm -rf /etc/apt/sources.list.d/*
az --version

# Install Clang (only appears to work on xenial)
wget -O - https://apt.llvm.org/llvm-snapshot.gpg.key | apt-key add -
apt-add-repository "deb http://apt.llvm.org/xenial/ llvm-toolchain-xenial-6.0 main"
apt-get update
apt-get install -y --no-install-recommends clang-6.0 
rm -rf /var/lib/apt/lists/*
rm -rf /etc/apt/sources.list.d/*

# Install CMake
curl -sL https://cmake.org/files/v3.10/cmake-3.10.2-Linux-x86_64.sh -o cmake.sh && chmod +x cmake.sh
./cmake.sh --prefix=/usr/local --exclude-subdir
rm cmake.sh

# Install Go
curl -sL https://dl.google.com/go/go1.12.7.linux-armv6l.tar.gz -o go1.12.7.linux-armv6l.tar.gz
mkdir -p /usr/local/go1.12.7
tar -C /usr/local/go1.12.7 -xzf go1.12.7.linux-armv6l.tar.gz --strip-components=1 go
rm go1.9.4.linux-amd64.tar.gz
GOROOT=/usr/local/go1.12.7
PATH $PATH:$GOROOT/bin
