# dynamic-hyperledger-fabric-kafka-kubernetes-multihost-usecase-implementation

[practical implementation video link](https://youtu.be/ngGU33v4E9Y)

## This repository contains scripts to spawn the dynamic hyperledger fabric network in multi host environment on local as well as cloud (AWS. AZURE etc.). Explain  with the help of an usecase **BANKCONSORTIUMBCNET**. 

**In This Blockchain Network UseCase :-** 

1. Initially there were **3** orgs (banks) **sbi**,**hdfc**,**icici** having **1**, **2**, and **4** peers respectively. There were **3** channels first **chsbihdfc** (in which initially sbi and hdfc are present), second **chhdfcicici** (in which initially hdfc and icici are present) and third **chicicisbi** (in which initially icici and sbi are present) using **firstnetwork.sh** and **configtx-file-gen.sh** scripts.

2. Then I had **UP** the initial blockchain network which consists of **3 ORGs, 5 PEERS, 3 CAs, 3 CHANNELS** using **firstnetworkup.sh** script.

3. After this I used the scripts to join peers using **joinchannel.sh** script.

4. Added new peer to exsisting org using **addnewpeer.sh** script.

5. Created the new org **pnb** (bank) to exsisting blockchain network with 2 peers using **newOrgAddtion.sh** script.

6. Created new channel **createChannel.sh** script.

7. Adding org to channel in which it is not present using **addOrgToChannel.sh** script.

## Note:- I also wrote scripts which spawn dynamic hyperledger fabric network in multi host environment on local as well as cloud (AWS, AZURE etc). `(with install and instantiate chaincode also)  **(productionized, kubernetes cluster, flaut tolerance, kafka, zookeeper, multi orderer)**`. To get help regarding this please contact me on mail: piyush25032@gmail.com


## Technology STACK
1. Hyperledger Fabric(v1.4) (Kafka, Zookeeper)
2. Golang and Nodejs (Chaincode)
3. Kubernetes 
3. Docker & Container
4. Shell Scripting
5. Python
6. NFS (sharing common files between kube slaves)

--------------------------------------------------------------------------------------------------------------------------

## System and Software Requirments
1. Ubuntu, Docker, Golang, Python.
2. Download hypeledger fabric binaries like cryptogen, configtxgen etc. basic bin folder of fabric-samples outside the this repo (after clonning).
3. Download Chaincode folder just outside this repo (after clonning).
4. NFS (/tmp/nfsshare/) (common sharing folder between the kube slaves node for keys, chaincodes, etc. )

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

## Folder structure
1. artifact-Files:- contains artifact files like ( crypto-config.yaml, configtx.yaml etc.)
2. chaincode:- contains chaincodes.
3. configMaps-Files:- contains configMaps files.
4. deployment-Files:- contains deployments files 
   - subfolders of orgs 
5. job-Files:- contains jobs files 
   - addorgtochannel
   - channelcreation
   - instantiatecc
   - joinchannel
6. namespace-Files
7. networkStructureJson-Files
8. persistentvolume-Files
9. port-Files
10. service-Files
11. status-files

------------------------------------------------------------------------------------------------------------------------
                                    These files are not present in this repository
------------------------------------------------------------------------------------------------------------------------

## Descriptions of Files

#########  file for creating all files required for firstTime Blockchain network #########

### File1:- firstnetwork.sh

**function:-** This file creates the first time network of blockchain and simultaneously generate various important files and folders required for blockchain network creation and also define constants. And few of them defined below:-

i) **NAMESPACE** and **Persistent Volumes** Files:-   network-Namespace.yaml   create-claim-Volume.yaml

ii) **CONFIGMAP** Files:-   ftnw-zookeeperconfigmap.yaml  ftnw-kafkaconfigmap.yaml  ftnw-ordererconfigmap.yaml  ftnw-peerbaseconfigmap.yaml

iii) **DEPLOYMENT** Files:-  ftnw-zookeeper-Deployment.yaml  ftnw-kafka-Deployment.yaml  ftnw-orderer-Deployment.yaml  ftnw-peers-Deployment.yaml  ftnw-cas-Deployment.yaml

iv) **SERVICE** Files:- ftnw-zookeeper-Service.yaml  ftnw-kafka-Service.yaml  ftnw-orderer-Service.yaml  ftnw-peers-Service.yaml  ftnw-cas-Service.yaml

v) **JOBS** Files:-  ftnw-generateArtifacts-Job.yaml  ftnw-copyArtifacts-Job.yaml

vi) **ARTIFACTS** Files:- crypto-config.yaml  configtx.yaml

vii) **SCRIPTS** Files:- joinchannel.sh  addnewpeer.sh  newOrgAddtion.sh

viii) **PORT** Files:- nodeportca.txt  nodeportcouchdb.txt  nodeportkafka.txt  nodeportzookeeper.txt  nodeportorderer.txt  nodeportpeer.txt  portca.txt  portcouchdb.txt  portorderer.txt  portpeer.txt  portkafka.txt  portzookeeper.txt 

