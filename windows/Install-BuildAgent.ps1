# param (
#    [string]$url,
#    [string]$pat,
#    [string]$pool,
#    [string]$agent,
#    [string]$drive
# )

Write-Host "start"

# if (Test-Path "$drive:\agents")
# {
#     Remove-Item -Path "$drive:\agents" -Force -Confirm:$false -Recurse
# }

# New-Item -ItemType Directory -Force -Path "$drive:\agents"

# Set-Location "$drive:\agents"

# [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
# $wr = Invoke-WebRequest https://api.github.com/repos/Microsoft/azure-pipelines-agent/releases/latest
# $tag = ($wr | ConvertFrom-Json)[0].tag_name
# $tag = $tag.Substring(1)

# Write-Host "$tag is the latest version"

# $url = "https://vstsagentpackage.azureedge.net/agent/$tag/vsts-agent-win-x64-$tag.zip"

# Invoke-WebRequest $url -Out agent.zip
# Expand-Archive -Path agent.zip -DestinationPath $PWD
# .\config.cmd --unattended --url $URL --auth pat --token $PAT --pool $POOL --agent $AGENT --acceptTeeEula --runAsService

# exit 0
