# ロードバランサー
resource "aws_lb" "mycamp-alb" {
  name                       = "mycamp-alb"
  load_balancer_type         = "application"
  internal                   = false
  idle_timeout               = 60
  enable_deletion_protection = false

  subnets = [
    aws_subnet.mycamp-front-1a.id,
    aws_subnet.mycamp-front-1c.id
  ]

  security_groups = [
    aws_security_group.mycamp-alb-sg.id
  ]

  tags = {
    Name = "mycamp-alb"
  }
}

resource "aws_lb" "mycamp-api-alb" {
  name                       = "mycamp-api-alb"
  load_balancer_type         = "application"
  internal                   = false
  idle_timeout               = 60
  enable_deletion_protection = false

  subnets = [
    aws_subnet.mycamp-api-1a.id,
    aws_subnet.mycamp-api-1c.id
  ]

  security_groups = [
    aws_security_group.mycamp-alb-sg.id
  ]

  tags = {
    Name = "mycamp-api-alb"
  }
}

# リスナー
resource "aws_lb_listener" "mycamp-http-listener" {
  load_balancer_arn = aws_lb.mycamp-alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "redirect"

    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}
resource "aws_lb_listener" "mycamp-https-listener" {
  load_balancer_arn = aws_lb.mycamp-alb.arn
  port              = "443"
  protocol          = "HTTPS"
  certificate_arn   = aws_acm_certificate.mycamp-front-acm.arn

  default_action {
    target_group_arn = aws_lb_target_group.mycamp-alb-front-tg.arn
    type             = "forward"
  }
}

# backend用
resource "aws_lb_listener" "mycamp-api-http-listener" {
  load_balancer_arn = aws_lb.mycamp-api-alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "redirect"

    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}
resource "aws_lb_listener" "mycamp-api-https-listener" {
  load_balancer_arn = aws_lb.mycamp-api-alb.arn
  port              = "443"
  protocol          = "HTTPS"
  certificate_arn   = aws_acm_certificate.mycamp-acm.arn

  default_action {
    target_group_arn = aws_lb_target_group.mycamp-alb-api-tg.arn
    type             = "forward"
  }
}

# ターゲットグループ
resource "aws_lb_target_group" "mycamp-alb-front-tg" {
  name        = "mycamp-alb-front-tg"
  target_type = "ip"
  vpc_id      = aws_vpc.mycamp-vpc.id
  port        = 80
  protocol    = "HTTP"

  health_check {
    enabled             = true
    path                = "/"
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 120
    interval            = 150
    matcher             = 200
    port                = 80
    protocol            = "HTTP"
  }
}

resource "aws_lb_target_group" "mycamp-alb-api-tg" {
  name        = "mycamp-alb-api-tg"
  target_type = "ip"
  vpc_id      = aws_vpc.mycamp-vpc.id
  port        = 80
  protocol    = "HTTP"

  health_check {
    enabled             = true
    interval            = 60
    path                = "/api/v1/health_check"
    port                = 3000
    protocol            = "HTTP"
    matcher             = 200
    timeout             = 50
    healthy_threshold   = 5
    unhealthy_threshold = 2
  }
}
