---
theme: solarized
revealOptions:
  transition: "fade"
highlightTheme: "solarized-dark"
---

# terraform-workshop-intro
Intro to terraform workshop covering the creation of a "terraform_backend" and a "lambda_api" using Amazon Web Services (AWS)

https://github.com/jarangutan/terraform-workshop-intro

---

## What is in this repo?
### "buckets/"
This tutorial covers the basics of terraform by walking you through creating a static website out on S3

---

## Pre-requisites
- A terminal (depends on your OS!)
    - **Windows Users** I highly recommend getting a bash like terminal like [git bash](https://git-scm.com/downloads)
- [npm and NodeJS](https://www.npmjs.com/get-npm)
- [terraform v0.13.X](https://www.terraform.io/downloads.html)
- [An Amazon Web Service (AWS) Account](https://aws.amazon.com/)
    - Please note that a credit card is required
    - We will be working within the free tier of AWS but some small charges may occur
- [A Terraform Cloud Account (OPTIONAL)](https://app.terraform.io/)
    - Used for managing remote terraform backends
---

## Caveats
- AWS is a cloud platform which means you pay for using their platform
- This workshop is tailored to stay closely within the AWS free tier
- There is a chance you might get charged for the resources used in this workshop
- I'm not responsible for that so please be responsible with the resource you put out there!

---

## Terraform: The Basics
Terraform is an **infrastructure as code** tool that lets developers easily build, change and version infrastructure. 

---

## Terraform: Benefits
- Devs can define resource definition files that can be versioned, shared and re-used
- Provides execution plans of what terraform will modify/create/destroy
- Handles provisioning of dependent and non-dependent resources in parallel
- Can be easily automated which means no click-ops for devs :D
- Tearing down and building back up is as easy as `terraform apply` and `terraform destroy`

---

## Click-Ops vs Terraform

----

### Click-Ops
![ ](./images/s3bucket.gif)

----

### Terraform
![ ](./images/terraform.gif)

---

### Install Terraform CLI
- Download the binary from https://www.terraform.io/downloads.html
- **Windows users** Highly recommend you install git-bash or some other bash like terminal to use with Terraform
- 

### Important Terraform CLI Commands
```bash
terraform <command> [args]
```

| CMD | Description |
| ----- | -------|
| `plan` | Creates execution plan showing what terraform will do |
| `apply` | Runs plan and after confirmation deploys resources |
| `destroy` | Runs plan and after confirmation deletes deployed resources |
| `workspace` | Manages your terraform workspaces |

----

### Equally Important Terraform CLI Commands
```bash
terraform <command> [args]
```

| CMD | Description |
| ----- | -------|
| `--help` | Lists of all the commands available |
| `validate` | Checks that your terraform files aren't goofed |
| `fmt` | Makes your terraform files really pretty |


---

## Terraform Language Basics

```
resource "aws_vpc" "main" {
  cidr_block = var.base_cidr_block
}

<BLOCK TYPE> "<BLOCK LABEL>" "<BLOCK LABEL>" {
  # Block body
  <IDENTIFIER> = <EXPRESSION> # Argument
}
```

[from Terraform Docs](https://www.terraform.io/docs/configuration/index.html)

---

## Configure Terraform to use AWS

----

### Create AWS Programmatic User
**Create a user with admin permissions and save your AWS Access key ID and Secret key!**

![ ](./images/programmaticuser.gif)

----

### Configure your CLI with the AWS
[Create the AWS credentials and config files. Click here for sample!](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-files.html)

`~/.aws/credentials` **note ~ is your home folder**

```
[default]
aws_access_key_id=AKIAIOSFODNN7EXAMPLE
aws_secret_access_key=wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY
```

`~/.aws/config`

```
[default]
region=us-west-2
output=json
```

