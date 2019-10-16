Set-ExecutionPolicy Bypass -Scope Process -Force
Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

choco install -y azure-cli
choco install -y dotnetcore-sdk
choco install -y git.install
choco install -y jdk8
choco install -y kubernetes-cli
choco install -y kubernetes-helm
choco install -y nodejs-lts
choco install -y powershell-core
choco install -y terraform
choco install -y yarn
choco install -y visualstudio2019enterprise --package-parameters "--add Microsoft.VisualStudio.Workload.CoreEditor --add Microsoft.VisualStudio.Workload.ManagedDesktop --add Microsoft.VisualStudio.Workload.NetCoreTools --add Microsoft.VisualStudio.Workload.NetCrossPlat --add Microsoft.VisualStudio.Workload.NetWeb --add Microsoft.VisualStudio.Workload.Node --passive --locale en-US"
