#!/bin/sh
echo $@
echo "start"

DESTINATION="$5/$4"

AGENTRELEASE="$(curl -s https://api.github.com/repos/Microsoft/azure-pipelines-agent/releases/latest | grep -oP '"tag_name": "v\K(.*)(?=")')"
AGENTURL="https://vstsagentpackage.azureedge.net/agent/${AGENTRELEASE}/vsts-agent-linux-arm-${AGENTRELEASE}.tar.gz"

echo "0. URL: $1 \n1. Token: $2 \n2. Pool: $3 \n3. Agent: $4 \n4. Path: $DESTINATION \nAgentVersion: $AGENTRELEASE \nAgentUrl: $AGENTURL" 

mkdir -p $DESTINATION

# cd $DESTINATION

echo "Release "${AGENTRELEASE}" appears to be latest" 
echo "Downloading..."

wget -O agent.tar.gz ${AGENTURL} 
tar zxvf agent.tar.gz -C $DESTINATION

chmod -R 777 $DESTINATION

echo "extracted"

$DESTINATION/bin/installdependencies.sh

echo "dependencies installed"

# sudo -u azuresupport $DESTINATION/config.sh --unattended --replace --url $1 --auth pat --token $2 --pool $3 --agent $4 --acceptTeeEula --work ./_work --runAsService
$DESTINATION/config.sh --unattended --replace --url $1 --auth pat --token $2 --pool $3 --agent $4 --acceptTeeEula --runAsService

echo "configuration done"

$DESTINATION/svc.sh install

echo "service installed"

$DESTINATION/svc.sh start

echo "service started"
echo "config done"

exit 0