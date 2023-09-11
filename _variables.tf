variable "client" {
    type    = map(string)

    default = {
        "account"           = "536469770717"
        "region"            = "ap-south-1"
        "name"              = "testClient"
        "prod_host_prefix"  = "SERVERPROD"
    }
}

variable "AWS_SECRET_ACCESS_KEY" {
   
}

variable "AWS_ACCESS_KEY_ID" {
   
}