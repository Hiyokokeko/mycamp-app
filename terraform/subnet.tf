# サブネット
resource "aws_subnet" "mycamp-front-1a" {
  vpc_id                  = aws_vpc.mycamp-vpc.id
  cidr_block              = "10.0.0.0/24"
  availability_zone       = "ap-northeast-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "mycamp-front-1a"
  }
}
resource "aws_subnet" "mycamp-front-1c" {
  vpc_id                  = aws_vpc.mycamp-vpc.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "ap-northeast-1c"
  map_public_ip_on_launch = true

  tags = {
    Name = "mycamp-front-1c"
  }
}
resource "aws_subnet" "mycamp-api-1a" {
  vpc_id                  = aws_vpc.mycamp-vpc.id
  cidr_block              = "10.0.2.0/24"
  availability_zone       = "ap-northeast-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "mycamp-api-1a"
  }
}
resource "aws_subnet" "mycamp-api-1c" {
  vpc_id                  = aws_vpc.mycamp-vpc.id
  cidr_block              = "10.0.3.0/24"
  availability_zone       = "ap-northeast-1c"
  map_public_ip_on_launch = true

  tags = {
    Name = "mycamp-api-1c"
  }
}

# サブネットグループ
resource "aws_db_subnet_group" "mycamp-rds-subnet-group" {
  name        = "mycamp-rds-subnet-group"
  description = "rds subnet for mycamp"
  subnet_ids  = [aws_subnet.mycamp-api-1a.id, aws_subnet.mycamp-api-1c.id]
}
