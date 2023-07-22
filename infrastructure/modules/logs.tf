module "solutions_cloudwatch-log-retention-manager" {
  source                            = "terraform-aws-modules/solutions/aws//modules/cloudwatch-log-retention-manager"
  cloudwatch_logs_retention_in_days = var.logs_retention_in_days
  tags                              = { Name = "${var.app_name}-api-${var.environment}" }
  memory_size                       = 128
  putin_khuylo                      = true
  schedule_expression               = "rate(24 hours)"
}