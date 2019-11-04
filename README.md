# devops-agents

#### Test
```
curl -sLSf https://raw.githubusercontent.com/gvanderberg/devops-agents/master/test.sh | sudo sh
```

### Raspberry Pi
##### Buster
```
curl -sLSf https://raw.githubusercontent.com/gvanderberg/devops-agents/master/raspbian/buster/prep.sh | sudo sh
```
##### Stretch
```
curl -sLSf https://raw.githubusercontent.com/gvanderberg/devops-agents/master/raspbian/stretch/prep.sh | sudo sh
```

### Ubuntu
##### AMD64
```
curl -sLSf https://raw.githubusercontent.com/gvanderberg/devops-agents/master/ubuntu/18.04/amd64/prep.sh | sudo sh
```
##### ARM64
```
curl -sLSf https://raw.githubusercontent.com/gvanderberg/devops-agents/master/ubuntu/18.04/arm64/prep.sh | sudo sh
```

### Windows
```
Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/gvanderberg/devops-agents/master/windows/Setup-BuildAgent.ps1'))
```
