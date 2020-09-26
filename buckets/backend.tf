# Uncomment the following terraform backend block to use Terraform Cloud to host the backend statefile
# Make sure to:
# - Rename dev.tfvars to dev.auto.tfvars and prod.tfvars to prod.auto.tfvars
# - Create your orgnization in Terraform Cloud
# - Log on to terraform cloud in your terminal `terraform login`
# - Create your workspace in your terminal using `terraform workspace new dev` where dev is your workspace name (i.e dev, prod, so on)
# - `terraform init` to initialize your workspace
# - Add the AWS Credentials for your programmatic user to your environment variables 
#   for your new workspace in Terraform Cloud-->workspace-->your_workspace-->variables.
#   The environment variables key names are:
#     - AWS_ACCESS_KEY_ID - sensitive
#     - AWS_SECRET_ACCESS_KEY - sensitive
# - Invite your fellow hackers to your organization!
# - Run `terraform apply` and deploy your resources :D!

# terraform {
#   backend "remote" {
#     hostname = "app.terraform.io"
#     organization = "my-organization"

#     workspaces {
#       prefix = "buckets-"
#     }
#   }
# }
