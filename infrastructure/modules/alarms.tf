resource "aws_sns_topic" "account_billing_alarm_topic" {
  name = "${var.app_name}-account-billing-alarm-topic-${var.environment}"
}

resource "aws_sns_topic_subscription" "billing_alarm_email_subscription" {
  topic_arn = aws_sns_topic.account_billing_alarm_topic.arn
  protocol  = "email"
  endpoint  = var.alarm_email
}

resource "aws_sns_topic_policy" "account_billing_alarm_policy" {
  arn    = aws_sns_topic.account_billing_alarm_topic.arn
  policy = data.aws_iam_policy_document.sns_topic_policy.json
}

data "aws_iam_policy_document" "sns_topic_policy" {
  statement {
    actions = [
      "SNS:Receive",
      "SNS:Publish"
    ]

    principals {
      type        = "Service"
      identifiers = ["budgets.amazonaws.com"]
    }

    resources = [
      aws_sns_topic.account_billing_alarm_topic.arn
    ]
  }
}

resource "aws_budgets_budget" "budget_account" {
  name              = "Account Monthly Budget - ${var.app_name} ${var.environment}"
  budget_type       = "COST"
  limit_amount      = var.account_budget_limit
  limit_unit        = "USD"
  time_unit         = "MONTHLY"
  time_period_start = "2020-01-01_00:00"

  notification {
    comparison_operator = "GREATER_THAN"
    threshold           = 100
    threshold_type      = "PERCENTAGE"
    notification_type   = "FORECASTED"
    subscriber_sns_topic_arns = [
      aws_sns_topic.account_billing_alarm_topic.arn
    ]
  }

  notification {
    comparison_operator = "GREATER_THAN"
    threshold           = 70
    threshold_type      = "PERCENTAGE"
    notification_type   = "ACTUAL"
    subscriber_sns_topic_arns = [
      aws_sns_topic.account_billing_alarm_topic.arn
    ]
  }

  depends_on = [
    aws_sns_topic.account_billing_alarm_topic
  ]
}

resource "aws_budgets_budget" "budget_resources" {
  for_each = var.budgets_per_service

  name              = "${var.app_name} ${var.environment} ${each.key} Monthly Budget"
  budget_type       = "COST"
  limit_amount      = each.value.budget_limit
  limit_unit        = "USD"
  time_unit         = "MONTHLY"
  time_period_start = "2020-01-01_00:00"

  cost_filter {
    name   = "Service"
    values = [each.key]
  }

  notification {
    comparison_operator = "GREATER_THAN"
    threshold           = 100
    threshold_type      = "PERCENTAGE"
    notification_type   = "ACTUAL"
    subscriber_sns_topic_arns = [
      aws_sns_topic.account_billing_alarm_topic.arn
    ]
  }

  depends_on = [
    aws_sns_topic.account_billing_alarm_topic
  ]
}
