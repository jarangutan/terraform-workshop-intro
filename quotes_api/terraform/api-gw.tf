resource "aws_api_gateway_rest_api" "quotes_api" {
  name        = "QuotesAPI"
  description = "API to store your favorite quotes from your team :)"
  body        = data.template_file.quotes_api_swagger.rendered
}

data "template_file" "quotes_api_swagger" {
  template = file("swagger.yaml")

  vars {
    get_lambda_arn  = aws_lambda_function.get_quotes.invoke_arn
    post_lambda_arn = aws_lambda_function.post_quotes.invoke_arn
  }
}

resource "aws_api_gateway_deployment" "quotes_api_deployment" {
  rest_api_id = aws_api_gateway_rest_api.quote_api.id
  stage_name  = "default"

  lifecycle {
    create_before_destroy = true
  }

  variables = {
    deployed_at = "${timestamp()}"
  }
}

output "api_url" {
  value = "${aws_api_gateway_deployment.quotes_api_deployment.invoke_url}/api"
}

