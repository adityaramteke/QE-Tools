#!/bin/bash

### it creates n pvc's with logs which contains time of requests
### eg. sh pvc-create-and-wait.sh


for i in {001..020}; do
    sh pvc-create.sh claim$i 1;

    echo `date` - "PVC claim"$i "creation request sent" | tee -a pvctrace.log

    while true; do
        var="$(oc get pvc claim$i -o=custom-columns=:.status.phase --no-headers)"

        if [ "${var}" == 'Bound' ]; then
            echo `date` - "PVC claim"$i "creation successful" | tee -a pvctrace.log
            echo | tee -a pvctrace.log
            break
        fi
    done
done
