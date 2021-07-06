# SecurityGroupRule RDS
resource "aws_security_group_rule" "mycamp-rds-sg-rule1" {
  description       = "mycamp-rds-sg-rule"
  type              = "ingress"
  from_port         = 3306
  to_port           = 3306
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0", "0.0.0.0/16"]
  security_group_id = aws_security_group.mycamp-rds-sg.id
}
resource "aws_security_group_rule" "mycamp-rds-sg-rule2" {
  description       = "mycamp-rds-sg-rule2"
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.mycamp-rds-sg.id
}
resource "aws_security_group_rule" "mycamp-rds-sg-rule3" {
  description       = "mycamp-rds-sg-rule3"
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  ipv6_cidr_blocks  = ["::/0"]
  security_group_id = aws_security_group.mycamp-rds-sg.id
}
resource "aws_security_group_rule" "mycamp-rds-sg-rule4" {
  description       = "mycamp-rds-sg-rule4"
  type                     = "ingress"
  from_port                = 3306
  to_port                  = 3306
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.mycamp-alb-sg.id
  security_group_id        = aws_security_group.mycamp-rds-sg.id
}

# SecurityGroupRule ALB
resource "aws_security_group_rule" "mycamp-alb-sg-rule1" {
  description       = "mycamp-alb-sg-rule1"
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0", "0.0.0.0/16"]
  security_group_id = aws_security_group.mycamp-alb-sg.id
}
resource "aws_security_group_rule" "mycamp-alb-sg-rule2" {
  description       = "mycamp-alb-sg-rule2"
  type              = "ingress"
  from_port         = 8
  to_port           = 0
  protocol          = "icmp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.mycamp-alb-sg.id
}
resource "aws_security_group_rule" "mycamp-alb-sg-rule3" {
  description       = "mycamp-alb-sg-rule3"
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0", "0.0.0.0/16"]
  security_group_id = aws_security_group.mycamp-alb-sg.id
}
resource "aws_security_group_rule" "mycamp-alb-sg-rule4" {
  description       = "mycamp-alb-sg-rule4"
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.mycamp-alb-sg.id
}
resource "aws_security_group_rule" "mycamp-alb-sg-rule5" {
  description       = "mycamp-alb-sg-rule5"
  type              = "ingress"
  from_port         = 8080
  to_port           = 8080
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.mycamp-alb-sg.id
}
resource "aws_security_group_rule" "mycamp-alb-sg-rule6" {
  description       = "mycamp-alb-sg-rule6"
  type              = "ingress"
  from_port         = 3000
  to_port           = 3000
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.mycamp-alb-sg.id
}

# SecurityGroupRule ECS
resource "aws_security_group_rule" "mycamp-ecs-sg-rule1" {
  description       = "mycamp-ecs-sg-rule1"
  type              = "ingress"
  from_port         = 8
  to_port           = 0
  protocol          = "icmp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.mycamp-ecs-sg.id
}
resource "aws_security_group_rule" "mycamp-ecs-sg-rule2" {
  description       = "mycamp-ecs-sg-rule2"
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.mycamp-ecs-sg.id
}
resource "aws_security_group_rule" "mycamp-ecs-sg-rule3" {
  description       = "mycamp-ecs-sg-rule3"
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.mycamp-ecs-sg.id
}
resource "aws_security_group_rule" "mycamp-ecs-sg-rule4" {
  description       = "mycamp-ecs-sg-rule4"
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.mycamp-ecs-sg.id
}
resource "aws_security_group_rule" "mycamp-ecs-sg-rule5" {
  description              = "mycamp-ecs-sg-rule5"
  type                     = "ingress"
  from_port                = 0
  to_port                  = 0
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.mycamp-alb-sg.id
  security_group_id        = aws_security_group.mycamp-ecs-sg.id
}
resource "aws_security_group_rule" "mycamp-ecs-sg-rule6" {
  description       = "mycamp-ecs-sg-rule6"
  type              = "ingress"
  from_port         = 3000
  to_port           = 3000
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.mycamp-ecs-sg.id
}
resource "aws_security_group_rule" "mycamp-ecs-sg-rule7" {
  description       = "mycamp-ecs-sg-rule7"
  type              = "ingress"
  from_port         = 8080
  to_port           = 8080
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.mycamp-ecs-sg.id
}
