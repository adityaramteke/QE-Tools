#!/bin/bash

### it creates a pvc
### it takes two arguments
### $1 is name of the pvc
### $2 is size of pvc
### eg. sh pvc-create.sh claim001 1


name=$1
storageSize=$2
nameSpace=$3
storageClass=glusterfs-storage-block
: '
file volume access mode should be "ReadWriteMany"
block volume access mode should be "ReadWriteOnce"
change the "acessModes" according to the volume type
'
accessModes=ReadWriteOnce

echo "kind: PersistentVolumeClaim
apiVersion: v1
metadata:
  name: $name
  annotations:
    volume.beta.kubernetes.io/storage-class: $storageClass
  namespace: $nameSpace
spec:
  accessModes:
   - $accessModes
  resources:
    requests:
      storage: $storageSize""Gi" | oc create -f -