ix) **JSON** Files:- orgstructure.json orgsports.json channelinfo.json  

x) **CONSTANT** :- NOOFZOOKEEPERS  NOOFKAFKAS  NOOFORDERERS  NOOFZOOKEEPERREPLICAS  NOOFKAFKAREPLICAS  NOOFORDERERREPLICAS  NOOFCAREPLICAS  NOOFPEERREPLICAS  

`**command:- ./firstnetwork.sh arg1 arg2 arg3 arg4 arg5 arg6 ......**`

arg1:- blockchain network name,

arg2:- number of organisation in BC network initially,

arg3:- first org name

arg4:- number of peers in first org

arg5:- second org name

arg6:- number of peers in second org

and so on.

**example:-** `./firstnetwork.sh bcnet 2 org1 1 org2 2`

`./firstnetwork.sh network1 3 org1 1 org2 2 org3 3`

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

#########  file for channel creation in firstTime network #########

### File2:- configtx-file-gen.sh 

**function:-** This file creates configtx.yaml and other channel confriguration files required for creating the channels in first time blockchain network.

`**command:- ./configtx-file-gen.sh arg1 arg2 arg3 .... % arg4 arg5 ......**`

arg1:- channel name,

arg2:- first organisation name,

arg3:- second orginsation name

so on ....

%  separator used for ending one channel confriguration

arg4:- another channel name

arg5:- first organisation name

arg6:- second orginsation name

and so on.

**example:-** `./configtx-file-gen.sh ch1 org1 % ch2 org2`

`./configtx-file-gen.sh ch1 org1 % ch2 org2 % ch12 org1 org2`

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

#########  files for channel confriguration #########

### File3:- joinchannel.sh 

**function:-** This file helps peers to join channel by creating a JOB

`**command:- ./firstnetwork.sh arg1 arg2 arg3 arg4**`

arg1:- peer number (0,1,2 ....)

arg2:- org name

arg3:- channel_name

arg4:- orderer number (0,1,2 ....) (according to this NOOFORDERERS CONSTANT if is equal 3 then orderer number will either 0, 1, 2 )

**example:-** `./joinchannel.sh 0 org1 ch1 0`
          
`./joinchannel.sh 1 org2 ch12 1`

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

### File4:- createChannel.sh 

**function:-** This file helps to create new channel by creating 2 JOBs

`**command:- ./createChannel.sh arg1 arg2**`

arg1:- channel name

arg2:- orderer number (0,1,2 ....) (according to this NOOFORDERERS CONSTANT if is equal 3 then orderer number will either 0, 1, 2 )

**example**:- `./createChannel.sh newchannel 1`

`./createChannel.sh channel 0`

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

### File5:- addOrgToChannel.sh 

**function:-** This file helps to add org (which is not in channel) to existing channel by creating 3 JOBs

`**command:- ./addOrgToChannel.sh arg1 arg2 arg3**`

arg1:- existing channel name

arg2:- org name to be added 

arg3:- orderer number (0,1,2 ....) (according to this NOOFORDERERS CONSTANT if is equal 3 then orderer number will either 0, 1, 2 )

**example:-** `./addOrgToChannel.sh newchannel org5 0`

`./addOrgToChannel.sh channel12 org3 1`

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

######### files for adding new peer and orgs in existing BC network #########

###File6:- addnewpeer.sh 

**function:-** This file helps to add new peer to existing org by creating 2 JOBs, 1 DEPLOYMENT, 1 SERVICE.

`**command:- ./addnewpeer.sh arg1 arg2**`

arg1:- existing org name in which new peer to be added

arg2:- orderer number (0,1,2 ....) (according to this NOOFORDERERS CONSTANT if is equal 3 then orderer number will either 0, 1, 2 )

**example:-** `./addnewpeer.sh org1 1`

`./addnewpeer.sh org3 0`

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

### File7:- newOrgAddtion.sh 

**function:-** This file helps to add new organisation to existing BC network by creating 2 JOBs, 1 + (number of peers) DEPLOYMENTS, 1 + (number of peers) SERVICES.

`**command:- ./newOrgAddtion.sh arg1 arg2**`

arg1:- new org name which to be added

arg2:- number of peers in this org

**example:-** `./newOrgAddtion.sh orgnew 5`

`./newOrgAddtion.sh org10 10`

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

######### files for handling chaincodes #########

### File8:- installChaincode.sh 

**function:-** This file helps to install chaincode (smart contracts) on peer of an org by creating 1 JOBs.

`**command:- ./installChaincode.sh arg1 arg2 arg3 arg4 arg5 arg6 arg7**`

arg1:- peerno (0,1,2 ...) on which peer you want to install chaincode.

arg2:- organization name.

arg3:- channel name

arg4:- chaincode folder name (like folder structure chaincode/chaincode_example02/go)

