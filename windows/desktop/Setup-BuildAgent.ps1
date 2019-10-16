Set-ExecutionPolicy Bypass -Scope Process -Force
Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

choco install -y docker-desktop
choco install -y jdk8
choco install -y nodejs-lts
choco install -y terraform
choco install -y yarn
