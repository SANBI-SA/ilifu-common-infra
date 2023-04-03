variable "cloudns_api_user" {
    type = string
}

variable "cloudns_api_password" {
    type = string
}

variable "k8s_controller_flavor_id" {
    type = string
}

variable "k8s_worker_flavor_id" {
    type = string
}

variable "k8s_controller_image_id" {
    type = string
}

variable "k8s_worker_image_id" {
    type = string
}

variable "k8s_controller_count" {
    type = number
    default = 3
}

variable "k8s_worker_count" {
    type = number
    default = 2
}

variable "infra_private_key" {
    type = string
}