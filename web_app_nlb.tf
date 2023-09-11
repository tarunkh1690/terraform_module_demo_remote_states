resource "aws_security_group" "SG_wepapp_alb" {
  name        = "Webapp_alb_security_group"
  description = "Terraform load balancer security group"
  vpc_id      = "${local.vpc_id}"

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow all outbound traffic.
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_lb" "multi_az_wepapp_lb" {
  name                             = "${var.client.name}-webapp-lb"
  internal                         = true
  load_balancer_type               = "application"
  subnets                          = ["${local.aza_subnet_id}", "${local.azb_subnet_id}"]
  security_groups                  = ["${aws_security_group.SG_wepapp_alb.id}"]
  enable_deletion_protection       = false
  enable_cross_zone_load_balancing = true

  tags = {
    Name = "${var.client.name}-webapp-lb"
  }
}

resource "aws_lb_target_group" "webapp-target" {
  name        = "${var.client.name}-wepapp-target"
  target_type = "instance"
  port        = 8080
  protocol    = "HTTP"
  vpc_id      = "${local.vpc_id}"

  stickiness {
    type = "lb_cookie"
  }
  # Alter the destination of the health check to be the login page.
  health_check {
    path = "/sample"
    port = 8080
    matcher = "200,302,404"
  }
}

resource "aws_lb_listener" "wepapp_ls_list_8080" {
  load_balancer_arn = aws_lb.multi_az_wepapp_lb.arn
  port              = "8080"
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.webapp-target.arn
  }
}

resource "aws_lb_target_group_attachment" "aza_webapp_http" {
  target_group_arn = aws_lb_target_group.webapp-target.arn
  target_id        = module.web_application.instances.Web01.id
  port             = 8080
}

resource "aws_lb_target_group_attachment" "azb_webapp_http" {
  target_group_arn = aws_lb_target_group.webapp-target.arn
  target_id        = module.web_application2.instances.Web02.id
  port             = 8080
}


#############
# Publc LB ####

resource "aws_lb" "multi_az_public_wepapp_lb" {
  name                             = "${var.client.name}-public-webapp-lb"
  internal                         = false
  load_balancer_type               = "application"
  subnets                          = ["${local.aza_subnet_id}", "${local.azb_subnet_id}"]
  security_groups                  = ["${aws_security_group.SG_wepapp_alb.id}"]
  enable_deletion_protection       = false
  enable_cross_zone_load_balancing = true

  tags = {
    Name = "${var.client.name}-public-webapp-lb"
  }
}

resource "aws_lb_target_group" "public-webapp-target" {
  name        = "${var.client.name}-public-wepapp-target"
  target_type = "instance"
  port        = 8080
  protocol    = "HTTP"
  vpc_id      = "${local.vpc_id}"

  stickiness {
    type = "lb_cookie"
  }
  # Alter the destination of the health check to be the login page.
  health_check {
    path = "/sample"
    port = 8080
    matcher = "200,302,404"
  }
}

resource "aws_lb_listener" "wepapp_public_ls_list_8080" {
  load_balancer_arn = aws_lb.multi_az_public_wepapp_lb.arn
  port              = "8080"
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.public-webapp-target.arn
  }
}


resource "aws_lb_target_group_attachment" "aza_public_webapp_http" {
  target_group_arn = aws_lb_target_group.public-webapp-target.arn
  target_id        = module.web_application.instances.Web01.id
  port             = 8080
}

resource "aws_lb_target_group_attachment" "azb_public_webapp_http" {
  target_group_arn = aws_lb_target_group.public-webapp-target.arn
  target_id        = module.web_application2.instances.Web02.id
  port             = 8080
}
