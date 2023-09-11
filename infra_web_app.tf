
/** Web application security */

resource "aws_security_group" "webapp" {
  name   = "SG_${var.client.name}_webapp"
  vpc_id = "${local.vpc_id}"

  
  # Allow all outbound traffic.
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }  

  tags = {
    Name = "SG_${var.client.name}_webapp"
  }
}

resource "aws_security_group_rule" "webapp_ssh_22" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["49.205.33.0/24"]
  security_group_id = aws_security_group.webapp.id
}


#resource "aws_security_group_rule" "webapp_ssh_22_2" {
#  type              = "ingress"
#  from_port         = 22
#  to_port           = 22
#  protocol          = "tcp"
#  cidr_blocks       = ["49.205.32.0/24"]
#  security_group_id = aws_security_group.webapp.id
#}

#resource "aws_security_group_rule" "webapp_ssh_22_3" {
#  type              = "ingress"
#  from_port         = 22
#  to_port           = 22
#  protocol          = "tcp"
#  cidr_blocks       = ["49.205.32.0/24"]
#  security_group_id = aws_security_group.webapp.id
#}


resource "aws_security_group_rule" "webapp_lb_http_8080" {
  type              = "ingress"
  from_port         = 8080
  to_port           = 8080
  protocol          = "tcp"
  cidr_blocks       = "${var.testClient_nlp_ips}"
  security_group_id = aws_security_group.webapp.id

  depends_on = [
    aws_lb.multi_az_wepapp_lb
  ]

}

resource "aws_security_group_rule" "webapp_public_lb_http_8080" {
  type              = "ingress"
  from_port         = 8080
  to_port           = 8080
  protocol          = "tcp"
  cidr_blocks       = "${var.public_lb_ips}"
  security_group_id = aws_security_group.webapp.id

  depends_on = [
    aws_lb.multi_az_wepapp_lb
  ]

}


resource "aws_security_group_rule" "webapp_httpd_8080" {
  type              = "ingress"
  from_port         = 8080
  to_port           = 8080
  protocol          = "tcp"
  cidr_blocks       = ["49.205.33.0/24"]
  security_group_id = aws_security_group.webapp.id
}

#resource "aws_security_group_rule" "webapp_httpd_8080_1" {
#  type              = "ingress"
#  from_port         = 8080
#  to_port           = 8080
#  protocol          = "tcp"
#  cidr_blocks       = ["49.205.32.0/24"]
#  security_group_id = aws_security_group.webapp.id
#}

resource "aws_security_group_rule" "webapp_httpd_8080_2" {
  type              = "ingress"
  from_port         = 8080
  to_port           = 8080
  protocol          = "tcp"
  cidr_blocks       = ["10.0.0.0/16"] 
  security_group_id = aws_security_group.webapp.id
}

resource "aws_key_pair" "ssh_key" {
  key_name = "keypair_testClient"
  public_key = "${var.public_key}"
}