arg5:- chaincode name

arg6:- chaincode version

arg7:- chaincode language (golang, node)

**example:-** `./installChaincode.sh 0 org1 ch1 "chaincode_example02/go" "mycc1" "1.0" golang` 

`./installChaincode.sh 0 org2 ch12 "chaincode_example02/node" "mycc2" "1.0" node`

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

### File9:- installChaincode.sh 

**function:-** This file helps to install chaincode (smart contracts) on peer of an org by creating 1 JOBs.

`**command:- ./instantiateChaincode.sh arg1 arg2 arg3 arg4 arg5 arg6 arg7 arg8 arg9**`

arg1:- peerno (0,1,2 ...) on which peer you want to install chaincode.

arg2:- organization name.

arg3:- channel name

arg4:- chaincode name

arg5:- chaincode version

arg6:- chaincode language (golang, node)

arg7:- chaincode arguments ( required for chaincode)

arg8:- chaincode endorsement policy

arg9:- orderer number (0,1,2 ....) (according to this NOOFORDERERS CONSTANT if is equal 3 then orderer number will either 0, 1, 2 )

**example:-** `./instantiateChaincode.sh 0 org1 ch1 "mycc1" "1.0" golang "{\\\"Args\\\":[\\\"init\\\",\\\"a\\\",\\\"100\\\",\\\"b\\\",\\\"200\\\"]}" "OR ('org1MSP.peer')"`

`./instantiateChaincode.sh 0 org2 ch12 "chaincode_example02/node" "mycc2" "1.0" node "{\\\"Args\\\":[\\\"init\\\",\\\"a\\\",\\\"100\\\",\\\"b\\\",\\\"200\\\"]}" "OR ('org1MSP.peer','org2MSP.peer')"`


### File10:- bcnetup.sh 

**function:-** This file helps to build first time blockchain network. This file is used after running File1 and File2.

`**command:- /bcnetup.sh**`

**example:-** `./bcnetup.sh`


----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

#########  JSON files storing the blockchain network confriguration  #########

**orgstructure.json** :- this file stores nameofnetwork, no. of org., org with there no. of peers.

--------------------------------------------------------------------------------------------------------------------------

**orgsports.json**    :- this file stores ports of peers of all orgs and their CAs 

--------------------------------------------------------------------------------------------------------------------------

**channelinfo.json**  :- this file stores the channel info like number of channels, orgs in channels ,peers which joined the channel etc.

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

######### file contains various funtion which help to get and store network confriguration details in JSON files #########

**operations.py**

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

######### files (network-configuration) are used for ports for peers, cas, couchdb, kafka, zookeeper, orderer #########

**nodeportca.txt**        :- nodeport for cas

**nodeportcouchdb.txt**   :- nodeport for couchdb

**nodeportkafka.txt**     :- nodeport for kafka

**nodeportzookeeper.txt** :- nodeport for zookeeper

**nodeportorderer.txt**   :- nodeport for orderer

**nodeportpeer.txt**      :- nodeport for peer

**portca.txt**            :- port for ca

**portcouchdb.txt**       :- port for couchdb

**portorderer.txt**       :- port for orderer

**portpeer.txt**          :- port for peer

**portkafka.txt**         :- port for kafka

**portzookeeper.txt**     :- port for zookeeper




----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

                                @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
                                @@@@@ UseCase Example implementation  @@@@@
                                @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

-----------------------------------------------------------------------------------------------------------------------------
                                               Kubernetes Cluster
-----------------------------------------------------------------------------------------------------------------------------

### Commands on Master Node

**administrator@kube-master:~/Documents/DBOK/dynamic-hyperledger-fabric-kafka-kubernetes$ sudo su**

**administrator@kube-master:~/Documents/DBOK/dynamic-hyperledger-fabric-kafka-kubernetes# kubeadm init --apiserver-advertise-address=172.16.10.161 --pod-network-cidr=10.0.0.0/24**

**administrator@kube-master:~/Documents/DBOK/dynamic-hyperledger-fabric-kafka-kubernetes# exit**

**administrator@kube-master:~/Documents/DBOK/dynamic-hyperledger-fabric-kafka-kubernetes$ mkdir -p $HOME/.kube**

**administrator@kube-master:~/Documents/DBOK/dynamic-hyperledger-fabric-kafka-kubernetes$ sudo cp -ivf /etc/kubernetes/admin.conf $HOME/.kube/config**

**administrator@kube-master:~/Documents/DBOK/dynamic-hyperledger-fabric-kafka-kubernetes$ sudo chown $(id -u):$(id -g) $HOME/.kube/config**

**administrator@kube-master:~/Documents/DBOK/dynamic-hyperledger-fabric-kafka-kubernetes$ export kubever=$(kubectl version | base64 | tr -d '\n')**

**administrator@kube-master:~/Documents/DBOK/dynamic-hyperledger-fabric-kafka-kubernetes$ kubectl apply -f "https://cloud.weave.works/k8s/net?k8s-version=$kubever"**

