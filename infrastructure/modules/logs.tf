module "solutions_cloudwatch-log-retention-manager" {
  source                            = "terraform-aws-modules/solutions/aws//modules/cloudwatch-log-retention-manager"
  tags                              = { Name = "${var.app_name}-api-${var.environment}" }
  putin_khuylo                      = true
  schedule_expression               = "rate(24 hours)"
}