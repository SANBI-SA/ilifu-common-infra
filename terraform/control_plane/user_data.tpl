#cloud-config
network:
  version: 2
  ethernets:
    # opaque ID for physical interfaces, only referred to by other stanzas
    nic0:
      match:
        macaddress: '${port_dhcp_mac}'
      dhcp4: true
      addresses:
        - ${virtual_ip}