param (
    [string]$url,
    [string]$token,
    [string]$pool,
    [string]$agent,
    [string]$path
)

$destinationPath = Join-Path -Path $path -ChildPath $agent

[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

$wr = Invoke-WebRequest https://api.github.com/repos/Microsoft/azure-pipelines-agent/releases/latest
$tag = ($wr | ConvertFrom-Json)[0].tag_name
$tag = $tag.Substring(1)

$agentUrl = "https://vstsagentpackage.azureedge.net/agent/$tag/vsts-agent-win-x64-$tag.zip"

Write-Host "0. URL: $url `n1. Token: $token `n2. Pool: $pool `n3. Agent: $agent `n4. Path: $destinationPath `nAgentVersion: $tag `nAgentUrl: $agentUrl" 

if (Test-Path $destinationPath) {
    Write-Host "Deleteing folder " $destinationPath
    Remove-Item -Path $destinationPath -Force -Confirm:$false -Recurse
}

New-Item -ItemType Directory -Force -Path $destinationPath

Write-Host $destinationPath
# Set-Location $destinationPath

Invoke-WebRequest $agentUrl -Out agent.zip
Expand-Archive -Path agent.zip -DestinationPath $destinationPath

& $destinationPath\config.cmd --unattended --replace --url $url --auth pat --token $token --pool $pool --agent $agent --acceptTeeEula --runAsService

exit 0
