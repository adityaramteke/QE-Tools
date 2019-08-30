#!/bin/bash

### it creates a storageClass for gluster-block
### eg. sh glusterfs-block-storageClass.sh


name=glusterfs-block
secretName=heketi-storage-secret-glusterfs-block
secretNameSpace=glusterfs
heketiRoute=heketi-storage
restUrl=`oc get route $heketiRoute -n $secretNameSpace --no-headers\
    -o=custom-columns=:.spec.host`

echo "apiVersion: storage.k8s.io/v1
kind: StorageClass
metadata:
  name: $name
reclaimPolicy: Delete
provisioner: gluster.org/glusterblock
parameters:
  resturl: http://$restUrl
  restuser: admin
  restsecretName: $secretName
  restsecretNamespace: $secretNameSpace
  hacount: '3'
  chapauthenabled: 'true'
  volumenameprefix: blk" | oc create -f -
