resource "openstack_compute_instance_v2" "sentry" {
  name            = "sentry-ilifu"
  image_id        = var.sentry_instance_image_id
  flavor_id       = var.sentry_instance_flavor
  key_pair        = openstack_compute_keypair_v2.infra.name
  security_groups = [
    openstack_networking_secgroup_v2.sentry.name,
  ]

  metadata = {
    ansible_group_name = "sentry"
  }

  network {
    name = openstack_networking_network_v2.internal.name
  }
}

resource "openstack_networking_floatingip_v2" "sentry" {
  pool = var.public_ip_network_name
}

resource "openstack_compute_floatingip_associate_v2" "sentry" {
  floating_ip = openstack_networking_floatingip_v2.sentry.address
  instance_id = openstack_compute_instance_v2.sentry.id

  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = var.ilifu_infrastructure_private_key
    host        = openstack_networking_floatingip_v2.sentry.address
  }

  provisioner "file" {
    content = <<-EOF
---
- hosts: localhost
  become: True
  connection: local
  vars:
    - runner_user: "gh-runner"
    - runner_dir: /opt/gh-runner
    - runner_version: "latest"
    - runner_state: "started"
    - reinstall_runner: yes
    - hide_sensitive_logs: yes
    - access_token: "{{ lookup('env', 'GH_PERSONAL_ACCESS_TOKEN') }}"
    - runner_org: yes
    - runner_name: "sentry-ilifu-runner"
    - github_account: "SANBI-SA"
  roles:
    - name: monolithprojects.github_actions_runner
      become: True
EOF
    destination = "/home/ubuntu/site.yml"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt update",
      "sudo apt -y install acl",
      "wget -O- https://bootstrap.pypa.io/get-pip.py | python3",
      ".local/bin/pip install -U pip",
      ".local/bin/pip install ansible",
      "sudo useradd gh-runner -m -d /opt/gh-runner ||true"
    ]
  }

  provisioner "remote-exec" {
    inline = [
      "~/.local/bin/ansible-galaxy collection install ansible.posix",
      "~/.local/bin/ansible-galaxy collection install community.general",
      "~/.local/bin/ansible-galaxy role install monolithprojects.github_actions_runner",
      "GH_PERSONAL_ACCESS_TOKEN=${var.gh_personal_access_token} ~/.local/bin/ansible-playbook ~/site.yml -i localhost,",
      "rm -rf ~/site.yml"
    ]
  }
}