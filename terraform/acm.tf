# ACM
## front側SSL証明書の定義
resource "aws_acm_certificate" "mycamp-front-acm" {
  domain_name               = aws_route53_record.mycamp-zone-record.name
  subject_alternative_names = ["*.realshinkitv.com",]
  validation_method         = "DNS"
  lifecycle {
    create_before_destroy = true
  }
  tags = {
    "Name" = "realshinkitv.com"
  }
}

## SSL証明書の定義
resource "aws_acm_certificate" "mycamp-acm" {
  domain_name               = aws_route53_record.mycamp-host-zone-record.name
  subject_alternative_names = []
  validation_method         = "DNS"
  lifecycle {
    create_before_destroy = true
  }
}

## SSL検証
resource "aws_route53_record" "mycamp-certificate" {
  name    = tolist(aws_acm_certificate.mycamp-acm.domain_validation_options)[0].resource_record_name
  type    = tolist(aws_acm_certificate.mycamp-acm.domain_validation_options)[0].resource_record_type
  records = [tolist(aws_acm_certificate.mycamp-acm.domain_validation_options)[0].resource_record_value]
  zone_id = aws_route53_zone.mycamp-host-zone.id
  ttl     = 60
}

## 検証待機
resource "aws_acm_certificate_validation" "mycamp-acm" {
  certificate_arn         = aws_acm_certificate.mycamp-acm.arn
  validation_record_fqdns = [aws_route53_record.mycamp-certificate.fqdn]
}
