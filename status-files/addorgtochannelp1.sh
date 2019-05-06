
#!/bin/bash

channelname=$1
orgname=$2
ordererno=$3
ordererport=$4

dpkg -s "jq" &> /dev/null

if [ $? -eq 0 ]; then
    echo "jq package  is already installed"
else
    echo 'Installing jq' 
    apt-get -y update && apt-get -y install jq
fi

while true
do 
peer channel fetch config -o orderer$ordererno-bankconsortiumbcnet-com:$ordererport -c $channelname  --tls  --cafile /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/bankconsortiumbcnet-com/orderers/orderer$ordererno-bankconsortiumbcnet-com/msp/tlscacerts/tlsca-bankconsortiumbcnet-com-cert.pem config_block.pb
  if [ $? -eq 0 ]; then 
    break
  fi
  sleep 1
done

configtxlator proto_decode --input config_block.pb --type common.Block | jq .data.data[0].payload.data.config > config.json

jq -s '.[0] * {"channel_group":{"groups":{"Application":{"groups": {"'$orgname'MSP":.[1]}}}}}' config.json ../channel-artifacts/"$orgname"MSP.json > modified_config.json 

configtxlator proto_encode --input config.json --type common.Config > original_config.pb 

configtxlator proto_encode --input modified_config.json --type common.Config > modified_config.pb 

configtxlator compute_update --channel_id $channelname --original original_config.pb --updated modified_config.pb > config_update.pb 

configtxlator proto_decode --input config_update.pb  --type common.ConfigUpdate | jq . > config_update.json

echo '{"payload":{"header":{"channel_header":{"channel_id":"'$channelname'", "type":2}},"data":{"config_update":'$(cat config_update.json)'}}}' | jq . > config_update_in_envelope.json 

configtxlator proto_encode --input config_update_in_envelope.json --type common.Envelope > org_update_in_envelope.pb

peer channel signconfigtx -f org_update_in_envelope.pb

touch "$orgname"_"$channelname"_update_in_envelope_sig_complete


