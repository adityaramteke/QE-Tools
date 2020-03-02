#!/bin/bash

### it creates n cirros app pods
### it depends on cirros-create-with-io.sh
### eg. sh cirros-create-and-wait.sh


for i in {001..050}; do
    sh cirros-create-with-io.sh $i claim$i glusterfs-file;

    echo `date` - "cirros"$i " creation request sent" >> cirros.log

    while true; do
        status=`oc get pod --no-headers -l deploymentconfig=cirros$i \
            -o=custom-columns=:.status.containerStatuses[0].ready,:.status.phase \
            -n glusterfs-file`
        if [ "$status" == "true      Running" ]; then
            echo `date` - "cirros"$i " is Running successfully" >> cirros.log
            echo | tee -a cirros.log
            break
        fi
    done
    sleep 10
done
