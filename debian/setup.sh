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

echo
echo 4\) Install Azure CLI
echo

curl -sL https://aka.ms/InstallAzureCLIDeb | bash
az --version
