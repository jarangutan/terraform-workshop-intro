### IAM Policy
data "aws_iam_policy_document" "lambda_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

data "aws_iam_policy_document" "lambda_policy" {
  # Enable cloudwatch logs for lambda
  statement {
    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PugLogEvents",
      "logs:DescribeLogStreams"
    ]
    resources = ["arn:aws:logs:*:*:log-group:/aws/lambda/*/log-stream:*"]
  }

  statement {
    actions = [
      "dynamodb:BatchWriteItem",
      "dynamodb:DeleteItem",
      "dynamodb:PutItem",
      "dynamodb:UpdateItem"
    ]
    resources = [aws_dynamodb_table.quotes_table.arn]
  }
}

resource "aws_iam_role" "lambda_role" {
  name               = "quotes-lambda-role"
  description        = "Role for all quotes lambdas"
  assume_role_policy = data.aws_iam_policy_document.lambda_assume_role_policy.json
}

resource "aws_iam_policy" "lambda_policy" {
  name   = "quotes-lambda-policy"
  policy = data.aws_iam_policy_document.lambda_policy.json
}

resource "aws_iam_role_policy_attachment" "lambda_policy_attachment" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = aws_iam_policy.lambda_policy.arn
}

### Quotes Lambda
locals {
  quotes_file_name   = "quotes"
  quotes_lambda_name = "quotes-${quotes_file_name}"
}

data "archive_file" "quotes_zip" {
  type        = "zip"
  source_file = "../dist/${local.getQuote_file_name}.js"
  output_path = "../dist/${local.getQuote_file_name}.zip"
}

resource "aws_lambda_function" "quotes_lambda" {
  depends_on       = [aws_iam_role_policy_attachment.lambda_policy_attachment]
  filename         = "../dist/${local.getQuote_file_name}.zip"
  function_name    = local.getQuote_lambda_name
  role             = aws_iam_role.lambda_role.arn
  handler          = "${local.getQuote_file_name}.handler"
  source_code_hash = data.archive_file.get_quote_zip.output_base64sha256
  runtime          = "nodejs12.x"
  timeout          = "30"
}

# ### getQuotes Lambda
# locals {
#   getQuotes_file_name   = "getQuotes"
#   getQuotes_lambda_name = "quotes-${getQuotes_file_name}"
# }

# data "archive_file" "get_quotes_zip" {
#   type        = "zip"
#   source_file = "../dist/${local.getQuotes_file_name}.js"
#   output_path = "../dist/${local.getQuotes_file_name}.zip"
# }

# resource "aws_lambda_function" "get_quotes" {
#   depends_on       = [aws_iam_role_policy_attachment.lambda_policy_attachment]
#   filename         = "../dist/${local.getQuotes_file_name}.zip"
#   function_name    = local.getQuotes_lambda_name
#   role             = aws_iam_role.lambda_role.arn
#   handler          = "${local.getQuotes_file_name}.handler"
#   source_code_hash = data.archive_file.get_quotes_zip.output_base64sha256
#   runtime          = "nodejs12.x"
#   timeout          = "30"
# }

# ### postQuotes Lambda
# locals {
#   getQuotes_file_name   = "getQuotes"
#   getQuotes_lambda_name = "quotes-${getQuotes_file_name}"
# }

# data "archive_file" "get_quotes_zip" {
#   type        = "zip"
#   source_file = "../dist/${local.getQuotes_file_name}.js"
#   output_path = "../dist/${local.getQuotes_file_name}.zip"
# }

# resource "aws_lambda_function" "get_quotes" {
#   depends_on       = [aws_iam_role_policy_attachment.lambda_policy_attachment]
#   filename         = "../dist/${local.getQuotes_file_name}.zip"
#   function_name    = local.getQuotes_lambda_name
#   role             = aws_iam_role.lambda_role.arn
#   handler          = "${local.getQuotes_file_name}.handler"
#   source_code_hash = data.archive_file.get_quotes_zip.output_base64sha256
#   runtime          = "nodejs12.x"
#   timeout          = "30"
# }