**administrator@kube-master:~/Documents/DBOK/dynamic-hyperledger-fabric-kafka-kubernetes$ kubectl get pods -o wide --all-namespaces**

-----------------------------------------------------------------------------------------------------------------------------

### Commands on Slave Nodes

**administrator@kube-slave1:~$ sudo su**

**root@kube-slave1:/home/administrator# kubeadm join 172.16.10.161:6443 --token p483ys.j4pik520e1e6g07z --discovery-token-ca-cert-hash sha256:ad01deba0311f6ff9d1545a3a638bf579dcb192b9cca1386917c98f773533551**

-----------------------------------------------------------------------------------------------------------------------------

**administrator@kube-slave2:~$ sudo su**

**root@kube-slave2:/home/administrator# kubeadm join 172.16.10.161:6443 --token p483ys.j4pik520e1e6g07z --discovery-token-ca-cert-hash sha256:ad01deba0311f6ff9d1545a3a638bf579dcb192b9cca1386917c98f773533551**

-----------------------------------------------------------------------------------------------------------------------------
                                                Intial Folder Structure
-----------------------------------------------------------------------------------------------------------------------------
**administrator@kube-master:~/Documents/DBOK/dynamic-hyperledger-fabric-kafka-kubernetes$ ls**
addOrgToChannel.sh  chaincode             createChannel.sh  installChaincode.sh      operations.py  resetFolder.sh

bcnetup.sh          configtx-file-gen.sh  firstnetwork.sh   instantiateChaincode.sh  README.md

-----------------------------------------------------------------------------------------------------------------------------
                                                Command to create initial and blockchain network file
-----------------------------------------------------------------------------------------------------------------------------
**administrator@kube-master:~/Documents/DBOK/dynamic-hyperledger-fabric-kafka-kubernetes$ ./firstnetwork.sh bankconsortiumbcnet 3 sbi 1 hdfc 2 icici 2**

**administrator@kube-master:~/Documents/DBOK/dynamic-hyperledger-fabric-kafka-kubernetes$ ls**

addnewpeer.sh       chaincode             deployment-Files         job-Files                   newOrgAddition.sh       README.md

addOrgToChannel.sh  configMaps-Files      firstnetwork.sh          joinchannel.sh              operations.py           resetFolder.sh

artifact-Files      configtx-file-gen.sh  installChaincode.sh      namespace-Files             persistentvolume-Files  service-Files

bcnetup.sh          createChannel.sh      instantiateChaincode.sh  networkStructureJson-Files  port-Files              status-files


-----------------------------------------------------------------------------------------------------------------------------
                                                Command to create the channel configuration files
-----------------------------------------------------------------------------------------------------------------------------
**administrator@kube-master:~/Documents/DBOK/dynamic-hyperledger-fabric-kafka-kubernetes$ ./configtx-file-gen.sh chsbihdfc sbi hdfc % chhdfcicici hdfc icici % chicicisbi icici sbi**

**piyushkumar@ubuntu:~/Documents/dynamic-hyperledger-fabric-singlehost-files$ ls**

addnewpeer.sh       chaincode             deployment-Files         job-Files                   newOrgAddition.sh       README.md

addOrgToChannel.sh  configMaps-Files      firstnetwork.sh          joinchannel.sh              operations.py           resetFolder.sh

artifact-Files      configtx-file-gen.sh  installChaincode.sh      namespace-Files             persistentvolume-Files  service-Files

bcnetup.sh          createChannel.sh      instantiateChaincode.sh  networkStructureJson-Files  port-Files              status-files


-----------------------------------------------------------------------------------------------------------------------------
                                                Command to build the firstnetwork blockchain network 
-----------------------------------------------------------------------------------------------------------------------------
**administrator@kube-master:~/Documents/DBOK/dynamic-hyperledger-fabric-kafka-kubernetes$ ./bcnetup.sh**

-----------------------------------------------------------------------------------------------------------------------------
                                                Command to see the pods of blockchain network
-----------------------------------------------------------------------------------------------------------------------------
**administrator@kube-master:~/Documents/DBOK/dynamic-hyperledger-fabric-kafka-kubernetes$ kubectl get pods -o wide --all-namespaces**

NAMESPACE             NAME                                                   READY   STATUS      RESTARTS   AGE   IP              NODE          NOMINATED NODE

bankconsortiumbcnet   ca-hdfc-bankconsortiumbcnet-com-578b6597bb-zdj5g       1/1     Running     0          50m   10.40.0.5       kube-slave2   <none>

bankconsortiumbcnet   ca-icici-bankconsortiumbcnet-com-fc8c4bb8-xjlbk        1/1     Running     0          50m   10.36.0.5       kube-slave1   <none>

bankconsortiumbcnet   ca-pnb-bankconsortiumbcnet-com-6cb7c66fd8-tbb6r        1/1     Running     0          34m   10.40.0.10      kube-slave2   <none>

