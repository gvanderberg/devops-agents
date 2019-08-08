#!/bin/bash

AZ_REPO=$(lsb_release -cs)

echo
echo 1\) Install Recommended
echo

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

echo
echo 2\) Setup the locale
echo

# Setup the locale
export LANG=en_US.UTF-8
export LC_ALL=$LANG
locale-gen $LANG
update-locale

echo
echo 3\) Install Build Tools
echo

# Install essential build tools
apt-get update
apt-get install -y --no-install-recommends build-essential 
rm -rf /var/lib/apt/lists/*

echo
echo 4\) Install Azure CLI
echo

# Install Azure CLI (instructions taken from https://docs.microsoft.com/en-us/cli/azure/install-azure-cli)
# echo "deb [arch=arm64] https://packages.microsoft.com/repos/azure-cli/ $AZ_REPO main"  | tee /etc/apt/sources.list.d/azure-cli.list
# curl -L https://packages.microsoft.com/keys/microsoft.asc | apt-key add -
# apt-get update
# apt-get install -y --no-install-recommends apt-transport-https azure-cli 
# rm -rf /var/lib/apt/lists/*
# rm -rf /etc/apt/sources.list.d/*
# az --version

echo
echo 5\) Install Clang
echo

# Install Clang
apt-get update
apt-get install -y --no-install-recommends clang-6.0 
rm -rf /var/lib/apt/lists/*
rm -rf /etc/apt/sources.list.d/*

echo
echo 6\) Install CMake
echo

# Install CMake
# curl -sL https://cmake.org/files/v3.10/cmake-3.10.2-Linux-x86_64.sh -o cmake.sh && chmod +x cmake.sh
# ./cmake.sh --prefix=/usr/local --exclude-subdir
# rm cmake.sh
# apt-get install -y --no-install-recommends cmake
# rm -rf /var/lib/apt/lists/*
# rm -rf /etc/apt/sources.list.d/*

echo
echo 7\) Install GO
echo

# Install Go
curl -sL https://dl.google.com/go/go1.12.7.linux-armv6l.tar.gz -o go1.12.7.linux-armv6l.tar.gz
mkdir -p /usr/local/go1.12.7
tar -C /usr/local/go1.12.7 -xzf go1.12.7.linux-armv6l.tar.gz --strip-components=1 go
rm go1.12.7.linux-armv6l.tar.gz
export GOROOT=/usr/local/go1.12.7
export PATH=$PATH:$GOROOT/bin

echo
echo 8\) Install Google Chrome
echo

# Install Google Chrome
# wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -
# echo "deb [arch=arm64] http://dl.google.com/linux/chrome/deb/ stable main" | tee /etc/apt/sources.list.d/google-chrome.list
# apt-get update
# apt-get install -y --no-install-recommends google-chrome-stable 
# rm -rf /var/lib/apt/lists/*
# rm -rf /etc/apt/sources.list.d/*

echo
echo 9\) Install Docker
echo

# Install Docker
apt-get install -y --no-install-recommends docker.io
docker --version

echo
echo 10\) Install Helm
echo

# Install Helm
curl https://raw.githubusercontent.com/kubernetes/helm/master/scripts/get | bash
helm version --client

echo
echo 11\) Install Kubectl
echo

# Install kubectl
curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/arm64/kubectl
chmod +x ./kubectl
mv ./kubectl /usr/local/bin/kubectl
kubectl version --client

echo
echo 12\) Install Mono
echo

# Install Mono
apt-get install gnupg ca-certificates
apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF
echo "deb https://download.mono-project.com/repo/ubuntu stable-$AZ_REPO main" | tee /etc/apt/sources.list.d/mono-official-stable.list
apt-get update
apt-get install -y --no-install-recommends mono-complete
rm -rf /var/lib/apt/lists/*
rm -rf /etc/apt/sources.list.d/*
mono --version

echo
echo 13\) Install Install .NET Core SDK
echo

# Install .NET Core SDK and initialize package cache
wget https://download.visualstudio.microsoft.com/download/pr/1560f31a-d566-4de0-9fef-1a40b2b2a748/163f23fb8018e064034f3492f54358f1/dotnet-sdk-2.2.401-linux-arm64.tar.gz
mkdir -p /usr/share/dotnet
tar -zxf dotnet-sdk-2.2.401-linux-arm64.tar.gz -C /usr/share/dotnet
ln -s /usr/share/dotnet/dotnet /usr/bin/dotnet
dotnet --version

echo
echo 14\) Install Node.js
echo

# Install LTS Node.js and related tools
wget -qO- https://deb.nodesource.com/setup_10.x | sudo -E bash -
sudo apt-get install -y --no-install-recommends nodejs
node --version

echo
echo 15\) Clean up
echo

apt-get clean
rm -rf /var/lib/apt/lists/*
rm -rf /etc/apt/sources.list.d/*
