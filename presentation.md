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

## Terraform

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

## Install Terraform CLI

- Download the binary from https://www.terraform.io/downloads.html
- **Windows users** Highly recommend you install git-bash or some other bash like terminal to use with Terraform

---

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

---

## Terraform Basics

----

### Resource Blocks

```
resource "aws_vpc" "main" {
  cidr_block = var.base_cidr_block
}
```

```
BLOCKTYPE "BLOCKLABEL" "BLOCKNAME" {
  # Block body
  IDENTIFIER = EXPRESSION # Argument
}
```

[from Terraform Docs](https://www.terraform.io/docs/configuration/index.html)

----

### Providers

- Translates APIs used to build resources into something terraform can use
- Also offers local utilities for stuff like generating random numbers or making zip files

```
// Tells terraform we're using Amazon Web Services
provider "aws" {
  region = var.region
}
```

----

### Variables

- Created using a variable block
- Variables can be loaded from .tfvars files which hold key value pairs
     - Example: Changing variables by environment

```
variable "region" {
  type        = string
  default     = "us-east-1"
  description = "Region to use in AWS"
}
```

`dev.tfvars`

```
// This will change region to us-west-2
// from the default region set in the variable block
region = "us-west-2"
```

----

### Locals

- Local values store variables as well as expressions
- Helps you avoid repeating yourself :D

```
locals {
  potato = "tomato"
  tags = {
    project = "terraform-workshop-intro"
    env     = var.env
    region  = var.region
  }
  veglist = concat(aws_s3_bucket.yam.id, aws_s3_bucket.turnip.id)
}
```

```
resource "aws_s3_bucket" "example" {
  # ...
  tags = local.tags
}
```

----

### State

Terraform stores the state (knowledge) of your deployed infrastructure
- Tracks metadata
- Used to figure out what to change when applying new changes
- Used to figure out what to delete when running a destroy
- State can be stored remotely so multiple devs can work on the same infrastructure

----

### State Part 2: Electric Bogaloo

The default terraform state file is `terraform.tfstate`

Fun reading: https://www.terraform.io/docs/state/index.html

----

### Learn more language stuff on the docs

Go to https://www.terraform.io/docs/configuration/index.html

---

## Lets make buckets!

Hosting a static site in AWS using an s3 bucket configured for public access as a website using only terraform

__Checkout the fully built app in `buckets/`__

----

### dev.tfvars

- Create a `dev.tfvars` file with the following:

```
region = "us-east-1"
env    = "dev"
```

----

### variables.tf

- Create two variable blocks for `region` and `env`

```
variable "region" {
  type        = string
  default     = "us-east-1"
  description = "Region to use in AWS"
}

variable "env" {
  type        = string
  default     = "dev"
  description = "Environment prefix for resources"
}
```

----

### main.tf - Part 1

- Create the aws provider block

```
provider "aws" {
  region = var.region
}
```

- Make a locals block with a tags object

```
locals {
  tags = {
    project = "terraform-workshop-intro"
    repo    = "https://github.com/jarangutan/terraform-workshop-intro"
    region  = var.region
    env     = var.env
  }
}
```

----

### main.tf - Part 2

- Use the resource `random_pet` to create a random name for the bucket

```
resource "random_pet" "name" {
  length    = 3
  separator = "-"
}
```

----

### main.tf - Part 3

- Create an s3 bucket configured for website use

```
resource "aws_s3_bucket" "bucket" {
  bucket = "${var.env}-${random_pet.name.id}"
  acl    = "public-read"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "PublicReadGetObject",
      "Effect": "Allow",
      "Principal": "*",
      "Action": [
        "s3:GetObject"
      ],
      "Resource": [
        "arn:aws:s3:::${var.env}-${random_pet.name.id}/*"
      ]
    }
  ]
}
EOF

  website {
    index_document = "index.html"
  }

  force_destroy = true
}
```

----

### main.tf - Part 4

- Add the `index.html` file to the bucket

```terraform
resource "aws_s3_bucket_object" "website" {
  acl          = "public-read"
  key          = "index.html"
  bucket       = aws_s3_bucket.bucket.id
  content      = file("${path.module}/assets/index.html")
  content_type = "text/html"
}
```

----

### Run terraform apply
Deploy to AWS! **Note** we referenced `dev.tfvars` file!

```
terraform apply -var-file=dev.tfvars
```

![ ](./images/terraformapply.gif)

----

### Click your fancy site

The bucket website is deployed and your bucket is out there!

![ ](./images/clickthelink.gif)

----

### Run terraform destroy

After you're done, delete stuff!

![ ](./images/terraformdestroy.gif)

---

## Terraform Cloud Backend

State files can be hosted remotely as a remote backend so you can work as a team using the same state

- This is how most teams work
- There are a variety ways of hosting your state file (AWS, Terraform Cloud and so on)
- Terraform Cloud is free :D

----

### To enable Terraform Cloud Backend for Buckets

Follow the instructions found in `backend.tf` <3

---

## Congratulations!

You made it past the workshop. That's pretty rad!

I know it's a lot and the concepts are pretty weird but I highly recommend you learn Terraform

A lot of companies are looking for it along with cloud knowledge (AWS, GCP, Azure, so on)

Ezpz Jobs