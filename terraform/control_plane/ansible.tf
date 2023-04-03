resource "null_resource" "remote_checker_controllers" {
  count = var.k8s_controller_count

  provisioner "remote-exec" {
    connection {
      type = "ssh"
      host = data.tfe_outputs.sanbi.values.sentry_vm_public_ip
      user = "ubuntu"
      private_key = var.infra_private_key
    }
    inline = [
      "nc -z -w 300 ${openstack_networking_port_v2.control[count.index].fixed_ip[0].ip_address} 22"
    ]
  }

  depends_on = [
    openstack_compute_instance_v2.controller
  ]
}

resource "null_resource" "remote_checker_workers" {
  count = var.k8s_worker_count

  provisioner "remote-exec" {
    connection {
      type = "ssh"
      host = data.tfe_outputs.sanbi.values.sentry_vm_public_ip
      user = "ubuntu"
      private_key = var.infra_private_key
    }
    inline = [
      "nc -z -w 300 ${openstack_networking_port_v2.worker[count.index].fixed_ip[0].ip_address} 22"
    ]
  }
  depends_on = [
    openstack_compute_instance_v2.worker
  ]
}

data "template_file" "sentry_script" {
  template = "${file("${path.module}/remote-exec.sh")}"
  vars = {
    infra_private_key = var.infra_private_key
  }
}

resource "null_resource" "ansible_runner" {

  connection {
      type = "ssh"
      host = data.tfe_outputs.sanbi.values.sentry_vm_public_ip
      user = "ubuntu"
      private_key = var.infra_private_key
  }

  provisioner "remote-exec" {
    inline = [
      "mkdir -p ~/ansible",
      "mkdir -p ~/venvs"
    ]
  }

  provisioner "file" {
    source = "${path.module}/../../ansible"
    destination = "/home/ubuntu/"
  }

  provisioner "remote-exec" {
    script = data.template_file.sentry_script.rendered
  }

  depends_on = [
    null_resource.remote_checker_controllers,
    null_resource.remote_checker_workers
  ]
}

