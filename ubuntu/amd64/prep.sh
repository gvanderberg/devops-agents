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
    rsync\
    shellcheck \
    sudo \
    telnet \
    time \
    unzip \
    wget \
    zip \
    tzdata \
    && rm -rf /var/lib/apt/lists/*

echo
echo 2\) Setup the locale
echo

export LANG=en_US.UTF-8
export LC_ALL=$LANG
locale-gen $LANG
update-locale

echo
echo 3\) Install Build Tools
echo

apt-get update
apt-get install -y --no-install-recommends build-essential 
rm -rf /var/lib/apt/lists/*

echo
echo 4\) Install Azure CLI
echo

echo "deb [arch=amd64] https://packages.microsoft.com/repos/azure-cli/ $(lsb_release -cs) main" | tee /etc/apt/sources.list.d/azure-cli.list
curl -L https://packages.microsoft.com/keys/microsoft.asc | apt-key add - \
apt-get update
apt-get install -y --no-install-recommends apt-transport-https azure-cli
rm -rf /var/lib/apt/lists/* 
rm -rf /etc/apt/sources.list.d/* 
az --version

echo
echo 5\) Install Clang
echo

wget -O - https://apt.llvm.org/llvm-snapshot.gpg.key | apt-key add -
apt-add-repository "deb http://apt.llvm.org/xenial/ llvm-toolchain-xenial-6.0 main"
apt-get update
apt-get install -y --no-install-recommends clang-6.0 
rm -rf /var/lib/apt/lists/* 
rm -rf /etc/apt/sources.list.d/* || echo -n

echo
echo 6\) Install CMake
echo

curl -sL https://cmake.org/files/v3.10/cmake-3.10.2-Linux-x86_64.sh -o cmake.sh 
chmod +x cmake.sh 
./cmake.sh --prefix=/usr/local --exclude-subdir 
rm cmake.sh

echo
echo 7\) Install Google Chrome
echo

wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - 
echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" | tee /etc/apt/sources.list.d/google-chrome.list 
apt-get update
apt-get install -y google-chrome-stable
rm -rf /var/lib/apt/lists/* 
rm -rf /etc/apt/sources.list.d/*

echo
echo 8\) Install Docker
echo

# Install Docker
apt-get install -y --no-install-recommends docker.io
docker --version

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
curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl
chmod +x ./kubectl
mv ./kubectl /usr/local/bin/kubectl
kubectl version --client

echo
echo 11\) Install Java OpenJDKs
echo

apt-add-repository -y ppa:openjdk-r/ppa
apt-get update
apt-get install -y --no-install-recommends openjdk-11-jdk
rm -rf /var/lib/apt/lists/*
apt-get update
apt-get install -y --no-install-recommends openjdk-12-jdk
rm -rf /var/lib/apt/lists/*

echo
echo 12\) Install Mono
echo

apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF 
echo "deb https://download.mono-project.com/repo/ubuntu stable-xenial main" | tee /etc/apt/sources.list.d/mono-official-stable.list 
apt-get update 
apt-get install -y --no-install-recommends apt-transport-https mono-complete 
rm -rf /var/lib/apt/lists/* 
rm -rf /etc/apt/sources.list.d/*
mono --version

echo
echo 13\) Install .NET Core SDK
echo

curl https://packages.microsoft.com/config/ubuntu/16.04/packages-microsoft-prod.deb > packages-microsoft-prod.deb 
dpkg -i packages-microsoft-prod.deb
rm packages-microsoft-prod.deb 
apt-get update 
apt-get install -y --no-install-recommends apt-transport-https dotnet-sdk-2.2 
rm -rf /var/lib/apt/lists/* 
rm -rf /etc/apt/sources.list.d/*
dotnet --version

echo
echo 14\) Install AzCopy
echo

apt-key adv --keyserver packages.microsoft.com --recv-keys EB3E94ADBE1229CF 
echo "deb [arch=amd64] https://packages.microsoft.com/repos/microsoft-ubuntu-xenial-prod/ xenial main" | tee /etc/apt/sources.list.d/azure.list 
apt-get update 
apt-get install -y --no-install-recommends azcopy 
rm -rf /var/lib/apt/lists/* 
rm -rf /etc/apt/sources.list.d/*

echo
echo 15\) Install Node.js
echo

curl -sL https://git.io/n-install | bash -s -- -ny - && ~/n/bin/n lts 
npm install -g bower 
npm install -g grunt 
npm install -g gulp 
npm install -g n 
npm install -g webpack webpack-cli --save-dev 
npm install -g parcel-bundler 
npm i -g npm 
rm -rf ~/n
node --version

echo
echo 16\) Install Powershell Core
echo

curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add - 
curl https://packages.microsoft.com/config/ubuntu/16.04/prod.list | tee /etc/apt/sources.list.d/microsoft.list 
apt-get update 
apt-get install -y --no-install-recommends powershell 
rm -rf /var/lib/apt/lists/* 
rm -rf /etc/apt/sources.list.d/*

echo
echo 17\) Install yarn
echo

curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - 
echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list 
apt-get update 
apt-get install -y --no-install-recommends yarn 
rm -rf /var/lib/apt/lists/* 
rm -rf /etc/apt/sources.list.d/*

echo
echo 18\) Clean system
echo

apt-get clean 
rm -rf /var/lib/apt/lists/* 
rm -rf /etc/apt/sources.list.d/*
