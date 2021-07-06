# ルートテーブル
resource "aws_route_table" "mycamp-front-rtb" {
  vpc_id = aws_vpc.mycamp-vpc.id

  route {
    gateway_id = aws_internet_gateway.mycamp-igw.id
    cidr_block = "0.0.0.0/0"
  }

  tags = {
    Name = "mycamp-front-route"
  }
}
resource "aws_route_table" "mycamp-api-rtb" {
  vpc_id = aws_vpc.mycamp-vpc.id

  route {
    nat_gateway_id = aws_nat_gateway.mycamp-ngw.id
    cidr_block     = "0.0.0.0/0"
  }

  tags = {
    Name = "mycamp-api-route"
  }
}

# アソシエーション
resource "aws_route_table_association" "mycamp-front-rtb-1a" {
  subnet_id      = aws_subnet.mycamp-front-1a.id
  route_table_id = aws_route_table.mycamp-front-rtb.id
}
resource "aws_route_table_association" "mycamp-front-rtb-1c" {
  subnet_id      = aws_subnet.mycamp-front-1c.id
  route_table_id = aws_route_table.mycamp-front-rtb.id
}
resource "aws_route_table_association" "mycamp-api-rtb-1a" {
  subnet_id      = aws_subnet.mycamp-api-1a.id
  route_table_id = aws_route_table.mycamp-api-rtb.id
}
resource "aws_route_table_association" "mycamp-api-rb-1c" {
  subnet_id      = aws_subnet.mycamp-api-1c.id
  route_table_id = aws_route_table.mycamp-api-rtb.id
}