bankconsortiumbcnet   ca-sbi-bankconsortiumbcnet-com-649948f48d-vbl9j        1/1     Running     0          50m   10.40.0.4       kube-slave2   <none>

bankconsortiumbcnet   ftnw-artifacts-generate-sstp5                          0/2     Completed   0          50m   10.40.0.0       kube-slave2   <none>

bankconsortiumbcnet   ftnw-copyartifacts-wswl2                               0/1     Completed   0          51m   10.36.0.0       kube-slave1   <none>

bankconsortiumbcnet   kafka0-bankconsortiumbcnet-com-5869c5bd7f-ndx4q        1/1     Running     0          50m   10.40.0.1       kube-slave2   <none>

bankconsortiumbcnet   kafka1-bankconsortiumbcnet-com-6fbd7f88-9p628          1/1     Running     0          50m   10.36.0.2       kube-slave1   <none>

bankconsortiumbcnet   kafka2-bankconsortiumbcnet-com-67bcd7749-gs7dp         1/1     Running     0          50m   10.40.0.2       kube-slave2   <none>

bankconsortiumbcnet   kafka3-bankconsortiumbcnet-com-568f855bfd-s7hkm        1/1     Running     0          50m   10.36.0.3       kube-slave1   <none>

bankconsortiumbcnet   orderer0-bankconsortiumbcnet-com-757f7b45dc-h78dl      1/1     Running     0          50m   10.40.0.3       kube-slave2   <none>

bankconsortiumbcnet   orderer1-bankconsortiumbcnet-com-6fdf675c5d-pr6t4      1/1     Running     0          50m   10.36.0.4       kube-slave1   <none>

bankconsortiumbcnet   peer0-hdfc-bankconsortiumbcnet-com-654f7bc676-mn65w    2/2     Running     0          50m   10.36.0.7       kube-slave1   <none>

bankconsortiumbcnet   peer0-icici-bankconsortiumbcnet-com-5d87d8696b-gm8dt   2/2     Running     0          50m   10.40.0.7       kube-slave2   <none>

bankconsortiumbcnet   peer0-sbi-bankconsortiumbcnet-com-cb96bbfc5-vddlv      2/2     Running     0          50m   10.36.0.6       kube-slave1   <none>

bankconsortiumbcnet   peer1-hdfc-bankconsortiumbcnet-com-7444947d97-ktchn    2/2     Running     0          50m   10.40.0.6       kube-slave2   <none>

bankconsortiumbcnet   peer1-icici-bankconsortiumbcnet-com-6795cdfc49-cdz7b   2/2     Running     0          50m   10.36.0.8       kube-slave1   <none>

bankconsortiumbcnet   zookeeper0-bankconsortiumbcnet-com-6f95986b98-7hjsh    1/1     Running     0          50m   10.36.0.0       kube-slave1   <none>

bankconsortiumbcnet   zookeeper1-bankconsortiumbcnet-com-59fbc47bf6-njnv6    1/1     Running     0          50m   10.36.0.1       kube-slave1   <none>

bankconsortiumbcnet   zookeeper2-bankconsortiumbcnet-com-7b789bcf46-g8d4s    1/1     Running     0          50m   10.40.0.0       kube-slave2   <none>

kube-system           coredns-576cbf47c7-2h8bp                               1/1     Running     0          54m   10.32.0.7       kube-master   <none>

kube-system           coredns-576cbf47c7-clnsk                               1/1     Running     0          54m   10.32.0.8       kube-master   <none>

kube-system           etcd-kube-master                                       1/1     Running     0          53m   172.16.10.161   kube-master   <none>

kube-system           kube-apiserver-kube-master                             1/1     Running     0          53m   172.16.10.161   kube-master   <none>

kube-system           kube-controller-manager-kube-master                    1/1     Running     0          53m   172.16.10.161   kube-master   <none>

kube-system           kube-proxy-4gk6j                                       1/1     Running     0          54m   172.16.10.161   kube-master   <none>

kube-system           kube-proxy-54vb4                                       1/1     Running     0          53m   172.16.10.148   kube-slave1   <none>

kube-system           kube-proxy-7n5rr                                       1/1     Running     0          53m   172.16.10.132   kube-slave2   <none>

kube-system           kube-scheduler-kube-master                             1/1     Running     0          53m   172.16.10.161   kube-master   <none>

kube-system           weave-net-7bp2d                                        2/2     Running     0          53m   172.16.10.148   kube-slave1   <none>

kube-system           weave-net-tw7pn                                        2/2     Running     0          53m   172.16.10.132   kube-slave2   <none>

kube-system           weave-net-v756w                                        2/2     Running     0          54m   172.16.10.161   kube-master   <none>


-----------------------------------------------------------------------------------------------------------------------------
                                                Command to join the channel by peer of an org
