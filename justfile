default:
  @just --list


network:
  /workspace/install-fabric.sh docker
  cd /workspace/fabric-samples/test-network/ && ./network.sh up createChannel -ca -c couchdb
  cp -r /workspace/fabric-samples/test-network/organizations/ /workspace/_cfg
