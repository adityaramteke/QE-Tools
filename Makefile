full_deploy:
	ansible-playbook /usr/share/ansible/openshift-ansible/playbooks/prerequisites.yml
	ansible-playbook /usr/share/ansible/openshift-ansible/playbooks/deploy_cluster.yml
deploy_cluster:
	ansible-playbook /usr/share/ansible/openshift-ansible/playbooks/deploy_cluster.yml
deploy_glusterfs:
	ansible-playbook /usr/share/ansible/openshift-ansible/playbooks/openshift-glusterfs/config.yml
remove_glusterfs:
	ansible-playbook -e openshift_logging_install_logging=False playbooks/openshift-logging/config.yml
	ansible-playbook -e openshift_metrics_install_metrics=False playbooks/openshift-metrics/config.yml
	ansible-playbook -e "openshift_storage_glusterfs_wipe=true" /usr/share/ansible/openshift-ansible/playbooks/openshift-glusterfs/uninstall.yml
install_heketi:
	subscription-manager repos --enable=rh-gluster-3-client-for-rhel-7-server-rpms
	yum install heketi-client -y
