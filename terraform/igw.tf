# インターネットゲートウェイ
resource "aws_internet_gateway" "mycamp-igw" {
  vpc_id = aws_vpc.mycamp-vpc.id

  tags = {
    Name = "mycamp-igw"
  }
}
