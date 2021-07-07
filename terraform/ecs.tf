# クラスター
resource "aws_ecs_cluster" "mycamp-ecs-cluster" {
  name = "mycamp-ecs-cluster"
}

# frontend側

# タスク定義
resource "aws_ecs_task_definition" "mycamp-front-task" {
  family                   = "mycamp-front-task"
  cpu                      = "512"
  memory                   = "1024"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  container_definitions    = file("./tasks/mycamp_front_definition.json")
  execution_role_arn       = module.ecs_task_execution_role.iam_role_arn
}

# サービス定義
resource "aws_ecs_service" "mycamp-front-ecs-service" {
  name             = "mycamp-front-ecs-service"
  cluster          = aws_ecs_cluster.mycamp-ecs-cluster.arn
  task_definition  = "${aws_ecs_task_definition.mycamp-front-task.family}:${max("${aws_ecs_task_definition.mycamp-front-task.revision}", "${data.aws_ecs_task_definition.mycamp-front-task.revision}")}"
  desired_count    = 1
  launch_type      = "FARGATE"
  platform_version = "1.3.0"
  health_check_grace_period_seconds = 600

  network_configuration {
    assign_public_ip = true
    security_groups = [
      aws_security_group.mycamp-ecs-sg.id
    ]
    subnets = [
      aws_subnet.mycamp-front-1a.id,
      aws_subnet.mycamp-front-1c.id
    ]
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.mycamp-alb-front-tg.arn
    container_name   = "front-container"
    container_port   = "80"
  }
}


# backend側

# タスク定義
resource "aws_ecs_task_definition" "mycamp-api-task" {
  family                   = "mycamp-api-task"
  cpu                      = "256"
  memory                   = "512"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  container_definitions    = file("./tasks/mycamp_api_definition.json")
  execution_role_arn       = module.ecs_task_execution_role.iam_role_arn
}

# サービス定義
resource "aws_ecs_service" "mycamp-api-ecs-service" {
  name             = "mycamp-api-ecs-service"
  cluster          = aws_ecs_cluster.mycamp-ecs-cluster.arn
  task_definition  = "${aws_ecs_task_definition.mycamp-api-task.family}:${max("${aws_ecs_task_definition.mycamp-api-task.revision}", "${data.aws_ecs_task_definition.mycamp-api-task.revision}")}"
  desired_count    = 1
  launch_type      = "FARGATE"
  platform_version = "1.3.0"
  health_check_grace_period_seconds = 600

  network_configuration {
    assign_public_ip = true
    security_groups = [
      aws_security_group.mycamp-ecs-sg.id
    ]
    subnets = [
      aws_subnet.mycamp-api-1a.id,
      aws_subnet.mycamp-api-1c.id
    ]
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.mycamp-alb-api-tg.arn
    container_name   = "api-container"
    container_port   = "3000"
  }
}

# マイグレーション用タスク
resource "aws_ecs_task_definition" "db-migrate" {
  family                   = "mycamp-db-migrate"
  container_definitions    = file("./tasks/mycamp_db_migrate_definition.json")
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = "256"
  memory                   = "512"
  execution_role_arn       = module.ecs_task_execution_role.iam_role_arn
}

# ファミリーを指定し、最新のACTIVEリビジョンを見つける
data "aws_ecs_task_definition" "mycamp-front-task" {
  depends_on      = [aws_ecs_task_definition.mycamp-front-task]
  task_definition = aws_ecs_task_definition.mycamp-front-task.family
}
data "aws_ecs_task_definition" "mycamp-api-task" {
  depends_on      = [aws_ecs_task_definition.mycamp-api-task]
  task_definition = aws_ecs_task_definition.mycamp-api-task.family
}

#権限
data "aws_iam_policy" "ecs_task_execution_role_policy" {
  arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

data "aws_iam_policy_document" "ecs_task_execution" {
  source_json = data.aws_iam_policy.ecs_task_execution_role_policy.policy

  statement {
    effect    = "Allow"
    actions   = ["ssm:GetParameters", "kms:Decrypt"]
    resources = ["*"]
  }
}

module "ecs_task_execution_role" {
  source     = "./modules/iam_role"
  name       = "ecs-task-execution"
  identifier = "ecs-tasks.amazonaws.com"
  policy     = data.aws_iam_policy_document.ecs_task_execution.json
}
