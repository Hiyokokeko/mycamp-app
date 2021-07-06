# eip
resource "aws_eip" "mycamp-ngw-eip" {
  vpc        = true
  depends_on = [aws_internet_gateway.mycamp-igw]

  tags = {
    Name = "mycamp-ngw-eip"
  }
}
