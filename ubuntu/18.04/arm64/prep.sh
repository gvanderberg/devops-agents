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
  git \
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

# echo
# echo 2\) Setup the locale
# echo

# Setup the locale
# export LANG=en_US.UTF-8
# export LC_ALL=$LANG
# locale-gen $LANG
# update-locale

echo
echo 3\) Install Build Tools
echo

# Install essential build tools
apt-get update
apt-get install -y --no-install-recommends build-essential 
rm -rf /var/lib/apt/lists/*

# echo
# echo 4\) Install Azure CLI
# echo

# Install Azure CLI (instructions taken from https://docs.microsoft.com/en-us/cli/azure/install-azure-cli)
# echo "deb [arch=arm64] https://packages.microsoft.com/repos/azure-cli/ $AZ_REPO main"  | tee /etc/apt/sources.list.d/azure-cli.list
# curl -L https://packages.microsoft.com/keys/microsoft.asc | apt-key add -
# apt-get update
# apt-get install -y --no-install-recommends apt-transport-https azure-cli 
# rm -rf /var/lib/apt/lists/*
# rm -rf /etc/apt/sources.list.d/*
# az --version

echo
echo 5\) Install Powershell Core
echo

# Install Powershell Core (instructions taken from https://docs.microsoft.com/en-us/powershell/scripting/install/installing-powershell-core-on-linux?view=powershell-6#raspbian)
apt-get update && \
  apt-get install -y '^libssl1.0.[0-9]$' libunwind8 
wget https://github.com/PowerShell/PowerShell/releases/download/v6.2.3/powershell-6.2.3-linux-arm64.tar.gz
mkdir -p /usr/share/powershell
tar -xvf ./powershell-6.2.3-linux-arm64.tar.gz -C /usr/share/powershell
rm -f ./powershell-6.2.3-linux-arm64.tar.gz
ln -s /usr/share/powershell/pwsh /usr/bin/pwsh
rm -rf /var/lib/apt/lists/*
pwsh --version

# echo
# echo 6\) Install GO
# echo

# Install Go
# curl -sL https://dl.google.com/go/go1.12.7.linux-armv6l.tar.gz -o go1.12.7.linux-armv6l.tar.gz
# mkdir -p /usr/local/go1.12.7
# tar -C /usr/local/go1.12.7 -xzf go1.12.7.linux-armv6l.tar.gz --strip-components=1 go
# rm go1.12.7.linux-armv6l.tar.gz
# export GOROOT=/usr/local/go1.12.7
# export PATH=$PATH:$GOROOT/bin

echo
echo 7\) Install Chromium
echo

# Install chromium-browser
apt-get update && \
  apt-get install -y --no-install-recommends chromium-browser 
rm -rf /var/lib/apt/lists/*

echo
echo 8\) Install Docker
echo

# Install Docker
curl -sSL https://get.docker.com | sh
rm -rf /etc/apt/sources.list.d/*

echo
echo 9\) Install Helm
echo

# Install Helm
curl https://raw.githubusercontent.com/kubernetes/helm/master/scripts/get | bash
helm version --client

echo
echo 10\) Install Kubectl
echo

# Install kubectl
curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/arm64/kubectl
chmod +x ./kubectl
mv ./kubectl /usr/local/bin/kubectl
kubectl version --client

echo
echo 11\) Install Java OpenJDKs
echo

# apt-add-repository -y ppa:openjdk-r/ppa
apt-get update
apt-get install -y --no-install-recommends openjdk-8-jdk
rm -rf /var/lib/apt/lists/*
java -version

echo
echo 12\) Install Install .NET Core SDK
echo

# Install .NET Core SDK and initialize package cache
apt-get update
apt-get install -y liblttng-ust0 \
    libcurl4 \
    libssl1.0.0 \
    libkrb5-3 \
    zlib1g \
    libicu60 
curl -LO  https://dotnetwebsite.azurewebsites.net/download/dotnet-core/scripts/v1/dotnet-install.sh
chmod +x ./dotnet-install.sh
mkdir -p /usr/share/dotnet
./dotnet-install.sh --install-dir /usr/share/dotnet --version 2.1.802 --verbose
./dotnet-install.sh --install-dir /usr/share/dotnet --version 2.2.402 --verbose
./dotnet-install.sh --install-dir /usr/share/dotnet --version 3.0.100 --verbose
ln -s /usr/share/dotnet/dotnet /usr/bin/dotnet
dotnet --version

echo
echo 13\) Install Node.js
echo

# Install LTS Node.js and related tools
wget -qO- https://deb.nodesource.com/setup_12.x | -E bash -
apt-get update && apt-get install -y --no-install-recommends nodejs
node --version

echo
echo 14\) Install Yarn
echo

# Install yarn
curl -sL https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
apt-get update && apt-get install -y --no-install-recommends yarn
rm -rf /etc/apt/sources.list.d/*
yarn --version

echo
echo 15\) Clean up
echo

apt-get clean
rm -rf /var/lib/apt/lists/*
rm -rf /etc/apt/sources.list.d/*
