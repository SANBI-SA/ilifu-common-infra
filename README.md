# Main resources:

## "SANBI" project setup on ILIFU
### Terraform (ilifu_sanbi_project)
- [X] Create common keypair
- [X] Create common security group
  - [X] Create rules for common security group
- [X] Create sentry security group
  - [X] Create rules for sentry security group
- [X] Create common vxlan network and subnet
- [X] Create router for vxlan
- [X] Create instance for sentry and assign floating IP
  - [X] Install github runner via terraform
  - *NOTE!* This actually also provisions the github runner via remote-exec
  - [ ] Install Docker on the VM for the github runner
- [X] Create DNS A record in sanbi.ac.za for sentry-ilifu.sanbi.ac.za

### Ansible (ilifu_sanbi_project)
- [ ] Proviisions OpenVPN
- [ ] Provisions Gitlab runner
