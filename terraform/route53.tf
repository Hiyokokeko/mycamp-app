# Route53
resource "aws_route53_zone" "mycamp-host-zone" {
  name    = "realshinkitv.com"
  comment = "realshinkitv.com host zone"
}

resource "aws_route53_record" "mycamp-host-zone-record" {
  zone_id = aws_route53_zone.mycamp-host-zone.zone_id
  name    = aws_route53_zone.mycamp-host-zone.name
  type    = "A"

  alias {
    name                   = aws_lb.mycamp-api-alb.dns_name
    zone_id                = aws_lb.mycamp-api-alb.zone_id
    evaluate_target_health = true
  }
}

# front用
resource "aws_route53_zone" "mycamp-zone" {
  name = "realshinkitv.com"
  tags = {
    "realshinkitv" = "realshinkitv.com"
  }
}
resource "aws_route53_record" "mycamp-zone-record" {
  zone_id = aws_route53_zone.mycamp-zone.id
  name = aws_route53_zone.mycamp-zone.name
  type = "A"

  alias {
    name = aws_lb.mycamp-alb.dns_name
    zone_id = aws_lb.mycamp-alb.zone_id
    evaluate_target_health = true
  }
}
