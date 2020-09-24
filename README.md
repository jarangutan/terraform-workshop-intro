# terraform-workshop-intro
Intro to terraform workshop covering the creation of a "terraform_backend" and a "lambda_api" using Amazon Web Services (AWS)

## What is in this repo?
### "terraform_backend/"
This tutorial covers how to set up the terraform S3/DynamoDB state backend in AWS for use with the lambda_api/

### "lambda_api/"
This is a "Hello World" lambda api tutorial covering the basics of provisioning app resources out in AWS with business logic

## Pre-requisites
- A terminal (depends on your OS!)
- [npm and NodeJS](https://www.npmjs.com/get-npm)
- [terraform v0.13.X](https://www.terraform.io/downloads.html)
- [An Amazon Web Service (AWS) Account](https://aws.amazon.com/)
    - Please note that a credit card is required
    - We will be working within the free tier of AWS but some small charges may occur

## Running the presentation
- Install reveal-md `npm install -g reveal-md`
- Run `reveal-md presentation.md`
