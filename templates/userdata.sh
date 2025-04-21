#!/bin/bash

sudo yum update
sudo yum install git -y
sudo amazon-linux-extras install ansible2 -y
sudo mkdir /var/ansible_playbooks
sudo git clone ${playbook_repository} /var/ansible_playbooks
aws secretsmanager get-secret-value --secret-id "${secret_id}" --region us-east-1 --query SecretString --output text > /var/ansible_playbooks/api_key.txt
aws ssm get-parameter --name "${host_list_ssm_name}" --region us-east-1 --query Parameter.Value --output text > /var/ansible_playbooks/host_list.txt
aws ssm get-parameter --name "${site_name_ssm_name}" --region us-east-1 --query Parameter.Value --output text > /var/ansible_playbooks/site_name.txt
ansible-playbook /var/ansible_playbooks/playbook.yml -i /var/ansible_playbooks/hosts

#sudo yum update
#sudo yum install git -y
#sudo amazon-linux-extras install ansible2 -y
#sudo mkdir /var/ansible_playbooks
#sudo git clone ${playbook_repository} /var/ansible_playbooks
#ansible-playbook /var/ansible_playbooks/playbook.yml -i /var/ansible_playbooks/hosts

#sudo amazon-linux-extras install -y nginx1
#sudo service nginx start
#sudo rm /usr/share/nginx/html/index.html
#echo '<html><head><title>Taco Wagon Server</title></head><body style=\"background-color:#1F778D\"><p style=\"text-align: center;\"><span style=\"color:#FFFFFF;\"><span style=\"font-size:28px;\">You did it! Have a &#127790;</span></span></p></body></html>' | sudo tee /usr/share/nginx/html/index.html