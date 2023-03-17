variable "cloudns_api_user" {
    type = string
}

variable "cloudns_api_password" {
    type = string
}

variable "control_node_image_id" {
    type = string
    default = "c01079b1-80b5-4e25-98c4-c29274ba8369"
}

variable "control_node_image_flavor" {
    type = string
    default = "eb1487f4-ff9d-4d50-b9c5-dd8c43e19e34"
}