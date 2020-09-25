# Uncomment the following terraform backend block to use Terraform Cloud to host the backend statefile
# Make sure to:
# - Create your orgnization in Terraform Cloud
# - Create your workspace in your terminal using `terraform workspace new name` where name is your workspace name (i.e dev, prod, so on)
# - `terraform init` to initialize your workspace
# - Add the AWS Credentials for your programmatic user to your environment variables 
#   for your new workspace in Terraform Cloud-->workspace-->your_workspace-->variables.
#   The environment variables key names are:
#     - AWS_ACCESS_KEY_ID - sensitive
#     - AWS_SECRET_ACCESS_KEY - sensitive
# - Invite your fellow 


# terraform {
#   backend "remote" {
#     hostname = "app.terraform.io"
#     organization = "my-organization"

#     workspaces {
#       prefix = "buckets-"
#     }
#   }
# }
