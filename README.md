# terraform-workshop-intro
Intro to terraform workshop covering the creation of a "terraform_backend" and a "lambda_api" using Amazon Web Services (AWS)

## What is in this repo?
### "terraform_backend/"
This tutorial covers how to set up the terraform S3/DynamoDB state backend in AWS for use with the lambda_api/

### "quotes_api" branch
This is a Quotes API that is using AWS Lambda, API Gateway and DynamoDB with TypeScript. I'm still working on finishing it but a lot of stuff is there for provisioning the resources.

## Pre-requisites
- A terminal (depends on your OS!)
- [npm and NodeJS](https://www.npmjs.com/get-npm)
- [terraform v0.13.X](https://www.terraform.io/downloads.html)
- [An Amazon Web Service (AWS) Account](https://aws.amazon.com/)
    - Please note that a credit card is required
    - We will be working within the free tier of AWS but some small charges may occur
- [A Terraform Cloud Account (OPTIONAL)](https://app.terraform.io/)
    - Used for managing remote terraform backends

## Running the presentation
- Install reveal-md `npm install -g reveal-md`
- Run `reveal-md presentation.md`

## Legal
This workshop makes use of Amazon Web Services (AWS). AWS is a pay-for-use cloud platform. I've kept this workshop within the free tier of AWS but there is always a chance you will get charged for resources you provision out there. I'm not responsible for that so make sure you use the cloud responsibly! After the workshop, I highly recommend you tear down your resources so as to not incur any costs <3