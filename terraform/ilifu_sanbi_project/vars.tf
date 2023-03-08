variable "public_ip_network_name" {
  type = string
  default = "Ext_Floating_IP"
}

variable "sentry_instance_flavor" {
  type = string
  default = "035a4242-ffe3-4c4c-b2fa-eddf1c57f2bc"
}

variable "sentry_instance_image_id" {
  type = string
  default = "3820bbe8-a4ea-4807-ace2-51b7b912c7f7"
}