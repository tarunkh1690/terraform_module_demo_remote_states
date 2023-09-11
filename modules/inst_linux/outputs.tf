
output "instances" {
    description = "List of instance ids"
    value       = "${aws_instance.inst_linux}"
}