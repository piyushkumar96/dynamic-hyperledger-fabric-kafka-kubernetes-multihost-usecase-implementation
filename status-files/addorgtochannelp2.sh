
#!/bin/bash

channelname=$1
orgname=$2
ordererno=$3
ordererport=$4

for (( i=1; i <= 10; i++ ))
do 
peer channel update -f org_update_in_envelope.pb -c $channelname -o orderer$ordererno-bankconsortiumbcnet-com:$ordererport  --tls --cafile /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/bankconsortiumbcnet-com/orderers/orderer$ordererno-bankconsortiumbcnet-com/msp/tlscacerts/tlsca-bankconsortiumbcnet-com-cert.pem
  
if [ $? -eq 0 ]; then 
  break
fi
sleep 1
done

rm -rvf config_block.pb config.json modified_config.json original_config.pb modified_config.pb config_update.pb config_update.json config_update_in_envelope.json org_update_in_envelope.pb {$orgname}_{$channelname}_update_in_envelope_sig_complete

touch "$orgname"_addedto_"$channelname"


