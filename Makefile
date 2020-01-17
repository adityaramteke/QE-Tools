full_deploy:
	ansible-playbook /usr/share/ansible/openshift-ansible/playbooks/prerequisites.yml
	ansible-playbook /usr/share/ansible/openshift-ansible/playbooks/deploy_cluster.yml
deploy_cluster:
	ansible-playbook /usr/share/ansible/openshift-ansible/playbooks/deploy_cluster.yml
deploy_glusterfs:
	ansible-playbook /usr/share/ansible/openshift-ansible/playbooks/openshift-glusterfs/config.yml
remove_log_met:
	ansible-playbook -e openshift_logging_install_logging=False /usr/share/ansible/openshift-ansible/playbooks/openshift-logging/config.yml
	ansible-playbook -e openshift_metrics_install_metrics=False /usr/share/ansible/openshift-ansible/playbooks/openshift-metrics/config.yml
remove_glusterfs:
	ansible-playbook -e "openshift_storage_glusterfs_wipe=true" /usr/share/ansible/openshift-ansible/playbooks/openshift-glusterfs/uninstall.yml
remove_gluster_with_metrics:
	make remove_log_met
	remove_glusterfs
install_heketi:
	subscription-manager repos --enable=rh-gluster-3-client-for-rhel-7-server-rpms
	yum install heketi-client -y
create_projects:
	oc new-project glusterfs-file
	oc new-project glusterfs-block
create_workload:
	sh scripts/pvc-create-and-wait-block.sh
	sh scripts/pvc-create-and-wait-file.sh