-----------------------------------------------------------------------------------------------------------------------------
**administrator@kube-master:~/Documents/DBOK/dynamic-hyperledger-fabric-kafka-kubernetes$ ./joinchannel.sh 0 sbi chsbihdfc 0**

**administrator@kube-master:~/Documents/DBOK/dynamic-hyperledger-fabric-kafka-kubernetes$ ./joinchannel.sh 0 hdfc chsbihdfc 1**

**administrator@kube-master:~/Documents/DBOK/dynamic-hyperledger-fabric-kafka-kubernetes$ ./joinchannel.sh 0 sbi chicicisbi 0**


-----------------------------------------------------------------------------------------------------------------------------
                                                Command to add new peer to an org in exsisting blockchain network
-----------------------------------------------------------------------------------------------------------------------------

**administrator@kube-master:~/Documents/DBOK/dynamic-hyperledger-fabric-kafka-kubernetes$ ./addnewpeer.sh sbi 1**

-----------------------------------------------------------------------------------------------------------------------------
                                                Command to add new org in exsisting blockchain network
-----------------------------------------------------------------------------------------------------------------------------
**administrator@kube-master:~/Documents/DBOK/dynamic-hyperledger-fabric-kafka-kubernetes$ ./newOrgAddition.sh pnb 2**

-----------------------------------------------------------------------------------------------------------------------------
                                                Command to create new channel
-----------------------------------------------------------------------------------------------------------------------------
**administrator@kube-master:~/Documents/DBOK/dynamic-hyperledger-fabric-kafka-kubernetes$ ./createChannel.sh chall 0**


-----------------------------------------------------------------------------------------------------------------------------
                                                Command to add exsisting org to channel in which it not present.
-----------------------------------------------------------------------------------------------------------------------------
**administrator@kube-master:~/Documents/DBOK/dynamic-hyperledger-fabric-kafka-kubernetes$ ./addOrgToChannel.sh chall pnb 0**

-----------------------------------------------------------------------------------------------------------------------------
                                                Command to join channel by peer of an org
-----------------------------------------------------------------------------------------------------------------------------
**administrator@kube-master:~/Documents/DBOK/dynamic-hyperledger-fabric-kafka-kubernetes$ ./joinchannel.sh 0 pnb chall 0**

-----------------------------------------------------------------------------------------------------------------------------
                                                Command to add exsisting org to channel in which it not present.
-----------------------------------------------------------------------------------------------------------------------------
**administrator@kube-master:~/Documents/DBOK/dynamic-hyperledger-fabric-kafka-kubernetes$ ./addOrgToChannel.sh chall sbi 0**


-----------------------------------------------------------------------------------------------------------------------------
                                                Command to join channel by peer of an org
-----------------------------------------------------------------------------------------------------------------------------
**administrator@kube-master:~/Documents/DBOK/dynamic-hyperledger-fabric-kafka-kubernetes$ ./joinchannel.sh 0 sbi chall 1**


-----------------------------------------------------------------------------------------------------------------------------
                                                Command to install chaincode on peer of an org
-----------------------------------------------------------------------------------------------------------------------------
**administrator@kube-master:~/Documents/DBOK/dynamic-hyperledger-fabric-kafka-kubernetes$ ./installChaincode.sh 0 sbi chsbihdfc "chaincode_example02" "chsbihdfccc" "1.0" golang 0**

-----------------------------------------------------------------------------------------------------------------------------
                                                Command to instantiate chaincode on peer of an org
-----------------------------------------------------------------------------------------------------------------------------
**administrator@kube-master:~/Documents/DBOK/dynamic-hyperledger-fabric-kafka-kubernetes$ ./instantiateChaincode.sh 0 sbi chsbihdfc "chsbihdfccc" "1.0" golang "{\\\"Args\\\":[\\\"init\\\",\\\"a\\\",\\\"100\\\",\\\"b\\\",\\\"200\\\"]}" "OR ('sbiMSP.peer', 'hdfcMSP.peer')" 0**


-----------------------------------------------------------------------------------------------------------------------------
                                                Command to see the pods of blockchain network
-----------------------------------------------------------------------------------------------------------------------------
**administrator@kube-master:~/Documents/DBOK/dynamic-hyperledger-fabric-kafka-kubernetes$ kubectl get pods -o wide --all-namespaces**

-----------------------------------------------------------------------------------------------------------------------------
                                                Command to add exsisting org to channel in which it not present.
-----------------------------------------------------------------------------------------------------------------------------
**administrator@kube-master:~/Documents/DBOK/dynamic-hyperledger-fabric-kafka-kubernetes$ ./addOrgToChannel.sh chsbihdfc pnb 0**

-----------------------------------------------------------------------------------------------------------------------------
                                                Command to see the pods of blockchain network
-----------------------------------------------------------------------------------------------------------------------------
**administrator@kube-master:~/Documents/DBOK/dynamic-hyperledger-fabric-kafka-kubernetes$ kubectl get pods -o wide --all-namespaces**

