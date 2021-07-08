resource "aws_cloudwatch_log_group" "mycamp-ecs-api" {
  name              = "/ecs/api"
  retention_in_days = 180
}
resource "aws_cloudwatch_log_group" "mycamp-ecs-front" {
  name              = "/ecs/front"
  retention_in_days = 180
}
resource "aws_cloudwatch_log_group" "mycamp-ecs-db-migrate" {
  name              = "/ecs/db-migrate"
  retention_in_days = 180
}
