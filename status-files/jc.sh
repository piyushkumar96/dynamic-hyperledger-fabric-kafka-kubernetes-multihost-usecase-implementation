
#!/bin/bash

ordererno=$1
ordererport=$2
while true
do 
peer channel fetch 0 -o orderer$ordererno-bankconsortiumbcnet-com:$ordererport -c ${CHANNEL_NAME}  --tls  --cafile /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/bankconsortiumbcnet-com/orderers/orderer$ordererno-bankconsortiumbcnet-com/msp/tlscacerts/tlsca-bankconsortiumbcnet-com-cert.pem ${CHANNEL_NAME}_0.block
  if [ $? -eq 0 ]; then 
    break
  fi
  sleep 1
done

peer channel join -b ${CHANNEL_NAME}_0.block