NAMESPACE             NAME                                                   READY   STATUS      RESTARTS   AGE   IP              NODE          NOMINATED NODE

bankconsortiumbcnet   ca-hdfc-bankconsortiumbcnet-com-578b6597bb-zdj5g       1/1     Running     0          50m   10.40.0.5       kube-slave2   <none>

bankconsortiumbcnet   ca-icici-bankconsortiumbcnet-com-fc8c4bb8-xjlbk        1/1     Running     0          50m   10.36.0.5       kube-slave1   <none>

bankconsortiumbcnet   ca-pnb-bankconsortiumbcnet-com-6cb7c66fd8-tbb6r        1/1     Running     0          34m   10.40.0.10      kube-slave2   <none>

bankconsortiumbcnet   ca-sbi-bankconsortiumbcnet-com-649948f48d-vbl9j        1/1     Running     0          50m   10.40.0.4       kube-slave2   <none>

bankconsortiumbcnet   createchannel-chhdfcicici-8lrth                        0/2     Completed   0          41m   10.36.0.9       kube-slave1   <none>

bankconsortiumbcnet   createchannel-chicicisbi-fsz8w                         0/2     Completed   0          41m   10.36.0.10      kube-slave1   <none>

bankconsortiumbcnet   createchannel-chsbihdfc-kfhgv                          0/2     Completed   0          41m   10.40.0.8       kube-slave2   <none>

bankconsortiumbcnet   ftnw-artifacts-generate-sstp5                          0/2     Completed   0          50m   10.40.0.0       kube-slave2   <none>

bankconsortiumbcnet   ftnw-copyartifacts-wswl2                               0/1     Completed   0          51m   10.36.0.0       kube-slave1   <none>

bankconsortiumbcnet   gc-pnb-9q2rf                                           0/1     Completed   0          34m   10.36.0.10      kube-slave1   <none>

bankconsortiumbcnet   gc-sbi-peer1-6lflx                                     0/1     Completed   0          38m   10.40.0.10      kube-slave2   <none>

bankconsortiumbcnet   jaotc-pnb-chall-part1-5fhf5                            0/1     Completed   0          32m   10.36.0.11      kube-slave1   <none>

bankconsortiumbcnet   jaotc-pnb-chall-part2-tblnm                            0/1     Completed   0          32m   10.40.0.12      kube-slave2   <none>

bankconsortiumbcnet   jaotc-sbi-chall-part1-k2pfp                            0/1     Completed   0          30m   10.40.0.12      kube-slave2   <none>

bankconsortiumbcnet   jaotc-sbi-chall-part2-xq8zg                            0/1     Completed   0          30m   10.36.0.11      kube-slave1   <none>

bankconsortiumbcnet   jc-hdfc-peer0-chsbihdfc-ch4fh                          0/1     Completed   0          39m   10.40.0.8       kube-slave2   <none>

bankconsortiumbcnet   jc-pnb-peer0-chall-4gmg2                               0/1     Completed   0          31m   10.36.0.11      kube-slave1   <none>

bankconsortiumbcnet   jc-sbi-peer0-chall-tpsgj                               0/1     Completed   0          29m   10.40.0.12      kube-slave2   <none>

bankconsortiumbcnet   jc-sbi-peer0-chicicisbi-npjdb                          0/1     Completed   0          38m   10.40.0.8       kube-slave2   <none>

bankconsortiumbcnet   jc-sbi-peer0-chsbihdfc-nd264                           0/1     Completed   0          40m   10.40.0.8       kube-slave2   <none>

bankconsortiumbcnet   jc-sbi-peer1-chsbihdfc-rkz5p                           0/1     Completed   0          37m   10.36.0.10      kube-slave1   <none>

bankconsortiumbcnet   jcc-chall-hpflr                                        0/2     Completed   0          33m   10.40.0.12      kube-slave2   <none>

bankconsortiumbcnet   jcit-chsbihdfccc-golang-chsbihdfc-peer0-sbi-9dthw      0/1     Completed   0          28m   10.36.0.11      kube-slave1   <none>

bankconsortiumbcnet   jcitt-chsbihdfccc-golang-chsbihdfc-peer0-sbi-cbw24     0/1     Completed   0          27m   10.40.0.13      kube-slave2   <none>

bankconsortiumbcnet   juccf-pnb-k2sxf                                        0/1     Completed   0          34m   10.40.0.10      kube-slave2   <none>

bankconsortiumbcnet   juccf-sbi-peer1-pdnbv                                  0/1     Completed   0          38m   10.40.0.9       kube-slave2   <none>

bankconsortiumbcnet   jucf-chall-k8ftx                                       0/1     Completed   0          33m   10.36.0.11      kube-slave1   <none>

bankconsortiumbcnet   kafka0-bankconsortiumbcnet-com-5869c5bd7f-ndx4q        1/1     Running     0          50m   10.40.0.1       kube-slave2   <none>

