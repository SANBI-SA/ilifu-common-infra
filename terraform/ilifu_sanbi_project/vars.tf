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
  default = "c01079b1-80b5-4e25-98c4-c29274ba8369"
}

variable "cloudns_api_user" {
    type = string
    sensitive = true
}

variable "cloudns_api_password" {
    type = string
    sensitive = true
}

variable "ilifu_infrastructure_private_key" {
    type = string
    sensitive = true
}

variable "gh_personal_access_token" {
    type = string
    sensitive = true
}