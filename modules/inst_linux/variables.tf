variable "client" {
    type = map(string)
}

variable "tags" {
    type = map(string)
}

variable "host_prefix" {
    type = string
}

variable "hosts" {
    type    = list(string)
    default = []
}

variable "ami" {
    type = string
}

variable "hosts_ami_map" {
    type    = map(string)
    default = {}
}

variable "ebs_optimized" {
    default = false
}

variable "instance_type" {
    type = string
}

variable "key_name" {
    type = string
}

variable "vpc_security_group_ids" {
    type    = list(string)
    default = null
}

variable "subnet_id" {
    type    = string
    default = ""
}

variable "root_block_device" {
    type = list(map(string))
}

variable "ebs_block_device" {
    type    = list(map(string))
    default = []
}

variable "userDataScript" {
    type    = string
    default = null
}

variable "user_data_replace_on_change" {
    type    = bool
    default = false
}

variable "iam_instance_profile" {
    type    = string
    default = null
}