bankconsortiumbcnet   kafka1-bankconsortiumbcnet-com-6fbd7f88-9p628          1/1     Running     0          50m   10.36.0.2       kube-slave1   <none>

bankconsortiumbcnet   kafka2-bankconsortiumbcnet-com-67bcd7749-gs7dp         1/1     Running     0          50m   10.40.0.2       kube-slave2   <none>

bankconsortiumbcnet   kafka3-bankconsortiumbcnet-com-568f855bfd-s7hkm        1/1     Running     0          50m   10.36.0.3       kube-slave1   <none>

bankconsortiumbcnet   orderer0-bankconsortiumbcnet-com-757f7b45dc-h78dl      1/1     Running     0          50m   10.40.0.3       kube-slave2   <none>

bankconsortiumbcnet   orderer1-bankconsortiumbcnet-com-6fdf675c5d-pr6t4      1/1     Running     0          50m   10.36.0.4       kube-slave1   <none>

bankconsortiumbcnet   peer0-hdfc-bankconsortiumbcnet-com-654f7bc676-mn65w    2/2     Running     0          50m   10.36.0.7       kube-slave1   <none>

bankconsortiumbcnet   peer0-icici-bankconsortiumbcnet-com-5d87d8696b-gm8dt   2/2     Running     0          50m   10.40.0.7       kube-slave2   <none>

bankconsortiumbcnet   peer0-pnb-bankconsortiumbcnet-com-6f7bb66c99-fmjkt     2/2     Running     0          34m   10.36.0.10      kube-slave1   <none>

bankconsortiumbcnet   peer0-sbi-bankconsortiumbcnet-com-cb96bbfc5-vddlv      2/2     Running     0          50m   10.36.0.6       kube-slave1   <none>

bankconsortiumbcnet   peer1-hdfc-bankconsortiumbcnet-com-7444947d97-ktchn    2/2     Running     0          50m   10.40.0.6       kube-slave2   <none>

bankconsortiumbcnet   peer1-icici-bankconsortiumbcnet-com-6795cdfc49-cdz7b   2/2     Running     0          50m   10.36.0.8       kube-slave1   <none>

bankconsortiumbcnet   peer1-pnb-bankconsortiumbcnet-com-67766f5f84-wf446     2/2     Running     0          34m   10.40.0.11      kube-slave2   <none>

bankconsortiumbcnet   peer1-sbi-bankconsortiumbcnet-com-8547c86bbb-shb9v     2/2     Running     0          38m   10.40.0.9       kube-slave2   <none>

bankconsortiumbcnet   zookeeper0-bankconsortiumbcnet-com-6f95986b98-7hjsh    1/1     Running     0          50m   10.36.0.0       kube-slave1   <none>

bankconsortiumbcnet   zookeeper1-bankconsortiumbcnet-com-59fbc47bf6-njnv6    1/1     Running     0          50m   10.36.0.1       kube-slave1   <none>

bankconsortiumbcnet   zookeeper2-bankconsortiumbcnet-com-7b789bcf46-g8d4s    1/1     Running     0          50m   10.40.0.0       kube-slave2   <none>

kube-system           coredns-576cbf47c7-2h8bp                               1/1     Running     0          54m   10.32.0.7       kube-master   <none>

kube-system           coredns-576cbf47c7-clnsk                               1/1     Running     0          54m   10.32.0.8       kube-master   <none>

kube-system           etcd-kube-master                                       1/1     Running     0          53m   172.16.10.161   kube-master   <none>

kube-system           kube-apiserver-kube-master                             1/1     Running     0          53m   172.16.10.161   kube-master   <none>

kube-system           kube-controller-manager-kube-master                    1/1     Running     0          53m   172.16.10.161   kube-master   <none>

kube-system           kube-proxy-4gk6j                                       1/1     Running     0          54m   172.16.10.161   kube-master   <none>

kube-system           kube-proxy-54vb4                                       1/1     Running     0          53m   172.16.10.148   kube-slave1   <none>

kube-system           kube-proxy-7n5rr                                       1/1     Running     0          53m   172.16.10.132   kube-slave2   <none>

kube-system           kube-scheduler-kube-master                             1/1     Running     0          53m   172.16.10.161   kube-master   <none>

kube-system           weave-net-7bp2d                                        2/2     Running     0          53m   172.16.10.148   kube-slave1   <none>

kube-system           weave-net-tw7pn                                        2/2     Running     0          53m   172.16.10.132   kube-slave2   <none>

kube-system           weave-net-v756w                                        2/2     Running     0          54m   172.16.10.161   kube-master   <none>


![alt text](https://github.com/piyushkumar96/dynamic-hyperledger-fabric-kafka-kubernetes-multihost-usecase-implementation/Screenshotofallpodsrunning.png)
-----------------------------------------------------------------------------------------------------------------------------
                                                              END
-----------------------------------------------------------------------------------------------------------------------------
