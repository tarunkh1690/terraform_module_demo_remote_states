

locals {
    vpc_id                     = data.terraform_remote_state.terraform_module_demo_publicmodule.outputs.vpc_id
    aza_private_subnet_id      = data.terraform_remote_state.terraform_module_demo_publicmodule.outputs.private_subnets[0]  
    azb_private_subnet_id      = data.terraform_remote_state.terraform_module_demo_publicmodule.outputs.private_subnets[1]
    azc_private_subnet_id      = data.terraform_remote_state.terraform_module_demo_publicmodule.outputs.private_subnets[2] 
    aza_public_subnet_id       = data.terraform_remote_state.terraform_module_demo_publicmodule.outputs.public_subnets[0]
    azb_public_subnet_id       = data.terraform_remote_state.terraform_module_demo_publicmodule.outputs.public_subnets[1]
    azc_public_subnet_id       = data.terraform_remote_state.terraform_module_demo_publicmodule.outputs.public_subnets[2] 

#    assume_role_policy = "${data.aws_iam_policy_document.assume_role_policy.json}"
#    policy = "${data.aws_iam_policy_document.policy.json}"
#    aws_cloudwatch_log_group_arn = aws_cloudwatch_log_group.webappcloudwatchgrp.arn
}

variable "public_key" {
    default = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC4yZof6PJACSFS2RZ635CWKsOIqSK4yI2hAT7FLD3jHWbiDtqQgkIJFFsUuNqMUENPQfC3JiaRnZmbhCZ1yQTeOmj1V9gYkU/1IOAqhuIqNVMoQfX9TROyxbkZS1OPFDUcI0XyB2KgosBTq4P04TwLhq/dZb2iYY6eJF7vTEznyrn2m97PqelsdJAPRMTP3FMXr2n8Mpf79NJcHNQ4ZMhZWzuAkuDNUCweT+ZBwzhMraezfTqUsU6i0k6sm50IHXbK4tF9bt0gH37MjZs/qZMAz6AFN+qmGq3aOMFqs18tR9t/iW4GC8maDx4Mk8WSLbuLDGoxIHgs03CtRgM69IgjZ2grn+i1+RGPDqZ5hl/MwgBR+EDCuOZhzDDbc/Mc3NTuFe+6zO2oMm2NcxK7JbgBqGWZjAkTnxz5eeUpy7xI3iQUjrm28RuFGeCXroKl7XoTzO88HBEOUHBGKjcxdVBHrCGd5bxVINVekh1Q4rcHtxbXJTkr5VDuGr6qOnYX2EM="
}


variable "tags" {
    default = {
        Name =  ""
    }
}

variable "userDataScript" {
    default = "./install-apache.sh"
}

#variable "userDataScript" {
#    type = map(string)
#    default = {
#    "app" = "./install-apache.sh"
#    }
#}



variable "testClient_nlp_ips" {
    default = ["172.31.0.0/20","172.31.32.0/20"]
}

variable "public_lb_ips" {
    default = ["3.111.153.83/32","13.126.184.144/32"]
}
