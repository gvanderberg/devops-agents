#!/bin/bash

CODENAME=$(lsb_release -cs)
RELEASE=$(lsb_release -rs)

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
        libgtk2.0-0 \
        libgtk-3-0 \
        libnotify-dev \
        libgconf-2-4 \
        libnss3 \
        libxss1 \
        libasound2 \
        libxtst6 \
        locales \
        openssh-client \
        rsync \
        shellcheck \
        sudo \
        telnet \
        time \
        tzdata \
        unixodbc-dev \
        unzip \
        wget \
        xauth \
        xvfb \
        zip 
rm -rf /var/lib/apt/lists/*

echo
echo 2\) Setup the locale
echo

export LANG=en_US.UTF-8
export LC_ALL=$LANG
locale-gen $LANG
update-locale LANG=$LANG

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

echo
echo 5\) Install Google Chrome
echo

wget -qO - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - 
echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" | tee /etc/apt/sources.list.d/google-chrome.list 
apt-get update && \
    apt-get install -y google-chrome-stable
rm -rf /var/lib/apt/lists/* 
rm -rf /etc/apt/sources.list.d/*

echo
echo 6\) Install Docker
echo

# Install Docker
curl -fsSL https://get.docker.com | bash
usermod azuresupport -aG docker
cat <<EOF >/etc/docker/daemon.json
{
    "bip": "10.200.0.1/24"
}
EOF
service docker restart
docker version

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
curl -sSLO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl
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

curl -sSLO https://dotnet.microsoft.com/download/dotnet-core/scripts/v1/dotnet-install.sh
chmod +x ./dotnet-install.sh
mkdir -p /usr/share/dotnet
./dotnet-install.sh --install-dir /usr/share/dotnet --version 2.1.802 --verbose
./dotnet-install.sh --install-dir /usr/share/dotnet --version 2.2.402 --verbose
./dotnet-install.sh --install-dir /usr/share/dotnet --version 3.0.100 --verbose
./dotnet-install.sh --install-dir /usr/share/dotnet --version 3.1.100 --verbose
./dotnet-install.sh --install-dir /usr/share/dotnet --version 3.1.200 --verbose
./dotnet-install.sh --install-dir /usr/share/dotnet --version 3.1.201 --verbose
./dotnet-install.sh --install-dir /usr/share/dotnet --version 3.1.202 --verbose
./dotnet-install.sh --install-dir /usr/share/dotnet --version 3.1.300 --verbose
./dotnet-install.sh --install-dir /usr/share/dotnet --version 3.1.302 --verbose
./dotnet-install.sh --install-dir /usr/share/dotnet --version 3.1.401 --verbose
./dotnet-install.sh --install-dir /usr/share/dotnet --version 3.1.402 --verbose
./dotnet-install.sh --install-dir /usr/share/dotnet --version 3.1.403 --verbose
./dotnet-install.sh --install-dir /usr/share/dotnet --version 3.1.404 --verbose
./dotnet-install.sh --install-dir /usr/share/dotnet --version 5.0.100 --verbose
ln -s /usr/share/dotnet/dotnet /usr/bin/dotnet
dotnet --version

echo
echo 11\) Install Node.js
echo

# Install LTS Node.js and related tools
wget -qO- https://deb.nodesource.com/setup_12.x | bash
apt-get update && \
    apt-get install -y --no-install-recommends nodejs && \
    npm install -g bower && \
    npm install -g grunt && \
    npm install -g gulp && \
    npm install -g n && \
    npm install -g webpack webpack-cli --save-dev && \
    npm install -g parcel-bundler && \
    npm i -g npm 
rm -rf /var/lib/apt/lists/* 
node --version

echo
echo 12\) Install Powershell Core
echo

wget -q https://packages.microsoft.com/config/ubuntu/$RELEASE/packages-microsoft-prod.deb
dpkg -i packages-microsoft-prod.deb
apt-get update && \
    apt-get install -y powershell
pwsh -v

echo
echo 13\) Install AzCopy
echo

wget -q https://aka.ms/downloadazcopy-v10-linux
tar -xvf downloadazcopy-v10-linux
rm /usr/bin/azcopy
cp ./azcopy_linux_amd64_*/azcopy /usr/bin/
rm ./azcopy_linux_amd64_*
chmod +x /usr/bin/azcopy
azcopy -v

echo
echo 14\) Install Terraform
echo

wget https://releases.hashicorp.com/terraform/0.12.13/terraform_0.12.13_linux_amd64.zip
unzip ./terraform_0.12.13_linux_amd64.zip -d /usr/local/bin/
terraform --version

echo
echo 15\) Install yarn
echo

curl -fsSL https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - 
echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list 
apt-get update && \
    apt-get install -y --no-install-recommends \
        yarn 
rm -rf /var/lib/apt/lists/* 
rm -rf /etc/apt/sources.list.d/*

echo
echo 16\) Install Mono
echo

# Install Mono
apt-get update && \
    apt-get install -y --no-install-recommends \
        mono-complete
rm -rf /var/lib/apt/lists/*
mono --version

echo
echo 17\) Install Python
echo

# Install Python
#add-apt-repository -y ppa:deadsnakes/ppa
#apt-get update && \
#    apt-get install -y --no-install-recommends \
#        python2.7 \
#        python3.5 \
#        python3.6 \
#        python3.7

apt-get update && \
    apt-get install -y --no-install-recommends \
        python3 \
        python3-dev \
        python3-pip
 rm -rf /var/lib/apt/lists/*

## 16.04 begin
# add-apt-repository ppa:deadsnakes/ppa
# apt-get update && \
#     apt-get install -y --no-install-recommends \
#         python3.7
# ln -sf /usr/bin/python3.7 /usr/bin/python3
# apt-get -y install python3-pip
# python3 -m pip install --upgrade pip
# pip install --upgrade pip
## 16.04 end

echo
echo 18\) Install Trivy
echo

wget -qO - https://aquasecurity.github.io/trivy-repo/deb/public.key | apt-key add - 
echo "deb https://aquasecurity.github.io/trivy-repo/deb $CODENAME main" | tee -a /etc/apt/sources.list.d/trivy.list
apt-get update && \
    apt-get install -y --no-install-recommends \
        trivy 
rm -rf /var/lib/apt/lists/* 
rm -rf /etc/apt/sources.list.d/*
trivy -v

echo
echo 19\) Clean system
echo

apt-get clean 
rm -rf /var/lib/apt/lists/* 
rm -rf /etc/apt/sources.list.d/*
