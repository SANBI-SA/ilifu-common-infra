#!/bin/bash

export INFRA_PRIVATE_KEY=${infra_private_key}

sudo apt update && sudo apt install python3-pip
python3 -m venv ~/venvs/ansible

source ~/venvs/ansible/bin/activate
pip install -U pip
pip install -r ansible/pip-requirements.txt

ansible-galaxy install -r ansible/ansible-requirements.yml

ansible-playbook -i ansible/control_plane/inventory-openstack.yml ansible/control_plane/site.yml