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
### "lambda_api/"
This is a "Hello World" lambda api tutorial covering the basics of provisioning app resources out in AWS

### "terraform_backend/"
This tutorial covers how to set up a remote state backend in using Terraform Cloud for use with the "lambda_api"

---

## Pre-requisites
- A terminal (depends on your OS!)
- [npm and NodeJS](https://www.npmjs.com/get-npm)
- [terraform v0.13.X](https://www.terraform.io/downloads.html)
- [An Amazon Web Service (AWS) Account](https://aws.amazon.com/)
    - Please note that a credit card is required
    - We will be working within the free tier of AWS but some small charges may occur

## Terraform: The basics
Terraform is an **infrastructure as code** tool that lets developers easily build, change and version infrastructure. 

**Benefits:**
- Allows devs to define resources using infrastructure as code files that can be versioned, shared and re-used
- Provides devs with execution plans of what terraform will do to help avoid surprises (My personal favorite :D)
- Handles provisioning of dependent and non-dependent resources for devs using pretty a neat resource graph
- Can be easily automated which means no more clicking on the devs part when putting changes out
- Tearing down and building back up is as easy as `terraform apply` and `terraform destroy`

---

### Click-Ops vs Terraform


---

