# module "newrelic-aws-cloud-integrations" {
#   source = "github.com/newrelic/terraform-provider-newrelic/examples/modules/cloud-integrations/aws"

#   newrelic_account_id     = "${var.newrelic_account_id}"
#   newrelic_account_region = "EU"
#   name                    = "${var.app_name}-${var.environment}"
# }