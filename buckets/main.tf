provider aws {
  region = var.region
}

locals {
  tags = {
    project = "terraform-workshop-intro"
    repo    = "https://github.com/jarangutan/terraform-workshop-intro"
    region  = var.region
    env     = var.env
  }
}

resource random_pet name {
  length    = 3
  separator = "-"
}

resource aws_s3_bucket bucket {
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

resource aws_s3_bucket_object website {
  acl          = "public-read"
  key          = "index.html"
  bucket       = aws_s3_bucket.bucket.id
  content      = file("${path.module}/assets/index.html")
  content_type = "text/html"
}