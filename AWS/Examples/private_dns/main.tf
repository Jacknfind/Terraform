provider "aws" {
}

provider "aws" {
  alias = "alternate"
}

resource "aws_vpc" "private" {
  cidr_block           = "10.6.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true
}



resource "aws_route53_zone" "private" {
#  count = var.private_enabled ? 1 : 0

  name              = var.domain_name
  comment           = var.comment
  force_destroy     = var.force_destroy
  tags              = var.tags

  vpc {
    vpc_id = aws_vpc.private.id
  }
}

resource "aws_vpc" "alternate" {
  provider = "aws.alternate"

  cidr_block           = "10.7.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true
}

resource "aws_route53_vpc_association_authorization" "private" {
  vpc_id  = aws_vpc.alternate.id
  zone_id = aws_route53_zone.private.id
}


resource "aws_route53_zone_association" "private" {
  provider = "aws.alternate"

  vpc_id  = aws_route53_vpc_association_authorization.private.vpc_id
  zone_id = aws_route53_vpc_association_authorization.private.zone_id
}