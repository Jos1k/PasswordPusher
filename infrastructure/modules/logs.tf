# module "solutions_cloudwatch-log-retention-manager" {
#   source                            = "terraform-aws-modules/solutions/aws//modules/cloudwatch-log-retention-manager"
#   cloudwatch_logs_retention_in_days = 1
#   tags                              = { Name = "${var.app_name}-api-${var.environment}" }
#   putin_khuylo                      = true
#   schedule_expression               = "rate(24 hours)"
#   environment_variables             = { RETAIN_DAYS = var.logs_retention_in_days }
# }