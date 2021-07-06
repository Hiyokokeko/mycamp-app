# SecurityGroup RDS
resource "aws_security_group" "mycamp-rds-sg" {
  description = "RDS security group for mycamp"
  name        = "mycamp-rds-sg"
  vpc_id      = aws_vpc.mycamp-vpc.id
}

# SecurityGroup ALB
resource "aws_security_group" "mycamp-alb-sg" {
  description = "ALB security group for mycamp"
  name        = "mycamp-alb-sg"
  vpc_id      = aws_vpc.mycamp-vpc.id
}
# SecurityGroup ECS
resource "aws_security_group" "mycamp-ecs-sg" {
  description = "ECS security group for mycamp"
  name        = "mycamp-ecs-sg"
  vpc_id      = aws_vpc.mycamp-vpc.id
}
