resource "aws_cloudwatch_log_group" "public" {
  provider = aws.us-east-1

  name              = "/aws/route53/${aws_route53_zone.public.name}."
  retention_in_days = 30
}

# Example CloudWatch log resource policy to allow Route53 to write logs
# to any log group under /aws/route53/*

data "aws_iam_policy_document" "route53-query-logging-policy" {
  statement {
    actions = [
      "logs:CreateLogStream",
      "logs:PutLogEvents",
    ]

    resources = ["arn:aws:logs:*:*:log-group:/aws/route53/*"]

    principals {
      identifiers = ["route53.amazonaws.com"]
      type        = "Service"
    }
  }
}

resource "aws_cloudwatch_log_resource_policy" "route53-query-logging-policy" {
  provider = aws.us-east-1

  policy_document = data.aws_iam_policy_document.route53-query-logging-policy.json
  policy_name     = "route53-query-logging-policy"
}

resource "aws_route53_delegation_set" "web" {
  reference_name = var.reference_name   # This is a reference name used in Caller Reference (helpful for identifying single delegation set amongst others)
}

resource "aws_route53_zone" "public" {
#  count = var.public_enabled ? 1 : 0

  name              = var.domain_name
  delegation_set_id = aws_route53_delegation_set.web.id
  comment           = var.comment
  force_destroy     = var.force_destroy
  tags              = var.tags
}

resource "aws_route53_query_log" "public" {
  depends_on = [aws_cloudwatch_log_resource_policy.route53-query-logging-policy]

  cloudwatch_log_group_arn = aws_cloudwatch_log_group.public.arn
  zone_id                  = aws_route53_zone.public.zone_id
}