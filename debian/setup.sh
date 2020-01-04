#!/bin/bash

AZ_REPO=$(lsb_release -cs)

# initArch discovers the architecture for this system.
initArch() {
  ARCH=$(uname -m)
  case $ARCH in
    armv5*) ARCH="armv5";;
    armv6*) ARCH="armv6";;
    armv7*) ARCH="arm";;
    aarch64) ARCH="arm64";;
    x86) ARCH="386";;
    x86_64) ARCH="amd64";;
    i686) ARCH="386";;
    i386) ARCH="386";;
  esac
}

# initOS discovers the operating system for this system.
initOS() {
  OS=$(echo `uname`|tr '[:upper:]' '[:lower:]')

  case "$OS" in
    # Minimalist GNU for Windows
    mingw*) OS='windows';;
  esac
}

initArch
initOS

echo $ARCH
echo $OS
echo $AZ_REPO

echo
echo 1\) Install Recommended
echo

# Install basic command-line utilities
apt-get update && \
    apt-get install -y --no-install-recommends \
        curl \
        dnsutils \
        file \
        ftp \
        iproute2 \
        iputils-ping \
        locales \
        openssh-client \
        rsync\
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

export LANG=en_ZA.UTF-8
export LC_ALL=$LANG

locale-gen $LANG
update-locale

echo
echo 3\) Install Build Tools
echo

apt-get update && \
    apt-get install -y --no-install-recommends \
        build-essential 
rm -rf /var/lib/apt/lists/*

# echo
# echo 4\) Install Azure CLI
# echo

# apt-get update && \
#     apt-get install -y --no-install-recommends \
#         azure-cli 
# rm -rf /var/lib/apt/lists/*
# az --version

# echo
# echo 5\) Install Google Chrome
# echo

# wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - 
# echo "deb [arch=$ARCH] http://dl.google.com/linux/chrome/deb/ $AZ_REPO main" | tee /etc/apt/sources.list.d/google-chrome.list 
# apt-get update && \
#     apt-get install -y --no-install-recommends \
#       google-chrome-stable
# rm -rf /var/lib/apt/lists/* 
# rm -rf /etc/apt/sources.list.d/*

echo
echo 6\) Install Docker
echo

# Install Docker
curl -fsSL https://get.docker.com | bash

echo
echo 7\) Install Helm
echo

# Install Helm
curl -fsSL https://raw.githubusercontent.com/kubernetes/helm/master/scripts/get | bash
helm version --client

echo
echo 8\) Install Kubectl
echo

# Install kubectl
curl -sSLO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/$ARCH/kubectl
chmod +x ./kubectl
mv ./kubectl /usr/local/bin/kubectl
kubectl version --client

echo
echo 9\) Install Java OpenJDKs
echo

apt-add-repository -y ppa:openjdk-r/ppa
apt-get update && \
    apt-get install -y --no-install-recommends \
        openjdk-8-jdk
rm -rf /var/lib/apt/lists/*
java -version

echo
echo 10\) Install .NET Core SDK
echo

curl -sSLO  https://dotnetwebsite.azurewebsites.net/download/dotnet-core/scripts/v1/dotnet-install.sh
chmod +x ./dotnet-install.sh
mkdir -p /usr/share/dotnet
./dotnet-install.sh --install-dir /usr/share/dotnet --version 2.1.802 --verbose
./dotnet-install.sh --install-dir /usr/share/dotnet --version 2.2.402 --verbose
# ./dotnet-install.sh --install-dir /usr/share/dotnet --version 3.0.100 --verbose
./dotnet-install.sh --install-dir /usr/share/dotnet --version 3.1.100 --verbose
ln -s /usr/share/dotnet/dotnet /usr/bin/dotnet
dotnet --version
