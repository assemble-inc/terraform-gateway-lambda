module "lambda" {
  source                       = "assemble-inc/simple/lambda"
  lambda_source_path           = "${var.lambda_source_path}"
  lambda_handler               = "${var.lambda_handler}"
  lambda_runtime               = "${var.lambda_runtime}"
  lambda_timeout               = "${var.lambda_timeout}"
  lambda_environment_variables = "${var.lambda_environment_variables}"
  tags                         = "${var.tags}"
}

# Gateway
resource "aws_lambda_permission" "lambda_permission" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = "${module.lambda.function_name}"
  principal     = "apigateway.amazonaws.com"
  source_arn    = "arn:aws:execute-api:${var.region}:${data.aws_caller_identity.current.account_id}:${var.gateway_id}/*/${aws_api_gateway_method.gateway_method.http_method}${aws_api_gateway_resource.gateway_resource.path}"
}

resource "aws_api_gateway_integration" "lambda_getaway" {
  rest_api_id             = "${var.gateway_id}"
  resource_id             = "${aws_api_gateway_resource.gateway_resource.id}"
  http_method             = "${aws_api_gateway_method.gateway_method.http_method}"
  type                    = "AWS_PROXY"
  uri                     = "${module.lambda.invoke_arn}"
  integration_http_method = "${var.gateway_method}"
}

resource "aws_api_gateway_integration_response" "gateway_integration_response" {
  rest_api_id = "${var.gateway_id}"
  resource_id = "${aws_api_gateway_resource.gateway_resource.id}"
  http_method = "${aws_api_gateway_method.gateway_method.http_method}"
  status_code = "${aws_api_gateway_method_response.success_response.status_code}"
  depends_on  = ["aws_api_gateway_integration.lambda_getaway"]

  response_templates = {
    "application/json" = ""
  }
}

data "aws_caller_identity" "current" {}

resource "aws_api_gateway_resource" "gateway_resource" {
  rest_api_id = "${var.gateway_id}"
  parent_id   = "${var.gateway_parent_resource_id}"
  path_part   = "${var.gateway_path}"
}

resource "aws_api_gateway_method" "gateway_method" {
  rest_api_id      = "${var.gateway_id}"
  resource_id      = "${aws_api_gateway_resource.gateway_resource.id}"
  http_method      = "${var.gateway_method}"
  authorization    = "${var.gateway_authorization}"
  api_key_required = "${var.gateway_api_key_required}"
}

resource "aws_api_gateway_method_response" "success_response" {
  rest_api_id = "${var.gateway_id}"
  resource_id = "${aws_api_gateway_resource.gateway_resource.id}"
  http_method = "${aws_api_gateway_method.gateway_method.http_method}"
  status_code = "200"

  response_models = {
    "application/json" = "Empty"
  }
}
