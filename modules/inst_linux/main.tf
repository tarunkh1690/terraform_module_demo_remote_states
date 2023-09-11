resource "aws_instance" "inst_linux" {
    for_each = toset(var.hosts)

    ami                          = var.hosts_ami_map == null ? var.ami : lookup(var.hosts_ami_map, each.value, var.ami)
    instance_type                = var.instance_type
    key_name                     = var.key_name
    vpc_security_group_ids       = var.vpc_security_group_ids
    subnet_id                    = var.subnet_id
    iam_instance_profile         = var.iam_instance_profile
    user_data                    = var.userDataScript
    #user_data_replace_on_change  = var.user_data_replace_on_change 
    #user_data                   = "${file("install-apache.sh")}"


    tags = {
        Name                  =  "${var.host_prefix}${each.value}"
    }

    dynamic "root_block_device" {
        for_each = var.root_block_device

        content {
            delete_on_termination = lookup(root_block_device.value, "delete_on_terminitation", null)
            encrypted             = lookup(root_block_device.value, "encrypted", null)
            iops                  = lookup(root_block_device.value, "iops", null)
            kms_key_id            = lookup(root_block_device.value, "kms_key_id", null)
            volume_size           = lookup(root_block_device.value, "volume_size", null)
            volume_type           = lookup(root_block_device.value, "volume_type", null)    
        }
    }

    dynamic "ebs_block_device" {
        for_each = var.ebs_block_device

        content {
            delete_on_termination = lookup(ebs_block_device.value, "delete_on_terminitation", null)
            device_name           = lookup(ebs_block_device.value, "device_name", null) 
            encrypted             = lookup(ebs_block_device.value, "encrypted", null)
            iops                  = lookup(ebs_block_device.value, "iops", null)
            kms_key_id            = lookup(ebs_block_device.value, "kms_key_id", null)
            volume_size           = lookup(ebs_block_device.value, "volume_size", null)
            volume_type           = lookup(ebs_block_device.value, "volume_type", null)    
        } 
    }

}


