# NATゲートウェイ
resource "aws_nat_gateway" "mycamp-ngw" {
  allocation_id = aws_eip.mycamp-ngw-eip.id
  subnet_id     = aws_subnet.mycamp-front-1a.id
  depends_on    = [aws_internet_gateway.mycamp-igw]

  tags = {
    Name = "mycamp-ngw"
  }
}
